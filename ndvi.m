
%definir directorio de trabajo
%setear en este directorio
%Nombre del Proceso
%se desean guardar las variables en .mat?savemat 0:no, 1:si
%INDICES={"NDVI","SR","DVI","SAVI","TNDI","NDWI","EVI","TGDVI"}
function [NDVI,SR,DVI,SAVI,TNDI,NDWI,EVI,TGDVI]=indices_vegetacion(BaseDir,MTLDIR,savemat,Nombre_Proceso,CorteX,CorteY,INDICES)
[n m]=size(INDICES)
%for --> case
cd(BaseDir);
var_mat=savemat;
Carpeta_output='Output';%salida, guardar resultados
i=1;
Landsat=5;
Carpeta_img=strcat(BaseDir,'/img_',Nombre_Proceso);
%Nombres bandas:[blue,green,red,NIR,SWIR,-]
hemisferio='S';
%reflactancia NIR 1
Banda=4;
[R_l(:,:,1),L_l(:,:,1),DN7(:,:,1),UTM,COD_SAT_IMG,INFO]=reflactancia(Banda,Landsat,Carpeta_img,MTLDIR,hemisferio,Nombre_Proceso,CorteX,CorteY);
%reflactancia ROJA 2
Banda=3;
[R_l(:,:,2),L_l(:,:,2),DN7(:,:,2),UTM,COD_SAT_IMG,INFO]=reflactancia(Banda,Landsat,Carpeta_img,MTLDIR,hemisferio,Nombre_Proceso,CorteX,CorteY);
%reflactancia AZUL 3
Banda=1;
[R_l(:,:,3),L_l(:,:,3),DN7(:,:,3),UTM,COD_SAT_IMG,INFO]=reflactancia(Banda,Landsat,Carpeta_img,MTLDIR,hemisferio,Nombre_Proceso,CorteX,CorteY);
%reflactancia SWIR 4
Banda=5;
[R_l(:,:,4),L_l(:,:,4),DN7(:,:,4),UTM,COD_SAT_IMG,INFO]=reflactancia(Banda,Landsat,Carpeta_img,MTLDIR,hemisferio,Nombre_Proceso,CorteX,CorteY);
NDVI=0;
SR=0;
DVI=0;
SAVI=0;
TNDI=0;
NDWI=0;
EVI=0;
TGDVI=0;
for i=1:n
   switch  INDICES{i}
       case 'NDVI'
            Numerador=R_l(:,:,1)-R_l(:,:,2);
            Denominador=R_l(:,:,1)+R_l(:,:,1);
            NDVI=Numerador./Denominador;
       case 'SR'
           SR=R_l(:,:,1)./R_l(:,:,2)
       case 'DVI'
           DVI=R_l(:,:,1).-R_l(:,:,2)
       case 'SAVI'
           L=0.5;
            Numerador=R_l(:,:,1)-R_l(:,:,2);
            Denominador=R_l(:,:,1)+R_l(:,:,2)+L;
           SAVI=(Numerador./Denominador)*(1+L); 
       case 'TNDI'
            Numerador=R_l(:,:,2)-R_l(:,:,1);
            Denominador=R_l(:,:,2)+R_l(:,:,1);
            pre_TNDI=(Numerador./Denominador) +0.5;
            TNDI=sqrt(pre_TNDI)
       case 'NDWI'
            Numerador=R_l(:,:,2)-R_l(:,:,4);
            Denominador=R_l(:,:,2)+R_l(:,:,4);
            NDVI=Numerador./Denominador;
       case 'EVI'
           G=2.5;
           L=1;
           C_1=6;
           C_2=7.5;
           Numerador=R_l(:,:,1)-R_l(:,:,2);
           Denominador=R_l(:,:,1)+C_1*R_l(:,:,4)-C_2*R_l(:,:,3)+L;
           NDVI=G*Numerador./Denominador;
       case 'TGDVI'            
            La_1=0.56e-6;%en metros
            La_2=0.66e-6;
            La_3=0.83e-6;            
            Numerador_1=R_l(:,:,1)-R_l(:,:,2);
            Denominador_1=La_3-La_2;            
            Numerador_2=R_l(:,:,2)-R_l(:,:,3);
            Denominador_2=La_2-La_1;            
            pre_TGDVI=Numerador_1./Denominador_1-Numerador_2./Denominador_2;
            %pasar a 0 valores menores que 0
            pre_TGDVI(pre_TGDVI<0)=0;
            TGDVI=pre_TGDVI;
            
   end


I=mat2gray(valor_NDVI,[-1 1]);
[I_16b,Map_16b]=gray2ind(I,65536);
Histograma=imhist(I_16b);
Bit_depth=16;%'BitDepth'= 16 bits
NDVI_16=uint16(valor_NDVI*65535);
savefile_TIF=strcat(Carpeta_output,'/',Nombre_Proceso,'/',COD_SAT_IMG,'_',INDICES{i},'.TIF');
%geotiffwrite(savefile_TIF,valor_NDVI,INFO,'GeoKeyDirectoryTag',UTM.geokey);
geotiffwrite(savefile_TIF,I_16b,INFO,'GeoKeyDirectoryTag',UTM.geokey);
%imwrite(I_16b,savefile_TIF,'tif');
%Info_tif=imfinfo(savefile_TIF);
savefile_PNG=strcat(Carpeta_output,'/',Nombre_Proceso,'/',COD_SAT_IMG,'_',INDICES{i},'.PNG');
imwrite(I_16b,savefile_PNG,'png');
Info_png=imfinfo(savefile_PNG);
end

if var_mat==1
savefile=strcat(Carpeta_output,'/',Nombre_Proceso,'/',COD_SAT_IMG'.mat');
save(savefile,'R_l','L_l','DN7','UTM');
end


end