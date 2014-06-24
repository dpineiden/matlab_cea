nombres_campos=fieldnames(agrupacion.indice{1}.filtro{1})
%objetivo 1: graficar un set de datos de manera ordenada,
%Grafico: Sector->Indice->Estadistico->Estacion
for s=1:1%m_UTMx% para cada sector un recuadro de gráficos.
for g=1:ind_m
indice_datos=indices{ind_analisis(g)};
       for c=8:8%1 minimo a curtosis en valores 2^n-1 SR_03 da valores muy pequeños, se usa 7 a 15, si se usan otros indices usar 20 a 28
     figure
if c>=21     
estadistico=nombres_campos{c}(5:end);%se recorta nombre la parte ind_
else
estadistico=nombres_campos{c};
end
%definimos el titulo de cada cuadro
titulo=[upper(indice_datos) ' - Estadistico: ' upper(estadistico(1)) estadistico(2:end) '- Sector:' num2str(Secciones{s})];
     for t=1:tn
temporada=agrupacion.indice{g}.filtro{t}.temporada;
year0=cell2mat(agrupacion.indice{g}.filtro{t}.year(agrupacion.indice{g}.filtro{t}.orden_cronologico(1)));
year1=cell2mat(agrupacion.indice{g}.filtro{t}.year(agrupacion.indice{g}.filtro{t}.orden_cronologico(agrupacion.indice{1}.filtro{t}.indices)));
sub_titulo=[temporada ' - Periodo [' num2str(year0) ',' num2str(year1) ']'];
x_label='Fechas';
%se obtienen valores del campo
V=cell2mat(getfield(agrupacion.indice{g}.filtro{t},nombres_campos{c}));
y_label= estadistico;
%se grafica set de datos   
    subplot(2,2,t);
variable_x=agrupacion.indice{g}.filtro{t}.orden_cronologico
                    %nueva figura por cada sector
variable_y=V(:,s);
                p=polyfit(variable_x,variable_y(:,s),1);
                R=corrcoef(variable_x,variable_y(:,s)); 
                linea=p(1)*variable_x+p(2);
                Z =tsmovavg(variable_y(:,s),'t',10,1); %smooth(variable_x,variable_y(:,s),60,'sgolay');
                figura=figure
                plot(variable_x,variable_y(:,s),'<', variable_x,linea,'-',variable_x,Z);
    
    title(sub_titulo);
    xlabel(x_label);
    ylabel(y_label);
    %end
               legend({['Sector '  num2str(s)], ['Linea de tendencia y(x)' num2str(p(1)) '*x+' num2str(p(2))],'Media Temporal'});
                         saveas(figura,['figura_indice_' indice_datos '_sector_' num2str(Secciones{s}) '-'  estadistico], 'fig');
                         saveas(figura,['figura_indice_' indice_datos '_sector_' num2str(Secciones{s}) '-'  estadistico], 'mmat');
                         saveas(figura,['figura_indice_' indice_datos '_sector_' num2str(Secciones{s}) '-'  estadistico], 'png');
                         saveas(figura,['figura_indice_' indice_datos '_sector_' num2str(Secciones{s}) '-'  estadistico], 'png');

    
    
     end        
     figtitle(titulo,'fontweight','bold');
    end
end
end
%x: seran las fechas de toma de muestra---indices
%y; seran 

%se filtra y grafica segun seccion-temporada
    %cell2mat(agrupacion.filtro{4}.imagen{1}(1)) extrae matriz de sector
    %para temporada 4, muestra 1, sector 1
    
%Porteriormente, en base al analisis se realiza un estudio mediante
%histograma estadistico, a lo largo del tiempo para encontrar el punto de
%corte optimo.

%analizar histograma y seccionar cada intervalor para entregar bloques.

%guardar parametros estadistics

%limpiar imagen cargada
