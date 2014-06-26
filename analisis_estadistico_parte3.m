nombres_campos=fieldnames(agrupacion.indice{1}.filtro{1});
%objetivo 1: graficar un set de datos de manera ordenada,
%Grafico: Sector->Indice->Estadistico->Estacion
for s=1:m_UTMx% para cada sector un recuadro de gráficos.
for g=1:ind_m
indice_datos=indices{ind_analisis(g)};
pause(0.5) 
close all
for c=[21,22,23,24]%1 minimo a curtosis en valores 2^n-1 SR_03 da valores muy pequeños, se usa 8 a 16, si se usan otros indices usar 21 a 29
 figura=figure('units','normalized','outerposition',[0 0 1 1]);
if c>=21     
estadistico=nombres_campos{c}(5:end);%se recorta nombre la parte ind_
else
estadistico=nombres_campos{c};
end
Isub=strfind(estadistico,'_')
if length(Isub)>=1
bla_est=estadistico;
string_estadistico='';
for j=Isub
string_estadistico=strcat(string_estadistico,bla_est(1:Isub-1),'-',bla_est(Isub+1:end));
bla_est=estadistico(Isub+1:end);
end
else
    string_estadistico=estadistico;
end
%definimos el titulo de cada cuadro
titulo=[upper(indice_datos) ' - Estadistico: ' upper(string_estadistico(1)) string_estadistico(2:end) '- Sector:' num2str(Secciones{s})];

for t=1:tn
subplot(2,2,t);
         %%%%%%%%%%%%%%%%éndiente, pasar años a julianos
year_julian=juliandate(fecha_temp{t}.year,0,0)-juliandate(0,0,0);
variable_x=year_julian+fecha_temp{t}.day;


temporada=y_temp{g,t}.temporada{1};
year0=cell2mat(agrupacion.indice{g}.filtro{t}.year(agrupacion.indice{g}.filtro{t}.orden_cronologico(1)));
year1=cell2mat(agrupacion.indice{g}.filtro{t}.year(agrupacion.indice{g}.filtro{t}.orden_cronologico(agrupacion.indice{1}.filtro{t}.indices)));
sub_titulo=[temporada ' - Periodo [' num2str(year0) ',' num2str(year1) ']'];
x_label='Fechas';
%se obtienen valores del campo
V=getfield(y_temp{g,t},nombres_campos{c});
y_label= string_estadistico;
%se grafica set de datos   

                    %nueva figura por cada sector
                variable_y=V(:,s);
                p=polyfit(variable_x,variable_y,1);
                R=corrcoef(variable_x,variable_y); 
                linea=p(1)*variable_x+p(2);
                Z =tsmovavg(variable_y,'t',10,1); %smooth(variable_x,variable_y(:,s),60,'sgolay');
                plot(variable_x,variable_y,'<', variable_x,linea,'-',variable_x,Z);
                set(gcf, 'Position', get(0,'Screensize')); 
                set(gcf,'PaperPositionMode','auto')
                datetick('x','mm/yyyy','keepticks');
    title(sub_titulo);
    xlabel(x_label);
    ylabel(y_label);
    %end
               h_legend=legend({['Sector '  num2str(Secciones{s})], ['Linea de tendencia y(x) =' num2str(p(1)) '*x+' num2str(p(2))],'Media Temporal'});
               set(h_legend,'FontSize',10);
                        % saveas(figura,['figura_indice_' indice_datos '_sector_' num2str(Secciones{s}) '-'  estadistico], 'fig');
                        % saveas(figura,['figura_indice_' indice_datos '_sector_' num2str(Secciones{s}) '-'  estadistico], 'mmat');
                        % saveas(figura,['figura_indice_' indice_datos '_sector_' num2str(Secciones{s}) '-'  estadistico], 'm');
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
