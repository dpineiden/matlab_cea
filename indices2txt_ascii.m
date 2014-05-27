clear
%leer directorio en que se encuentran las imágenes:
BaseDir='/home/david/Documents/Proyectos_CEA/CNM008/Codigo_Mat';
MatDir='/home/david/Documents/Proyectos_CEA/CNM008/Codigo_Mat/Output/ANG006_IMG/Mat_Matlab';
XYZdata='/home/david/Documents/Proyectos_CEA/CNM008/Codigo_Mat/Output/ANG006_IMG'
cd(MatDir);
Proyecto='ANG006';
[A lista]=unix(['find -name "*.mat"']);
RutaLog=[BaseDir,'/Logs'];
archivos_MAT=['archivos_MAT_' Proyecto '.txt'];
%se crea archivo txt con listado de .mat del grupo
FID=fopen([RutaLog,'/',archivos_MAT],'w+');
fprintf(FID,lista);
fclose(FID);
%se lee el archivo anterior
charMAT='_.mat';
fid=fopen([RutaLog,'/',archivos_MAT],'r');
MAT=0
MATset={};
while ~feof(fid)
    leer_linea=fgetl(fid);
    cola=leer_linea(end-3:end);
    ArchivoMat=leer_linea(3:end);
    %cargar archivo .mat
    PathMat=[MatDir '/' ArchivoMat];
    load(PathMat);
    names = fieldnames(IndiceVegetacion);
    [n,m]=size(names);
    %ver que no tenga ceros all(indice(:))==1
    for i=1:n
        indicename= char( names( i ) );
        indice=getfield(IndiceVegetacion, indicename);
        if all(indice(:))==1
       % FileName= INFO.nir.Filename
        NameFile=[ArchivoMat(1:end-4) '_' indicename]; 
        p=R.nir.DeltaX;
        XLimWorld=R.nir.XLimWorld;
        YLimWorld=R.nir.YLimWorld;
        [v_iv,v_lat,v_lon]=map2vector(indice,p,XLimWorld,YLimWorld);
        GEO_data=map_vector2ascii(v_iv,v_lat,v_lon,XYZdata,NameFile);
        end
    end
    
    
    %se descomprime aqui el archivo (dentro de carpeta)
end
fclose(fid);