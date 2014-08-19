%INDICES={'NDVI','SR','NDWI','SAVI_03','MSI','II','NDSI'};%
INDICES={'NDVI'};%
Carpeta_output='Output';
%INDICES={'NDVI','NDWI'};
%programa que lee línea a línea el LOG MTL
BaseDir='/home/david/Documents/Proyectos_CEA/CNM008/Codigo_Mat';
LogTXT='/home/david/Documents/Proyectos_CEA/CNM008/Codigo_Mat/Logs/archivos_MTL_ANG006_IMG.txt';
FID=fopen(LogTXT,'r');
UTM_x=[372560,387500];
%si entregan datos en UTM sur se deben convertir a norte ya que landsat
%entrega en UTM norte
UTM_y=[6328630,6307300]-10000000;
I=1;
tic
Lista=[];
while ~feof(FID)    
        leer_linea=fgetl(FID); 
File='/home/david/Documents/Proyectos_CEA/CNM008/Codigo_Mat/img_ANG006_IMG/IMG';
Ruta='/home/david/Documents/Proyectos_CEA/CNM008/Codigo_Mat/img_ANG006_IMG/IMG';
Nombre_Proceso='ANG006_IMG';
des=desmembrar(leer_linea,'/');
[dn,dm]=size(des);
MTLDIR=['/home/david/Documents/Proyectos_CEA/CNM008/Codigo_Mat/img_ANG006_IMG/IMG/' char(des(dn-1,1))];
savemat=1; 
[IndiceVegetacion, INFO,R,UTM,R_l]=indices_vegetacion(BaseDir,MTLDIR,savemat,Nombre_Proceso,UTM_x,UTM_y,INDICES);
IM=[];
Ib=[];
UTM.geokey.GTRasterTypeGeoKey=1;
indice=[];
BitDepth=16;
for i=1:length(INDICES)
nombre_indice=str2mat(INDICES(i));
indice=getfield(IndiceVegetacion,nombre_indice);
nombres=desmembrar(INFO.nir.Filename,'/');
COD_SAT_IMG=char(nombres(length(nombres)-1));
%guarda imagen indice
Im=1;
IM=mat2gray(indice,[min(indice(:)) max(indice(:))]);  
 %IM=mat2gray(IndiceVegetacion.NDVI,[-1 1]); 
[Ib,Mapb]=gray2ind(IM,2^BitDepth);
savefile_TIF=strcat(BaseDir,'/',Carpeta_output,'/',Nombre_Proceso,'/TIFF/',COD_SAT_IMG,'_',nombre_indice);
geotiffwrite(savefile_TIF,Ib,R.nir,'GeoKeyDirectoryTag',UTM.geokey); 
Insert=[COD_SAT_IMG,',',num2str(min(indice(:))),',',num2str(max(indice(:)))];%genero un string de nombre min max
Lista=setfield(Lista,{I,1},nombre_indice,Insert);%j aumenta una posicion del valor
indice=[];
end
I=I+1;%al final entrega cantidad de imagenes rescatadas
end
%usar S=setfield(S,{2,1},'b',{2},1) para setear un nuevo campo en arreglo
savefile=[];
% I=1
for i=1:length(INDICES)
    nombre=strcat(BaseDir,'/',Carpeta_output,'/',Nombre_Proceso,'_',INDICES{i},'.txt');
    savefile=setfield(savefile,{1,1},INDICES{i},{1},{nombre});
end
%guardar files min max por indice
FID=[]
for i=1:I-1
    for j=1:length(INDICES)            
        nombre_indice=str2mat(INDICES(j));
       FID=setfield(FID,{i,1},INDICES{j},fopen(cell2mat(getfield(savefile,INDICES{j})),'a+'));
       %se guardan los valores min max de cada indice para cada imagen
       GF_lista=getfield(Lista(i),nombre_indice);
       fprintf(getfield(FID,INDICES{j}),'%s\n',GF_lista); 
       fclose(getfield(FID,nombre_indice));        
    end
end
toc
