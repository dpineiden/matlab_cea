%graficar el total de la línea temporal
    directorio_output='/home/david/Documents/Proyectos_CEA/CNM008/Codigo_Mat/Output/Plots/total_anual';
    cd(directorio_output);
%Indice-->Estadistico--->Sectores
%por Cada Índice, Cada estadistico: un gráfico de todos los sectores.
year_julian=juliandate(fecha.year,0,0)-juliandate(0,0,0);
variable_x=year_julian+fecha.day;
for g=1:1%ind_m
    indice_datos=indices{ind_analisis(g)};
   for  c=[21,22,23,24]%1 minimo a curtosis en valores 2^n-1 SR_03 da valores muy pequeños, se usa 8 a 16, si se usan otros indices usar 21 a 29

            if c>=21   
            estadistico=nombres_campos{c}(5:end);%se recorta nombre la parte ind_
            else
            estadistico=nombres_campos{c};
            end
            %nueva figura por estadistico
           % figure
            MS=m_UTMx
            for s=1:MS%MS%m_UTMx%sectores a analizar
              %nueva figura por cada sector
                variable_y=getfield(y{g},nombres_campos{c});
                p=polyfit(variable_x,variable_y(:,s),1);
                R=corrcoef(variable_x,variable_y(:,s)); 
                linea=p(1)*variable_x+p(2);
                 Z =tsmovavg(variable_y(:,s),'t',10,1); %smooth(variable_x,variable_y(:,s),60,'sgolay');
                   figura=figure
                plot(variable_x,variable_y(:,s),'<', variable_x,linea,'-',variable_x,Z);
                datetick('x','mm/yyyy','keepticks');
                xlabel('Fecha')
                ylabel(estadistico)
                titulo=[ indice_datos '-' upper(estadistico(1)) estadistico(2:end) '- Sector ' num2str(Secciones{s}) '- Periodo [' num2str(fecha.year(1)) ';' num2str(fecha.year(end))  ']' ];
                title(titulo)
                legend({['Sector '  num2str(s)], ['Linea de tendencia y(x) =' num2str(p(1)) '*x+' num2str(p(2))],'Media Temporal'});
                         saveas(figura,['figura_indice_' indice_datos '_sector_' num2str(Secciones{s}) '-'  estadistico], 'fig');
                         saveas(figura,['figura_indice_' indice_datos '_sector_' num2str(Secciones{s}) '-'  estadistico], 'mmat');
                         saveas(figura,['figura_indice_' indice_datos '_sector_' num2str(Secciones{s}) '-'  estadistico], 'png');
                         saveas(figura,['figura_indice_' indice_datos '_sector_' num2str(Secciones{s}) '-'  estadistico], 'png');
            end
                
   end
end
%Indice--->Sector---->Estadisticos

