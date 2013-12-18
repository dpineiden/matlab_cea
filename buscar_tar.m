BaseDir='/home/david/Documents/Proyectos_CEA/CNM008/Codigo_Mat';
Directorio='img_ZonaControl';
DirectorioFin='img_proyecto';
Directorio_Padre=[BaseDir,'/',Directorio];
[A lista]=unix(['find ',Directorio_Padre,' -name *.tar.gz']);
%guardar lista en archivos
archivos_targz='archivos_targz.txt';
RutaLog=[BaseDir,'/Logs'];
FID=fopen([RutaLog,'/',archivos_targz],'w+');
fprintf(FID,lista);
fclose(FID);
%leer cada linea  descomprimir en img_Proyecto
%se abre archivo para leer
NewDir=DirectorioFin;
unix(['mkdir ',BaseDir,'/',NewDir]);
fid=fopen([RutaLog,'/',archivos_targz],'r');
while ~feof(fid)
    cd(BaseDir);
    leer_linea=fgetl(FID); 
    indice=1;
    nombre=desmembrar(leer_linea,'/');
    [a b]=size(nombre);
    for j=1:a
        if strcmp(nombre{j,1},Directorio)
            indice=j;
        end
    end
    cd(NewDir)
    for j=indice+1:a-1        
        unix(['mkdir ',nombre{j,1}]);
        cd(nombre{j,1});
    end
        nombre_toma=nombre{a,1};
        unix(['mkdir ',nombre_toma(1:length(nombre_toma)-7)]);
        cd(nombre_toma(1:length(nombre_toma)-7));
    %se han creado las carpetas
    %se descomprime aqui el archivo (dentro de carpeta)
    unix(['tar -xvf ',leer_linea]); 
    
end
fclose(fid);