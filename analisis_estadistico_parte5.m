%graficar el total de la línea temporal
    directorio_output='/home/david/Documents/Proyectos_CEA/CNM008/Codigo_Mat/Output/Plots/total_anual';
    cd(directorio_output);
%Indice-->Estadistico--->Sectores
%por Cada Índice, Cada estadistico: un gráfico de todos los sectores.
year_julian=juliandate(fecha.year,0,0)-juliandate(0,0,0);
variable_x=year_julian+fecha.day;
for g=1:length(ind_analisis)%length(ind_analisis)
    indice_datos=indices{ind_analisis(g)};
   for  c=[8,9,10,11]%[21,22,23,24]%1 minimo a curtosis en valores 2^n-1 SR_03 da valores muy pequeños, se usa 8 a 16, si se usan otros indices usar 21 a 29

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
                   figura=figure('units','normalized','outerposition',[0 0 1 1])
                plot(variable_x,variable_y(:,s),'<', variable_x,linea,'-',variable_x,Z);
                set(gcf, 'Position', get(0,'Screensize')); 
                set(gcf,'PaperPositionMode','auto')
                datetick('x','mm/yyyy','keepticks');
                xlabel('Fecha')
                ylabel(string_estadistico)
                titulo=[ upper(indice_datos) '-' upper(string_estadistico(1)) string_estadistico(2:end) '- Sector ' num2str(Secciones{s}) '- Periodo [' num2str(fecha.year(1)) ';' num2str(fecha.year(end))  ']' ];
                title(titulo)
                h_legend=legend({['Sector '  num2str(Secciones{s})], ['Linea de tendencia y(x) =' num2str(p(1)) '*x+' num2str(p(2))],'Media Temporal'});
                               set(h_legend,'FontSize',10);
                         saveas(figura,['figura_indice_' indice_datos '_sector_' num2str(Secciones{s}) '-'  estadistico], 'fig');
                         saveas(figura,['figura_indice_' indice_datos '_sector_' num2str(Secciones{s}) '-'  estadistico], 'mmat');
                         saveas(figura,['figura_indice_' indice_datos '_sector_' num2str(Secciones{s}) '-'  estadistico], 'm');
                         saveas(figura,['figura_indice_' indice_datos '_sector_' num2str(Secciones{s}) '-'  estadistico], 'png');
            end
                close all
   end
end
%Indice--->Sector---->Estadisticos

