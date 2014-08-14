%year_julian=juliandate(fecha.year,0,0)-juliandate(0,0,0);
Directorio='/home/david/Documents/Proyectos_CEA/CNM008/Codigo_Mat/Output/datos_base';
cd(Directorio);

%variable_x=year_julian+fecha.day;
sectores_reales=length(Ayl.nro);
%Pasar sectores patron en columna fecha a dia juliano...
%Objetivo: cruzar graficos para analizar el valor de umbral correcto
figura=figure('units','normalized','outerposition',[0 0 1 1]);

for i=1:sectores_reales
DATEs1={Ayl.Sector{i}{:,1}}';
valor_Aha(:,i)=cell2mat({Ayl.Sector{i}{:,2}}');%cantidad de hectareas por sectore (en columnas) por fecha (en filas)
fecha_juliana_data{i}=juliandate(DATEs1,'dd/mm/yyyy')-juliandate(0,0,0);


                subplot(2,2,i)
                plot(fecha_juliana_data{i},valor_Aha(:,i),'r*-');
                set(gcf, 'Position', get(0,'Screensize')); 
                set(gcf,'PaperPositionMode','auto')
                datetick('x','mm/yyyy','keepticks');
                xlabel('Fecha')
                ylabel('Area [ha]')
                title(strcat('Area [ha] vs tiempo en Sector: ',num2str(cell2mat(Ayl.nro(i)))));
                
end
saveas(figura,['figura_area_ah_tpo_sector_ylc'], 'png');
close all
for i=1:sectores_reales
%cada sector se grafica y se trazan lineas vertical y horizontal por valor
figura=figure('units','normalized','outerposition',[0 0 1 1]);
DATEs1={Ayl.Sector{i}{:,1}}';
valor_Aha(:,i)=cell2mat({Ayl.Sector{i}{:,2}}');%cantidad de hectareas por sectore (en columnas) por fecha (en filas)
fecha_juliana_data{i}=juliandate(DATEs1,'dd/mm/yyyy')-juliandate(0,0,0);

cantidad_datos_sector=length(Ayl.Sector{i});
maximo_valor=max([Ayl.Sector{i}{:,2}]);
primera_fecha=fecha_juliana_data{i}(1);
ultima_fecha=fecha_juliana_data{i}(length(fecha_juliana_data{i}));
 plot(fecha_juliana_data{i},valor_Aha(:,i),'bo-');
 hold
for j=1:cantidad_datos_sector
    %se traza cada tupla horizontal y vertical
        %trazado vertical de 0 a doble maximo
        valor_x=fecha_juliana_data{i}(j);
         hline2 = line([valor_x valor_x],[0 2*maximo_valor],...
'LineStyle','- -','LineWidth',2,'Color',[1 .7 .5]);

hold%se mantiente figura y plots anteriores
        %trazado horizontal de fecha inicial a fecha final
        valor_y=Ayl.Sector{i}{j,2};
        hline2 = line([primera_fecha ultima_fecha],[valor_y valor_y],...
'LineStyle','- -','LineWidth',2,'Color',[1 .7 .5]);

%                plot(fecha_juliana{i},valor_Aha(:,i),'r*-');
                set(gcf, 'Position', get(0,'Screensize')); 
                set(gcf,'PaperPositionMode','auto')
                datetick('x','mm/yyyy','keepticks');
                xlabel('Fecha')
                ylabel('Area [ha]')
                title(strcat('Area [ha] vs tiempo en: Sector:',num2str(cell2mat(Ayl.nro(i)))));
                hold
end
saveas(figura,['figura_area_ah_tpo_sector_' num2str(cell2mat(Ayl.nro(i)))], 'png');
close all
end

