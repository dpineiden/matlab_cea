%graficar analisis recurrencia
% Recurrencia{g,s}.valores_x_recurrencia es la fecha juliana desde donde se
% toma la recurrencia, con desplazamiento 10 años, hasta el final,
%hay que graficar Recurrencia{g,s}.Area(:,:,i) vs fecha
% plot(Recurrencia{g,1}.valores_x_recurrencia,Recurrencia{g,1}.Area)
dir_recurrencia='/home/david/Documents/Proyectos_CEA/CNM008/Codigo_Mat/Output/Plots/recurrencia'
cd(dir_recurrencia)
caracter={'o','+','*','<','>'};
color={'k','m',[.2 1 0.5],'r','g'};
Fs=8;
Fn='Arial';
palabra='Sector';
vector_sector=repmat(palabra,length(Secciones),1);
num_secciones=cell2mat(Secciones');
final=[sector num2str(num_secciones)];
for g=1:Cantidad_indices_analisis
         
    for s=1:Cantidad_secciones    
        figura=figure('units','normalized','outerposition',[0 0 1 1]);
        plot(Recurrencia{g,s}.valores_x_recurrencia,Recurrencia{g,s}.Area,[caracter{s} '-'],'Color',color{s})

   % h_legend=legend(final);
    xlabel('Fecha');
    ylabel('Area [ha]');
    %set(h_legend,'FontSize',Fs);
    set(gca,'FontName',Fn,'FontSize',Fs)
    set(gcf, 'Position', get(0,'Screensize')); 
    set(gcf,'PaperPositionMode','auto')    
    datetick('x','mm/yyyy','keepticks');
    set(figura,'PaperUnits','centimeters'); % f1 es figure(1)
 set(figura,'PaperSize',[16 12]); %todo esto esta en centimetros: ancho y alto
 set(figura,'PaperPosition',[0 0 16 12]); % los primeros números son xo=0 e yo=0, y luego ancho y alto del papel en cm
 print(figura,'-djpeg','-r600',['recurrencia_sectore_60p_sector' num2str(Secciones{s}) '.jpg'])         
        
    end

end

% 
% f1=figure(1)
% 
% %Tamaño y fuente
% Fs=8;
% Fn='Arial';
% set(gca,'FontName',Fn,'FontSize',Fs)
% set(get(gca,'YLabel'),'String','Caudal [m^3/s]','FontName',Fn,'FontSize',Fs)
% 
% %Ubicacón del plot relativo a la hoja (o canvas? no sé cuál es el nombre correcto9
% set(gca,'Position',[xo yo  dx dy]); todos son valores entre 0 y 1
% 
% % Tamaño de la hoja
% set(f1,'PaperUnits','centimeters'); % f1 es figure(1)
% set(f1,'PaperSize',[16 12]); %todo esto esta en centimetros: ancho y alto
% set(f1,'PaperPosition',[0 0 16 12]); % los primeros números son xo=0 e yo=0, y luego ancho y alto del papel en cm
% 
% print(f1,'-djpeg','-r600','Caudal_salida1.jpg') 