INDICES={'NDVI','SR','NDWI','SAVI','MSI','II'};
Carpeta_output='Output';
%INDICES={'NDVI','NDWI'};
%programa que lee línea a línea el LOG MTL
BaseDir='/home/david/Documents/Proyectos_CEA/CNM008/Codigo_Mat'
LogTXT='/home/david/Documents/Proyectos_CEA/CNM008/Codigo_Mat/Logs/archivos_MTL_ANG006_IMG.txt';
FID=fopen(LogTXT,'r');
UTM_x=[372560,387500];
%si entregan datos en UTM sur se deben convertir a norte ya que landsat
%entrega en UTM norte
UTM_y=[6328630,6307300]-10000000;
I=1;
tic
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

nombres=desmembrar(INFO.nir.Filename,'/');
COD_SAT_IMG=char(nombres(length(nombres)-1));
BitDepth=16;
%guarda imagen NDVI
Im=1;
 IM=mat2gray(IndiceVegetacion.NDVI,[min(IndiceVegetacion.NDVI(:)) max(IndiceVegetacion.NDVI(:))]); 
Lista_NDVI{I,:}={COD_SAT_IMG,',',min(IndiceVegetacion.NDVI(:)),',',max(IndiceVegetacion.NDVI(:))};
 %IM=mat2gray(IndiceVegetacion.NDVI,[-1 1]); 
 [Ib,Mapb]=gray2ind(IM,2^BitDepth);
  savefile_TIF=strcat(BaseDir,'/',Carpeta_output,'/',Nombre_Proceso,'/TIFF/',COD_SAT_IMG,'_',INDICES{1});
  geotiffwrite(savefile_TIF,Ib,R.nir,'GeoKeyDirectoryTag',UTM.geokey); 

IM=[];
Ib=[];
 %guarda imagen SR
 Im=2 ;
 IM=mat2gray(IndiceVegetacion.SR,[min(IndiceVegetacion.SR(:)) max(IndiceVegetacion.SR(:))]); 
 Lista_SR{I,:}={COD_SAT_IMG,',',min(IndiceVegetacion.SR(:)),',',max(IndiceVegetacion.SR(:))};
 %IM=mat2gray(IndiceVegetacion.SR,[0 2^BitDepth]); 
 [Ib,Mapb]=gray2ind(IM,2^BitDepth);
  savefile_TIF=strcat(BaseDir,'/',Carpeta_output,'/',Nombre_Proceso,'/TIFF/',COD_SAT_IMG,'_',INDICES{2});
  geotiffwrite(savefile_TIF,Ib,R.nir,'GeoKeyDirectoryTag',UTM.geokey); 


  IM=[];
Ib=[];
  %guarda imagen NDWI
  Im=3;
  IM=mat2gray(IndiceVegetacion.NDWI,[min(IndiceVegetacion.NDWI(:)) max(IndiceVegetacion.NDWI(:))]); 
  Lista_NDWI{I,:}={COD_SAT_IMG,',',min(IndiceVegetacion.NDWI(:)),',',max(IndiceVegetacion.NDWI(:))};
 %IM=mat2gray(IndiceVegetacion.NDWI,[-1 1]); 
 [Ib,Mapb]=gray2ind(IM,2^BitDepth);
  savefile_TIF=strcat(BaseDir,'/',Carpeta_output,'/',Nombre_Proceso,'/TIFF/',COD_SAT_IMG,'_',INDICES{3});
  geotiffwrite(savefile_TIF,Ib,R.nir,'GeoKeyDirectoryTag',UTM.geokey); 

  IM=[];
Ib=[];
  %guarda imagen SAVI 0.3
  Im=4;
  IM=mat2gray(IndiceVegetacion.SAVI_03,[min(IndiceVegetacion.SAVI_03) max(IndiceVegetacion.SAVI_03)]); 
  Lista_SAVI_03{I,:}={COD_SAT_IMG,',',min(IndiceVegetacion.SAVI_03),',',max(IndiceVegetacion.SAVI_03)};
 %IM=mat2gray(IndiceVegetacion.NDWI,[-1 1]); 
 [Ib,Mapb]=gray2ind(IM,2^BitDepth);
  savefile_TIF=strcat(BaseDir,'/',Carpeta_output,'/',Nombre_Proceso,'/TIFF/',COD_SAT_IMG,'_',INDICES{4},'_03');
  geotiffwrite(savefile_TIF,Ib,R.nir,'GeoKeyDirectoryTag',UTM.geokey); 
  
  IM=[];
Ib=[];
  %guarda imagen SAVI 0.5
  Im=5;
  IM=mat2gray(IndiceVegetacion.SAVI_05,[min(IndiceVegetacion.SAVI_05) max(IndiceVegetacion.SAVI_05)]); 
  Lista_SAVI_05{I,:}={COD_SAT_IMG,',',min(IndiceVegetacion.SAVI_05),',',max(IndiceVegetacion.SAVI_05)};
 %IM=mat2gray(IndiceVegetacion.NDWI,[-1 1]); 
 [Ib,Mapb]=gray2ind(IM,2^BitDepth);
  savefile_TIF=strcat(BaseDir,'/',Carpeta_output,'/',Nombre_Proceso,'/TIFF/',COD_SAT_IMG,'_',INDICES{4},'_05');
  geotiffwrite(savefile_TIF,Ib,R.nir,'GeoKeyDirectoryTag',UTM.geokey); 
  
    IM=[];
