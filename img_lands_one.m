Ruta='/home/david/Documents/Proyectos_CEA/CNM008/Codigo_Mat/img_ANG006_IMG/IMG/'
cd(Ruta);
pwd
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
Rc=[];
while ~feof(FID)    
leer_linea=fgetl(FID); 
File='/home/david/Documents/Proyectos_CEA/CNM008/Codigo_Mat/img_ANG006_IMG/IMG';
TOTDIR='/home/david/Documents/Proyectos_CEA/CNM008/Codigo_Mat/img_ANG006_IMG/TOT/';
Ruta='/home/david/Documents/Proyectos_CEA/CNM008/Codigo_Mat/img_ANG006_IMG/IMG';
Nombre_Proceso='ANG006_IMG';
dese=desmembrar(leer_linea,'/');
[dn,dm]=size(dese);
name_des=char(cellstr(dese(dn-1:1)))
set_DIR=['/home/david/Documents/Proyectos_CEA/CNM008/Codigo_Mat/img_ANG006_IMG/IMG/',name_des]
cd(set_DIR)
set_DIR
pwd
%'listar tif en carpeta
[A,L]=unix('find -name "*.TIF"');
des=desmembrar(L,'./');
[nd,md]=size(des);
%usar L{i}(2:end) para extraer nombre de archivo
%nd=1
I=zeros(711,498,nd);
for i=1:nd

%'leer cada imagen tif
%'cortar cada imagen tif
name=char(cellstr(des{i}(2:end)));
FileName=[set_DIR '/' name];
if ~strcmp(UTM_x,'') || ~strcmp(CorteY,'')    
%filtrar y omitir banda 6 que es mas densa
Rx=Rc
[IMc,Rc, X, R, INFOx]=corte_imagen(BaseDir,FileName,UTM_x,UTM_y);
[n,m]=size(IMc);
end
bla=char(desmembrar(name,'_'));
banda=bla(1:end-4);
switch banda
    case 'B1'
        capa=1;
    case 'B2'
                capa=2;
    case 'B3'
                capa=3;
    case 'B4'
                capa=4;
    case 'B5'
                capa=5;
    case 'B6'
                capa=6;
    case 'B7'
                capa=7;
    case 'B8'
                capa=8;
    case 'B9'
                capa=9;
    case 'B10'
                capa=10;
    case 'B11'
                capa=11;
    case 'BQA'
                capa=12;
end


[n,m]=size(IMc)
ele_banda=banda
comparacion=~strcmp(char(banda),'B8')
%si n!=711 && m!=498
%cambiar el condicional, ya que no se sabe cuales son las capas que
%corresponden,esto en caso de que salga error de calclula en esta ocasion
if ~strcmp(char(banda),'B8')    
I(:,:,capa)=IMc;
else    
%'guardar nueva imagen cortada
Rc=Rx;
end

end


%guardar imagen en TIFF con geodatos
filename = [TOTDIR name];
%imwrite(I,filename,'tif')
%K = mat2gray(IMc);
INFOx.GeoTIFFTags.GeoKeyDirectoryTag.GTRasterTypeGeoKey=1
geotiffwrite(filename, I, Rc,'GeoKeyDirectoryTag', INFOx.GeoTIFFTags.GeoKeyDirectoryTag);

end

toc