%graficar el total de la línea temporal
    directorio_output='/home/david/Documents/Proyectos_CEA/CNM008/Codigo_Mat/Output/Plots/total_anual';
    cd(directorio_output);
%Indice-->Estadistico--->Sectores
%por Cada Índice, Cada estadistico: un gráfico de todos los sectores.
year_julian=juliandate(fecha.year,0,0)-juliandate(0,0,0);
variable_x=year_julian+fecha.day;
Fs=8;
Fn='Arial';
for g=1:length(ind_analisis)%length(ind_analisis)
    indice_datos=indices{ind_analisis(g)};
   for  c=[21,23]%[8,9,10,11]% 1 minimo a curtosis en valores 2^n-1 SR_03 da valores muy pequeños, se usa 8 a 16, si se usan otros indices usar 21 a 29

            if c>=24   
            estadistico=nombres_campos{c}(5:end);%se recorta nombre la parte ind_
            else
            estadistico=nombres_campos{c};
            end
Isub=strfind(estadistico,'_')

 %se obtienen valores del campo vs tiempo
if iscell(getfield(y{g},nombres_campos{c}))
    V=[];
    Z=[];
    Q=[];
T=getfield(y{g},nombres_campos{c});    
[ja, jo]=size(T)
Q=T{g,s}.umbral;
V=Q;%los valores por cada umbral en esa muestra
    for s=1:m_UTMx
        for temp=1:ja
            sector{s}.variable_y(temp,:)=T{temp,s}.umbral;
            lyv=length(sector{s}.variable_y);
        end
for qu=1:length(umbral)
sector{s}.Z(:,qu) =tsmovavg(sector{s}.variable_y(:,qu),'t',20,1); %smooth(variable_x,variable_y(:,s),60,'sgolay');
end        
    end
%variable_y


else
V=getfield(y{g},nombres_campos{c});
variable_y=V(:,s);
end
        
%para obtener string del estadistico
if length(Isub)>=1
bla_est=estadistico;
string_estadistico='';
for j=Isub
%string_estadistico=strcat(string_estadistico,bla_est(1:Isub-1),'-',bla_est(Isub+1:end));
string_estadistico='Area [ha]';
bla_est=estadistico(Isub+1:end);

end
else
   % string_estadistico=estadistico;
string_estadistico='Area [ha]';
end


            %nueva figura por estadistico
           % figure
            MS=m_UTMx;
            for s=1:MS%MS%m_UTMx%sectores a analizar
              %nueva figura por cada sector
%                 variable_y=getfield(y{g},nombres_campos{c});
%                 p=polyfit(variable_x,variable_y(:,s),1);
%                 R=corrcoef(variable_x,variable_y(:,s)); 
%                 linea=p(1)*variable_x+p(2);
%                  Z =tsmovavg(variable_y(:,s),'t',10,1); %smooth(variable_x,variable_y(:,s),60,'sgolay');
                figura=figure('units','normalized','outerposition',[0 0 1 1]);
                plot(variable_x,sector{s}.variable_y,'<', variable_x,sector{s}.Z,'r*-');
                
%      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%           
%                 %%sector para insertar cruce real
% sector_particular=find(cell2mat(Ayl.nro)==Secciones{s})
% if ~isempty(sector_particular) && c==21
% for i=sector_particular
%     i
% hold
%     %cada sector se grafica y se trazan lineas vertical y horizontal por valor
% DATEs1={Ayl.Sector{i}{:,1}}'
% valor_Aha(:,i)=cell2mat({Ayl.Sector{i}{:,2}}');%cantidad de hectareas por sectore (en columnas) por fecha (en filas)
% fecha_juliana_data{i}=juliandate(DATEs1,'dd/mm/yyyy')-juliandate(0,0,0);
% 
% cantidad_datos_sector=length(Ayl.Sector{i});
% maximo_valor=max([Ayl.Sector{i}{:,2}]);
% primera_fecha=fecha_juliana_data{i}(1);
% ultima_fecha=fecha_juliana_data{i}(length(fecha_juliana_data{i}));
%  plot(fecha_juliana_data{i},valor_Aha(:,i),'bo-');
% for j=1:cantidad_datos_sector
%  hold
%     %se traza cada tupla horizontal y vertical
%         %trazado vertical de 0 a doble maximo
%         valor_x=fecha_juliana_data{i}(j);
%          hline2 = line([valor_x valor_x],[0 2*maximo_valor],...
% 'LineStyle','- -','LineWidth',2,'Color',[1 .7 .5]);
% 
% hold%se mantiente figura y plots anteriores
%         %trazado horizontal de fecha inicial a fecha final
%         valor_y=Ayl.Sector{i}{j,2};
%         hline2 = line([primera_fecha ultima_fecha],[valor_y valor_y],...
% 'LineStyle','- -','LineWidth',2,'Color',[1 .7 .5]);
% 
% %                plot(fecha_juliana{i},valor_Aha(:,i),'r*-');
% 
% end
% end
% end%if
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                set(gcf, 'Position', get(0,'Screensize')); 
                set(gcf,'PaperPositionMode','auto');
                datetick('x','mm/yyyy','keepticks');
                
                    %set(h_legend,'FontSize',Fs);
    set(gca,'FontName',Fn,'FontSize',Fs)
    set(gcf, 'Position', get(0,'Screensize')); 
    set(figura,'PaperUnits','centimeters'); % f1 es figure(1)
 set(figura,'PaperSize',[16 12]); %todo esto esta en centimetros: ancho y alto
 set(figura,'PaperPosition',[0 0 16 12]); % los primeros números son xo=0 e yo=0, y luego ancho y alto del papel en cm
 image_name=['figura_indice_' indice_datos '_sector_' num2str(Secciones{s}) '-'  estadistico]
                xlabel('Fecha');                                     
                ylabel(string_estadistico);
                titulo=[ upper(indice_datos) '-' upper(string_estadistico(1)) string_estadistico(2:end) '- Sector ' num2str(Secciones{s}) '- Periodo [' num2str(fecha.year(1)) ';' num2str(fecha.year(end))  ']' ];
 print(figura,'-djpeg','-r600',[image_name '.jpg'])   
                %h_legend=legend({['Sector '  num2str(Secciones{s})], ['Linea de tendencia y(x) =' num2str(p(1)) '*x+' num2str(p(2))],'Media Temporal'});
                       %        set(h_legend,'FontSize',10);
                        % saveas(figura,['figura_indice_' indice_datos '_sector_' num2str(Secciones{s}) '-'  estadistico], 'fig');
                        % saveas(figura,['figura_indice_' indice_datos '_sector_' num2str(Secciones{s}) '-'  estadistico], 'mmat');
                        % saveas(figura,['figura_indice_' indice_datos '_sector_' num2str(Secciones{s}) '-'  estadistico], 'm');
                         saveas(figura,['figura_indice_' indice_datos '_sector_' num2str(Secciones{s}) '-'  estadistico], 'png');
            end
               close all
   end
end
%Indice--->Sector---->Estadisticos

