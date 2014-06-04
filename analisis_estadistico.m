%%definir el directorio y  nombres de archivos que contienen el min-max de
%%cada imagen en particular
%%se carga como un objeto: Indice.{lista_nombre,lista_min,lista_max}
%%directorio
    directorio='/home/david/Documents/Proyectos_CEA/CNM008/Codigo_Mat/Output/';
    proyecto='ANG006_IMG';
  directorio_tiff= strcat(directorio,proyecto,'/TIFF/');
    indices={'ii','msi','ndvi','ndwi','savi_03','savi_05','sr'};
%%indices a analizar
    ind_analisis=3;%o [3 5 7] por ejemplo
    minmax_i=1;

for g=1:length(ind_analisis)
    Atiff=[];
    Ltidd=[];
    Lista_tiff=[];%en cada iteracion se vacia
%%realizar un analisis para cada indice requerido
    string_indice=indices{g};    
    %Leer cada archivo de carpeta tiff indice
    %obtener la lista de archivos .tif en directorio
    %find  -iname "*.txt"
    %buscar solo en este directorio:
    cd(directorio_tiff);
    [Atiff, Ltiff]=unix(['find  -maxdepth 1 -iname  "*_',upper(string_indice),'.tif"']); 
    %otra busqueda, con detalle de cuadrante, en caso de trabajar con varios cuadrantes en proyecto:
    %Nro_cuadrante=233083 %en anglo
    %[Atiff2, Ltiff2]=unix(['find  -maxdepth 1 -iname  "*',Nro_cuadrante,'*_NDVI.tif"']);
    files_tiff= strfind(Ltiff,'.tif');
    %tomar el nombre como string
    cantidad_archivos_tiff=length(files_tiff);
    Lista_tiff{1}=L(3:files_tiff(1)-1);    
    for i=2:cantidad_archivos_tiff
        Lista_tiff{i}=L(files_tiff(i-1)+7:files_tiff(i)-1);    
    end
    [L_fil_tiff,L_col_tiff]=size(Lista_tiff); %entrega largo de lista, tomando L_col
%ya no es necesario, se selecciona con antelacion < %recortar el valor de
%indice>
    %buscar primero '_' de cada indice
    
%     for j=1:L_col_tiff
%         posicion_indice = strfind(Lista_tiff{i},'_');
%         indice_actual =  Lista_tiff{i}(posicion_indice(1)+1:end);
%         posicion_indice=[];
%     %pasar string a minuscula
%         indice_actual_lower=lower(indice_actual);
    %asignar a cada indice un valor de indice, que seria la posición de cada
    %indice en la lista objeto
    %indices={'ii','msi','ndvi','ndwi','savi_03','savi_05','sr'};
    %end
    %</%recortar el valor de
%indice>  
%componer el nombre del archivo minmax a leer
archivo_minmax_leer=strcat(directorio,proyecto,'_',string_indice);    
%buscar para el indice en particular el valor min-max
       %find  -maxdepth 1 -iname  "*.txt" 
       %entre lista de archivos en directorio
% ./ANG006_IMG_msi.txt
% ./ANG006_IMG_ndwi.txt
% ./ANG006_IMG_ndvi.txt
% ./ANG006_IMG_savi_05.txt
% ./ANG006_IMG_savi_03.txt
% ./ANG006_IMG_ii.txt
% ./ANG006_IMG_sr.txt
cd(directorio);
%No es necesario, se define en base a cada indice requerido.
% [A L]=unix(['find  -maxdepth 1 -iname  "',archivo_minmax_leer,'.txt" ']); %entrega 0 y la lista de arriba
% %guardar lista de nombres de archivo en:
% files_ind= strfind(L,'.txt');
% cantidad_archivos=length(files_ind)
% Lista{1}=L(3:files_ind(1)-1);    
% for i=2:cantidad_archivos
%     Lista{i}=L(files_ind(i-1)+7:files_ind(i)-1);    
% %leer archivos y cargar como estrcutura de listas
% 
% %tomar una lista adecuada y buscar dentro el archivo
%     if strcomp(,archivo_minmax_leer)
%         %leer archivo
%         
%     end    
% %pasar el valor min y max de string a numero
% end
% 
% 
% [L_fil,L_col]=size(Lista); %entrega largo de lista, tomando L_col
% 
% %usar la formular x(z)=z*(b-a)/(2^n-1)) + a (obtenida en
% %manual_conversion_indice)

%se debe leer el archivo archivo_minmax_leer,'.txt"
fid=fopen([archivo_minmax_leer,'.txt'],'r');
%%cargar datos en listas
coma=',';%Caracter de separacion CSV
indice_imagen=[];
%se genera una estructura que puede contener los valores minmax de todos
%los indices analizados
indice_imagen.indice{g}=string_indice;
indice_imagen.rangos{g}(1)={minmax_i};
while ~feof(fid)
    leer_linea=fgetl(fid);
    puntos_corte=strfind(leer_linea,coma);
    indice_imagen.ID{minmax_i}=leer_linea(1:puntos_corte(1)-1);
    indice_imagen.minimo{minmax_i}=leer_linea(puntos_corte(1)+1:puntos_corte(2)-1);
    indice_imagen.maximo{minmax_i}=leer_linea(puntos_corte(2)+1:end);
    minmax_i=minmax_i+1;
end
indice_imagen.rangos{g}(2)={minmax_i-1};%valores se rescatan con: cell2mat(ans)
%http://www.mathworks.com/help/matlab/ref/cell2mat.html
%esto podria ser en parelelo (para cuando se pueda)
%ciclo de lectura de datos, leer cada imagen, buscar datos minmax de cada
%imagen
%usando geotiffreader.---> corte imagen
%se tiene una lista de puntos ubicados dentro de la imagen a leer.
%para el caso en que ahora se requieren sacar varias imagenens de una misma
%foto no es la solucion mas eficiente, ya que cada vez que saca un nuevo
%corte lee y carga el archivo para entregar cada una de ellas como valor
%matricial
%Por lo tanto hay que modificaar la funcion para que UTM_x y UTM_y sean una
%lista de posiciones y no un solo valor, asi se puede ahorrar calculo. Se
%propone corte_imagen_multi
%[IMc, Rc, X ,R , INFO]=corte_imagen(BaseDir,File,UTM_x,UTM_y)


%en directorio_tiff
%tomando nombre de archivo de Lista_tiff
%generar un valor correpondiente a porcentajes de analisis:
porcentajes=[0.5,0.6,0.7,0.8];


end %obtener nombre archivo

%los valores a transformar son cada a% para hacer histograma de barras
p_h=[=:.05:1];
%analizar histograma y seccionar cada intervalor para entregar bloques.

%guardar parametros estadistics

%limpiar imagen cargada

%volver a leer otra imagen