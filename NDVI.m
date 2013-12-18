
%definir directorio de trabajo
%setear en este directorio
%Nombre del Proceso
%se desean guardar las variables en .mat?savemat 0:no, 1:si
function [NDVI]=ndvi(BaseDir,MLTDIR,savemat,Nombre_Proceso)
cd(BaseDir);
var_mat=savemat;
Carpeta_output='Output';%salida, guardar resultados
i=1;
Landsat=5;
Carpeta_img=strcat(directorio,'/img_',Nombre_Proceso);
hemisferio='S';
Banda=4;
[R_l(:,:,1),L_l(:,:,1),DN7(:,:,1),UTM,COD_SAT_IMG,INFO]=reflactancia(Banda,Landsat,Carpeta_img,hemisferio,Nombre_Proceso);
Banda=3;
[R_l(:,:,2),L_l(:,:,2),DN7(:,:,2),UTM,COD_SAT_IMG,INFO]=reflactancia(Banda,Landsat,Carpeta_img,hemisferio,Nombre_Proceso);
Numerador=R_l(:,:,2)-R_l(:,:,1);
Denominador=R_l(:,:,2)+R_l(:,:,1);
valor_NDVI=Numerador./Denominador;
if var_mat==1
savefile=strcat(Carpeta_output,'/',Nombre_Proceso,'/',COD_SAT_IMG,'.mat');
save(savefile,'R_l','L_l','DN7','UTM');
end
I=mat2gray(valor_NDVI,[-1 1]);
[I_16b,Map_16b]=gray2ind(I,65536);
Histograma=imhist(I_16b);
Bit_depth=16;%'BitDepth'= 16 bits
NDVI_16=uint16(valor_NDVI*65535);
savefile_TIF=strcat(Carpeta_output,'/',Nombre_Proceso,'/',COD_SAT_IMG,'.TIF');
%geotiffwrite(savefile_TIF,valor_NDVI,INFO,'GeoKeyDirectoryTag',UTM.geokey);
geotiffwrite(savefile_TIF,I_16b,INFO,'GeoKeyDirectoryTag',UTM.geokey);
%imwrite(I_16b,savefile_TIF,'tif');
%Info_tif=imfinfo(savefile_TIF);
savefile_PNG=strcat(Carpeta_output,'/',Nombre_Proceso,'/',COD_SAT_IMG,'.PNG');
imwrite(I_16b,savefile_PNG,'png');
Info_png=imfinfo(savefile_PNG);
end