Ib=[];
  %guarda imagen MSI
  Im=6;
  IM=mat2gray(IndiceVegetacion.MSI,[min(IndiceVegetacion.MSI(:)) max(IndiceVegetacion.MSI(:))]); 
  Lista_MSI{I,:}={COD_SAT_IMG,',',min(IndiceVegetacion.MSI(:)),',',max(IndiceVegetacion.MSI(:))};
 %IM=mat2gray(IndiceVegetacion.NDWI,[-1 1]); 
 [Ib,Mapb]=gray2ind(IM,2^BitDepth);
  savefile_TIF=strcat(BaseDir,'/',Carpeta_output,'/',Nombre_Proceso,'/TIFF/',COD_SAT_IMG,'_',INDICES{5});
  geotiffwrite(savefile_TIF,Ib,R.nir,'GeoKeyDirectoryTag',UTM.geokey); 

    IM=[];
Ib=[];
  %guarda imagen II
  Im=7;
  IM=mat2gray(IndiceVegetacion.II,[min(IndiceVegetacion.II(:)) max(IndiceVegetacion.II(:))]); 
  Lista_II{I,:}={COD_SAT_IMG,',',min(IndiceVegetacion.II(:)),',',max(IndiceVegetacion.II(:))};
 %IM=mat2gray(IndiceVegetacion.NDWI,[-1 1]); 
 [Ib,Mapb]=gray2ind(IM,2^BitDepth);
  savefile_TIF=strcat(BaseDir,'/',Carpeta_output,'/',Nombre_Proceso,'/TIFF/',COD_SAT_IMG,'_',INDICES{6});
  geotiffwrite(savefile_TIF,Ib,R.nir,'GeoKeyDirectoryTag',UTM.geokey); 
  
  I=I+1;

  
end

  savefile_ndvi=strcat(BaseDir,'/',Carpeta_output,'/',Nombre_Proceso,'_ndvi');
  savefile_sr=strcat(BaseDir,'/',Carpeta_output,'/',Nombre_Proceso,'_sr');
  savefile_ndwi=strcat(BaseDir,'/',Carpeta_output,'/',Nombre_Proceso,'_ndwi');  
    savefile_savi_03=strcat(BaseDir,'/',Carpeta_output,'/',Nombre_Proceso,'_savi_03');
    savefile_savi_05=strcat(BaseDir,'/',Carpeta_output,'/',Nombre_Proceso,'_savi_05');
    savefile_msi=strcat(BaseDir,'/',Carpeta_output,'/',Nombre_Proceso,'_msi');
  savefile_ii=strcat(BaseDir,'/',Carpeta_output,'/',Nombre_Proceso,'_ii');

for i=1:I-1
FID_ndvi=fopen(savefile_ndvi,'a+');
FID_sr=fopen(savefile_sr,'a+');
FID_ndwi=fopen(savefile_ndwi,'a+');
FID_savi_03=fopen(savefile_savi_03,'a+');
FID_savi_05=fopen(savefile_savi_05,'a+');
FID_msi=fopen(savefile_msi,'a+');
FID_ii=fopen(savefile_ii,'a+');

fprintf(FID_ndvi,'%s\n',[Lista_NDVI{i,1}{1} Lista_NDVI{i,1}{2} num2str(Lista_NDVI{i,1}{3}) Lista_NDVI{i,1}{4} num2str(Lista_NDVI{i,1}{5})]);
fprintf(FID_sr,'%s\n',[Lista_SR{i,1}{1} Lista_SR{i,1}{2} num2str(Lista_SR{i,1}{3}) Lista_SR{i,1}{4} num2str(Lista_SR{i,1}{5})]);
fprintf(FID_ndwi,'%s\n',[Lista_NDWI{i,1}{1} Lista_NDWI{i,1}{2} num2str(Lista_NDWI{i,1}{3}) Lista_NDWI{i,1}{4} num2str(Lista_NDWI{i,1}{5})]);
fprintf(FID_savi_03,'%s\n',[Lista_SAVI_03{i,1}{1} Lista_SAVI_03{i,1}{2} num2str(Lista_SAVI_03{i,1}{3}) Lista_SAVI_03{i,1}{4} num2str(Lista_SAVI_03{i,1}{5})]);
fprintf(FID_savi_05,'%s\n',[Lista_SAVI_05{i,1}{1} Lista_SAVI_05{i,1}{2} num2str(Lista_SAVI_05{i,1}{3}) Lista_SAVI_05{i,1}{4} num2str(Lista_SAVI_05{i,1}{5})]);
fprintf(FID_msi,'%s\n',[Lista_MSI{i,1}{1} Lista_MSI{i,1}{2} num2str(Lista_MSI{i,1}{3}) Lista_MSI{i,1}{4} num2str(Lista_MSI{i,1}{5})]);
fprintf(FID_ii,'%s\n',[Lista_II{i,1}{1} Lista_II{i,1}{2} num2str(Lista_II{i,1}{3}) Lista_II{i,1}{4} num2str(Lista_II{i,1}{5})]);

fclose(FID_ndvi);  
fclose(FID_sr);
fclose(FID_ndwi);
fclose(FID_savi_03);
fclose(FID_savi_05);  
fclose(FID_msi);
fclose(FID_ii);
end


toc
