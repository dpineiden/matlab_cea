clear
%%definir el directorio y  nombres de archivos que contienen el min-max de
%%cada imagen en particular
%%se carga como un objeto: Indice.{lista_nombre,lista_min,lista_max}
%%directorio
    directorio='/home/david/Documents/Proyectos_CEA/CNM008/Codigo_Mat/Output/';
    proyecto='ANG006_IMG';
  directorio_tiff= strcat(directorio,proyecto,'/TIFF/');
    indices={'ii','msi','ndvi','ndwi','savi_03','savi_05','sr'};
    %%indices a analizar
    ind_analisis=[3 4 5];%o [3 5 7] equivale a: ndvi ,savi_03 y sr
    minmax_i=1;
    %entregar lisas UTM_X UTM_y (ej 3 recuadros)
    Secciones={1,2,3,5,7};
    UTM_x={[381050,381532],[380206,380770],[378315,378992],[381802,382351],[378602,380279]};
    UTM_y={[6323758,6323272]-10000000,[6320748,6320122]-10000000,[6317251,6316736]-10000000,[6316828,6316749]-10000000,[6312260,6310918]-10000000};
    %tamaño
    [n_UTMx, m_UTMx]=size(UTM_x);
    %generar un valor correpondiente a porcentajes de analisis:
    porcentajes=[0.5,0.6,0.7,0.8];

    %los valores a transformar son cada a% para hacer histograma de barras
    p_h=[0:.05:1];

%etapa extracción de datos    
    
for g=1:length(ind_analisis)
    Atiff=[];
    Ltidd=[];
    Lista_tiff=[];%en cada iteracion se vacia
%%realizar un analisis para cada indice requerido    
    string_indice=indices{ind_analisis(g)};    
    %Leer cada archivo de carpeta tiff indice
    %obtener la lista de archivos .tif en directorio
    %find  -iname "*.txt"
    %buscar solo en este directorio:
    cd(directorio_tiff);
    [Atiff, Ltiff]=unix(['find  -maxdepth 1 -iname  "*_',upper(string_indice),'.tif"']);
    %otra busqueda, con detalle de cuadrante, en caso de trabajar con varios cuadrantes en proyecto:
    %Nro_cuadrante=233083 %en anglo
    %[Atiff2, Ltiff2]=unix(['find  -maxdepth 1 -iname  "*',Nro_cuadrante,'*_',upper(string_indice),'.tif"']);
    files_tiff= strfind(Ltiff,'.tif');
    %tomar el nombre como string
    cantidad_archivos_tiff=length(files_tiff);
    Lista_tiff{1}=Ltiff(3:files_tiff(1)-1);    
    for i=2:cantidad_archivos_tiff
        Lista_tiff{i}=str2num(Ltiff(files_tiff(i-1)+7:files_tiff(i)-1));    
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
    cd(directorio);
    fid=fopen([archivo_minmax_leer,'.txt'],'r');
%%cargar datos en listas
    coma=',';%Caracter de separacion CSV
%se genera una estructura que puede contener los valores minmax de todos
%los indices analizados
    minmax_i=1;
    indice_imagen.indice{g}=string_indice;
    indice_imagen.indice{g}.rango(1)={minmax_i};
    while ~feof(fid)
        leer_linea=fgetl(fid);
        puntos_corte=strfind(leer_linea,coma);
        indice_imagen.indice{g}.ID{minmax_i}=leer_linea(1:puntos_corte(1)-1);
        indice_imagen.indice{g}.minimo{minmax_i}=leer_linea(puntos_corte(1)+1:puntos_corte(2)-1);
        indice_imagen.indice{g}.maximo{minmax_i}=leer_linea(puntos_corte(2)+1:end);
        minmax_i=minmax_i+1;
    end
    indice_imagen.indice{g}.rango(2)={minmax_i-1};%valores se rescatan con: cell2mat(ans)
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

