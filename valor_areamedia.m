%grafica de valor medio.
cantidad_unos=[];
recurrencia=Porcentaje_Recurrencia;
hectarea=10000;
dir_zonas='/home/david/Documents/Proyectos_CEA/CNM008/Codigo_Mat/Output/Plots/zonas_veg'
cd(dir_zonas)
A_media=[]
for g=1:Cantidad_indices_analisis
    for s=1:Cantidad_secciones   
            matriz=IndiceUmbral{g}.Sector{s}.Matriz_on;
            suma_matriz=sum(matriz,3);
            seccion{g,s}.area_porcentual=suma_matriz/Cantidad_muestras;
            Q=seccion{g,s}.area_porcentual;
            %ahora obtener aquellos puntos cuya recurrencia-permanencia sea .5 
            Q(Q<recurrencia(s))=0;
            Q(Q>=recurrencia(s))=1;
            %obtener el area           
            cantidad_sobre_recurrencia=numel(Q(Q>=1));
            area_media(s)=cantidad_sobre_recurrencia*p^2/hectarea;
            A_media{g,s}=area_media(s);
    end
end
A_media
%%graficar en escala de colores
for s=1:Cantidad_secciones   
figura=figure;
[a_tot,b_tot,c_tot]=size(Recurrencia{g,s}.Matriz_On);
imagen=sum((Recurrencia{g,s}.Matriz_On),3)/c_tot;
limit_recurrencia{s}=[min(imagen),max(imagen)];
%%pasar a shape imagen
% %conseguir vvalor
% Irs=reshape(imagen,numel(imagen),1);
% %conseguir v lat, rescatamos los limites de cada sector
% A=corte_multi.indice{g}.Rc{1}{s}
% %conseguir v lon
% Xlim=A.XLimWorld;
% x_lon=[Xlim(1):30:Xlim(2)]';
% %
% Ylim=A.YLimWorld;
% y_lat=[Ylim(1):30:Ylim(2)]';
% %Valor de corte
% corte=umbral_corte(s);
% %orientacion: superior
% orientacion='superior';
% nombre_archivo=['area_recurrente_sector_' num2str(Secciones{s})];
% %%%%% vetor a shape
% S_shape=vector2shape(Irs,x_lon,y_lat,nombre_archivo,corte,orientacion);
% %%%%
imagesc(imagen);
axis image
%set(gcf, 'Position', get(0,'Screensize')); 
set(gcf,'PaperPositionMode','auto')    
set(figura,'PaperUnits','centimeters'); % f1 es figure(1)
set(figura,'PaperSize',[16 12]); %todo esto esta en centimetros: ancho y alto
set(figura,'PaperPosition',[0 0 16 12]); % los primeros números son xo=0 e yo=0, y luego ancho y alto del papel en cm
print(figura,'-djpeg','-r600',['zona_recurrencia_sector' num2str(Secciones{s}) '.jpg'])   
end

% %Pasar a video el ciclo completo
% %referencia http://www.mathworks.com/help/matlab/ref/avifile.html
% for g=1:Cantidad_indices_analisis
%     for s=1:Cantidad_secciones   
%         figura_video=figure
%         filename=['ndvi_rec50perc_sector' num2str(Secciones{s}) '.avi']
%         writerObj = VideoWriter(filename)
%         open(writerObj);
%         for m=1:Cantidad_muestras
%             matriz=IndiceUmbral{g}.Sector{s}.Matriz_on(:,:,m);
%             plot(Recurrencia{g,s}.valores_x_recurrencia,matriz)
%              h_legend=legend(final);
%     xlabel('Fecha');
%     ylabel('Area [ha]');
%     set(h_legend,'FontSize',Fs);
%     set(gca,'FontName',Fn,'FontSize',Fs)
%             F=getframe(figura_video);
%             aviobj=writeVideo(writerObj,figura_video);
%         end
% close(figura_video);
% aviobj = close(writerObj);
%     end
% end
