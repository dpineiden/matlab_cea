%orden cronologico de data por temporada
    directorio_output='/home/david/Documents/Proyectos_CEA/CNM008/Codigo_Mat/Output/Plots/por_temporada';
    cd(directorio_output);
%tomar de cada valor de agrupacion.filtro los estadistico y ordenarlos
%cronologicamente
%Area porcentual

            %aqui se calcula area por  'umbral'
            %valor umbral es un vector double que se itera para analizar en imagen particular 
            %G=numel(micro_imagen(micro_imagen>umbral(i)))
            %corte_multi.indice{g}.Area{t,k}=G*p^2
            %for q=length(umbral)
            %
            se_requiere='superior';
            p=R_last.DeltaX;%valor en distancia del largo de un pixel
%usando [Area, Percent]=umbral_area_ha_percent(imagen,umbral,p,se_requiere);
                
%aca se ejecuta la fecha y orden
Data_Index=[];
for g=1:length(ind_analisis)
   nombre_indice=indices(g);
   Data_Index{g}.total.absoluto={corte_multi.indice{g}.orden_total};
   for t=1:tn
      Data_Index{g}.total.temporada{t}={agrupacion.indice{g}.filtro{t}.orden_total};
      Data_Index{g}.cronologico.temporada(t)={agrupacion.indice{g}.filtro{t}.orden_cronologico};
   end   
end

y_temp=[];
fecha=[];
y=[];
%k=1;

for g=1:length(ind_analisis)
  for t=1:tn 
    N=length(Data_Index{g}.cronologico.temporada{t});
      for m=1:N
            Nx=agrupacion.indice{g}.filtro{t}.indices;%indica la cantidad de valores por temporada
            for mx=1:Nx
                yearA=agrupacion.indice{g}.filtro{t}.year{Data_Index{g}.cronologico.temporada{t}(m)};
                dayA=agrupacion.indice{g}.filtro{t}.dia{Data_Index{g}.cronologico.temporada{t}(m)};
                yearB=agrupacion.indice{g}.filtro{t}.year{agrupacion.indice{g}.filtro{t}.orden_cronologico(mx)};
                dayB=agrupacion.indice{g}.filtro{t}.dia{agrupacion.indice{g}.filtro{t}.orden_cronologico(mx)};
                if yearA==yearB && dayA==dayB
                    % para comprobar que seleccion bien activar: 
                    %resultado={yearA ,yearB ,dayA ,dayB,agrupacion.indice{g}.filtro{t}.temporada}
                   % k=k+1;
                    %agrupacion.indice{g}.filtro{t}.temporada
                    fecha_temp{t}.orden(mx,1)=mx;
                    fecha_temp{t}.year(mx,1)=yearB;
                    fecha_temp{t}.day(mx,1)=dayB;
                        y_temp{g,t}.temporada{m,1}=agrupacion.indice{g}.filtro{t}.temporada;
                    for s=1:m_UTMx
                        y_temp{g,t}.minimo(m,s)=agrupacion.indice{g}.filtro{t}.minimo{mx,s};
                        y_temp{g,t}.maximo(m,s)=agrupacion.indice{g}.filtro{t}.maximo{mx,s};
                        y_temp{g,t}.media(m,s)=agrupacion.indice{g}.filtro{t}.media{mx,s};
                        y_temp{g,t}.desv_est(m,s)=agrupacion.indice{g}.filtro{t}.desv_est{mx,s};
                        y_temp{g,t}.mediana(m,s)=agrupacion.indice{g}.filtro{t}.mediana{mx,s};
                        y_temp{g,t}.moda(m,s)=agrupacion.indice{g}.filtro{t}.moda{mx,s};
                        y_temp{g,t}.media_geometrica(m,s)=agrupacion.indice{g}.filtro{t}.media_geometrica{mx,s};
                        y_temp{g,t}.media_armonica(m,s)=agrupacion.indice{g}.filtro{t}.media_armonica{mx,s};
                        y_temp{g,t}.curtosis(m,s)=agrupacion.indice{g}.filtro{t}.curtosis{mx,s};
              %valores de indice original
                        imagen=double(agrupacion.indice{g}.filtro{t}.ind_imagen{m,s});
                        [Area, Area_Total,Percent,Matriz_On]=umbral_area_ha_percent(imagen,umbral,p,se_requiere);%Matriz_On es matriz de encendido por capa de umbral
                        [nate,mate]=size(Area);
                        y_temp{g,t}.imagen{m,s}=imagen;
                        y_temp{g,t}.area_ha_total{m,s}=Area_Total;                        
                        for umbral_i=1:length(umbral);
                        y_temp{g,t}.area_ha_indice{m,s}.umbral(umbral_i)=Area(umbral_i);
                        y_temp{g,t}.percent{m,s}.umbral(umbral_i)=Percent(umbral_i);
                        y_temp{g,t}.matriz_on{m,s}.umbral(:,:,umbral_i)=Matriz_On(:,:,umbral_i);
                        end
                        y_temp{g,t}.ind_imagen{m,s}=agrupacion.indice{g}.filtro{t}.ind_imagen{mx,s};
                        y_temp{g,t}.ind_minimo(m,s)=agrupacion.indice{g}.filtro{t}.ind_minimo{mx,s};
                        y_temp{g,t}.ind_maximo(m,s)=agrupacion.indice{g}.filtro{t}.ind_maximo{mx,s};
                        y_temp{g,t}.ind_media(m,s)=agrupacion.indice{g}.filtro{t}.ind_media{mx,s};
                        y_temp{g,t}.ind_desv_est(m,s)=agrupacion.indice{g}.filtro{t}.ind_desv_est{mx,s};
                        y_temp{g,t}.ind_mediana(m,s)=agrupacion.indice{g}.filtro{t}.ind_mediana{mx,s};
                        y_temp{g,t}.ind_moda(m,s)=agrupacion.indice{g}.filtro{t}.ind_moda{mx,s};
                        y_temp{g,t}.ind_media_geometrica(m,s)=agrupacion.indice{g}.filtro{t}.ind_media_geometrica{mx,s};
                        y_temp{g,t}.ind_media_armonica(m,s)=agrupacion.indice{g}.filtro{t}.ind_media_armonica{mx,s};
                        y_temp{g,t}.ind_curtosis(m,s)=agrupacion.indice{g}.filtro{t}.ind_curtosis{mx,s};                        
                        
                    end
                end
            end
        end
    end
end