%--->%leer con geotiffreader
%procesar con corte_imagen_multi
    cd(directorio_tiff);
    nombre_archivo=[];
    intervalo=cell2mat(indice_imagen.indice{g}.rango(1)):cell2mat(indice_imagen.indice{g}.rango(2));
    [in, im]=size(intervalo);
    for t=intervalo
        ID=indice_imagen.indice{g}.ID{t};
        nombre_archivo = [indice_imagen.indice{g}.ID{t},'_',upper(string_indice),'.tif'];   
        [corte_multi_last, X_last ,R_last , INFO_last]=corte_imagen_multi(directorio_tiff,nombre_archivo,UTM_x,UTM_y);
        corte_multi_last;
        corte_multi.indice{g}.nombre{t,:}=ID;
        corte_multi.indice{g}.Rc{t,:}=corte_multi_last.Rc;
        corte_multi.indice{g}.imagen{t,:}=corte_multi_last.imagen;        
%tamaño de corte_multi: por elemento se tiene una cantidad de valores igual
%a la cantidad de cortes requeridos. m_UTMx
%elementos: 
% corte_multi.imagen{g}
% corte_multi.Rc{g}
% corte_multi.Rc{g}.YLimWorld
% corte_multi.Rc{g}.XLimWorld
% corte_multi.Rc{g}.RasterSize
% corte_multi.Rc{g}.mapraster
%... hay m_UTMx imagenes, valores de Rc, etc cada imagen es una seccion
%distinta del recuadro general, que es un corte de una toma satelital.
%calcular estadisticos de cada seccion

%Filtro de temporada

% diciembre, enero, febreo: verano
%320 al 60
% marzo, abril, mayo: otoño
%61 al 152
% junio, julio, agosto: invierno
%153 al 240
% septiembre, octubre, noviembre: primavera
%241 al 319
%'LT52330832003267CUB00'
%nombre archivo: 'satelite: <LT5> codigo zona:<233083> año: <2003> dia: <267> codigo:<CUB00>'
        nombre_archivo_id=ID;
        dia=str2num(nombre_archivo_id(length(nombre_archivo_id)-7:length(nombre_archivo_id)-5));
        corte_multi.indice{g}.dia{t,:}=dia;
        year=str2num(nombre_archivo_id(length(nombre_archivo_id)-11:length(nombre_archivo_id)-8));
        corte_multi.indice{g}.year{t,:}=year;

        switch dia
            case num2cell([1:60,330:366])
               corte_multi.indice{g}.temporada{t,:}='Verano';
            case num2cell(61:180)
               corte_multi.indice{g}.temporada{t,:}='Otoño';
            case num2cell(181:225)
               corte_multi.indice{g}.temporada{t,:}='Invierno';
            case num2cell(226:329)
               corte_multi.indice{g}.temporada{t,:}='Primavera';
        end
        
        %se obtienen los estadisticos por indice, indiferente de temporada
        %cada indice tiene im muestras por resolver

       for k=1:m_UTMx
            micro_imagen=corte_multi.indice{g}.imagen{t,:}{k};
            %size(micro_imagen);
            minimo=min(double(micro_imagen(:)));
            maximo=max(double(micro_imagen(:)));
            media=mean(double(micro_imagen(:)));
            mediana=median(double(micro_imagen(:)));
            moda=mode(double(micro_imagen(:)));
            media_geometrica=geomean(double(micro_imagen(:)));
            media_armonica=harmmean(double(micro_imagen(:)));
            curtosis=kurtosis(double(micro_imagen(:)));
            desviacion_estandar=std(double(micro_imagen(:)));

            %minimo
            corte_multi.indice{g}.minimo{t,k}=minimo;
            %maximo;
            corte_multi.indice{g}.maximo{t,k}=maximo;
            %media
            corte_multi.indice{g}.media{t,k}=media;
            %desviacion estandar
            corte_multi.indice{g}.desv_est{t,k}=desviacion_estandar;
            %mediana
            corte_multi.indice{g}.mediana{t,k}=mediana;            
            %moda
            corte_multi.indice{g}.moda{t,k}=moda;
            %media geometrica
            corte_multi.indice{g}.media_geometrica{t,k}=media_geometrica;
            %media armonica
            corte_multi.indice{g}.media_armonica{t,k}=media_armonica;           
            %curtosis
            corte_multi.indice{g}.curtosis{t,k}=curtosis;      
            micro_imagen=[];
        end
    end
%en directorio_tiff
    [Btot,Index_tot]=sortrows([cell2mat(corte_multi.indice{g}.year),cell2mat(corte_multi.indice{g}.dia)]);
    corte_multi.indice{g}.orden_total=Index_tot;
%tomando nombre de archivo de Lista_tiff
end %obtener nombre archivo
