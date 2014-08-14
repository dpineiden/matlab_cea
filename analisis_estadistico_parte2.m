%Una vez que se tienen los analisis para todas las secciones de un indice,
%se realiza el filtrado por estacion y por seccion, a lo largo de todos los
%años.
%tenemos dos estructuras: corte_multi e indice_imagen
%se comienza a leer uno a uno indice_imagen asociando a corte_multi
%correspondientemente.
%se llama a una funcion inversa del indice
%se tiene una lista por temporada
%se tiene set de secciones, cortes de imagenes
clear agrupacion agrupacionF
temporadas={'Verano';'Otoño';'Invierno';'Primavera'};
%temporadas={'Verano';'Otoño';'Primavera'};%util
Descarte={'LS7',[2005,2008]};
[tn tm]=size(temporadas);
[ind_n, ind_m]=size(corte_multi.indice);
for g=1:ind_m
    Estructura=corte_multi.indice{g};
    %tomamos cada corte_multi.nombre
    %se tiene una estructura con las imagenes y sus estadisticos
    for t=1:tn
    %se separan por seccion y temporada, asignando estos dos nuevos valores
        agrupacion.indice{g}.filtro{t}=filtro_temporada(Estructura,temporadas{t});
    end 

%volver a leer otra imagen
end

%se ordenan cronologicamente los datos POR TEMPORADA
%ind_m valor de cantidad de índices
%tn: cantidad de temporadas
for g=1:ind_m
    for t=1:tn
years_1=cell2mat(agrupacion.indice{g}.filtro{t}.year);
days_1=cell2mat(agrupacion.indice{g}.filtro{t}.dia);    
[B, Index]=sortrows([years_1, days_1]);
agrupacion.indice{g}.filtro{t}.orden_cronologico=Index;
%Se añade Index a estructura agrupacion.filtro{t}
     end
end
 
%JOIN indices de imagen con valores originales de indices--> extraer min
%max como entradas de funcion inversa

for t=1:tn
    for g=1:ind_m
        for m=1:agrupacion.indice{g}.filtro{t}.indices
                for h=1:indice_imagen.indice{1}.rango{2}
            if strcmp(indice_imagen.indice{g}.ID{h},agrupacion.indice{g}.filtro{t}.nombre{m})
            agrupacion.indice{g}.filtro{t}.indice_min{m,1}=indice_imagen.indice{g}.minimo{h};
            agrupacion.indice{g}.filtro{t}.indice_max{m,1}=indice_imagen.indice{g}.maximo{h};
            end
                end
       end
    end
end

%Obtener valores indice: Real_Indice=inversa_indice(Matriz, minimo, maximo,bits)
bits=16;
for g=1:ind_m
    for t=1:tn
        for m=1:agrupacion.indice{g}.filtro{t}.indices
                minimo=str2double(agrupacion.indice{g}.filtro{t}.indice_min{m});
                maximo=str2double(agrupacion.indice{g}.filtro{t}.indice_max{m});
            for s=1:m_UTMx % sectores
%             temporada: 'Verano'
%                nombre: {142x1 cell}
%                    Rc: {142x1 cell}
%                imagen: {142x1 cell}
%                   dia: {142x1 cell}
%                  year: {142x1 cell}
%                minimo: {142x5 cell}
%                maximo: {142x5 cell}
%                 media: {142x5 cell}
%              desv_est: {142x5 cell}
%               mediana: {142x5 cell}
%                  moda: {142x5 cell}
%      media_geometrica: {142x5 cell}
%        media_armonica: {142x5 cell}
%              curtosis: {142x5 cell}
%               indices: 142
%     orden_cronologico: [142x1 double]
%            indice_min: {142x1 cell}
%            indice_max: {142x1 cell

%Real_Indice=inversa_indice(Matriz, minimo, maximo,bits)}
%bloque de testeo para estudiar resultados.
%                 if g==1 & t==1 & m==1 & s==1
%                    minimo
%                    maximo
%                    bits
%                 end;
                agrupacion.indice{g}.filtro{t}.area_ha_indice{m,s}='';
                agrupacion.indice{g}.filtro{t}.area_ha_total{m,s}='';
                agrupacion.indice{g}.filtro{t}.percent{m,s}='';
                agrupacion.indice{g}.filtro{t}.matriz_on{m,s}='';
                agrupacion.indice{g}.filtro{t}.ind_imagen{m,s}=inversa_indice(double(agrupacion.indice{g}.filtro{t}.imagen{m}{s}), minimo, maximo,bits);
                agrupacion.indice{g}.filtro{t}.ind_minimo{m,s}=inversa_indice(agrupacion.indice{g}.filtro{t}.minimo{m,s}, minimo, maximo,bits);
                agrupacion.indice{g}.filtro{t}.ind_maximo{m,s}=inversa_indice(agrupacion.indice{g}.filtro{t}.maximo{m,s}, minimo, maximo,bits);
                agrupacion.indice{g}.filtro{t}.ind_media{m,s}=inversa_indice(agrupacion.indice{g}.filtro{t}.media{m,s}, minimo, maximo,bits);
                agrupacion.indice{g}.filtro{t}.ind_desv_est{m,s}=inversa_indice(agrupacion.indice{g}.filtro{t}.desv_est{m,s}, minimo, maximo,bits);
                agrupacion.indice{g}.filtro{t}.ind_mediana{m,s}=inversa_indice(agrupacion.indice{g}.filtro{t}.mediana{m,s}, minimo, maximo,bits);
                agrupacion.indice{g}.filtro{t}.ind_moda{m,s}=inversa_indice(agrupacion.indice{g}.filtro{t}.moda{m,s}, minimo, maximo,bits);
                agrupacion.indice{g}.filtro{t}.ind_media_geometrica{m,s}=inversa_indice(agrupacion.indice{g}.filtro{t}.media_geometrica{m,s}, minimo, maximo,bits);
                agrupacion.indice{g}.filtro{t}.ind_media_armonica{m,s}=inversa_indice(agrupacion.indice{g}.filtro{t}.media_armonica{m,s}, minimo, maximo,bits);
                agrupacion.indice{g}.filtro{t}.ind_curtosis{m,s}=inversa_indice(agrupacion.indice{g}.filtro{t}.curtosis{m,s}, minimo, maximo,bits);
            end
        end
        end
end