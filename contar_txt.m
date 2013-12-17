%obtener lista de archivos en Directorio_Padre/Logs
function h=contar_txt(Directorio_Padre,hijo)
cd(Directorio_Padre)
cd('..')
BaseDir=pwd
Log='Logs';
Ruta=strcat(BaseDir,'/',Log);
type='*.txt';
%mientras, se actualiza la lista de txt hasta que ya no hay mas archivos
%adicionales
%ingresar un contador o registro de archivos ya iterados.
%se obtiene una lista con los nombres de los archivos txt
out=get_list_files(Ruta,type);
[n1 m1]=size(out);
str='_';
base_name='lista_nivel_';
h=0;
for i=1:m1
    cada_archivo=out{1,i};
    if strcmp(cada_archivo(1:length(base_name)),base_name)
        k_str=strfind(cada_archivo,str);
        %punto a partir del cual dice 'hijo' o 'directorios'
        N_k=k_str(3)+1;
        if strcmp(cada_archivo(N_k:N_k+length(hijo)-1),hijo)
            h=h+1;
        end
    end
end

end