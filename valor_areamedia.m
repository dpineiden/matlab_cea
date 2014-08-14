%grafica de valor medio.
cantidad_unos=[];
recurrencia=Porcentaje_Recurrencia;
hectarea=10000;
for g=1:Cantidad_indices_analisis
    for s=1:Cantidad_secciones   
            matriz=IndiceUmbral{g}.Sector{s}.Matriz_on;
            suma_matriz=sum(matriz,3);
            seccion{g,s}.area_porcentual=suma_matriz/Cantidad_muestras;
            Q=seccion{g,s}.area_porcentual;
            %ahora obtener aquellos puntos cuya recurrencia-permanencia sea .5 
            Q(Q>=recurrencia(s))=1;
            Q(Q<recurrencia(s))=0;
            %obtener el area           
            cantidad_sobre_recurrencia=numel(Q(Q>=1));
            area_media(s)=cantidad_sobre_recurrencia*p^2/hectarea;
            A_media{g,s}=area_media(s);
    end
end
A_media
%%graficar en escala de colores
for s=1:Cantidad_secciones   
figure;
imagesc(seccion{g,s}.area_porcentual);
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
