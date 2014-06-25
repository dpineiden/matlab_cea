%tomar de cada valor de agrupacion.filtro los estadistico y ordenarlos
%cronologicamente
fecha=[];
y=[];
for g=1:length(ind_analisis)
N=length(corte_multi.indice{g}.orden_total);
    for m=1:N
        for t=1:tn
            Nx=agrupacion.indice{g}.filtro{t}.indices;
            for mx=1:Nx
                yearA=corte_multi.indice{g}.year{corte_multi.indice{g}.orden_total(m)};
                dayA=corte_multi.indice{g}.dia{corte_multi.indice{g}.orden_total(m)};
                yearB=agrupacion.indice{g}.filtro{t}.year{agrupacion.indice{g}.filtro{t}.orden_cronologico(mx)};
                dayB=agrupacion.indice{g}.filtro{t}.dia{agrupacion.indice{g}.filtro{t}.orden_cronologico(mx)};
                if yearA==yearB && dayA==dayB
                    % para comprobar que selccion bien activar: resultado=[yearA yearB dayA dayB]
                    %agrupacion.indice{g}.filtro{t}.temporada
                    fecha.orden(m,1)=m;
                    fecha.year(m,1)=yearB;
                    fecha.day(m,1)=dayB;
                    y{g}.temporada{m,1}=agrupacion.indice{g}.filtro{t}.temporada; 
                    for s=1:m_UTMx
%                temporada: 'Primavera'
%                   nombre: {84x1 cell}
%                       Rc: {84x1 cell}
%                   imagen: {84x1 cell}
%                      dia: {84x1 cell}
%                     year: {84x1 cell}
%              orden_total: [84x1 double]
%                   minimo: {84x5 cell}
%                   maximo: {84x5 cell}
%                    media: {84x5 cell}
%                 desv_est: {84x5 cell}
%                  mediana: {84x5 cell}
%                     moda: {84x5 cell}
%         media_geometrica: {84x5 cell}
%           media_armonica: {84x5 cell}
%                 curtosis: {84x5 cell}
%                  indices: 84
%        orden_cronologico: [84x1 double]
%               indice_min: {84x1 cell}
%               indice_max: {84x1 cell}
%               ind_minimo: {84x5 cell}
%               ind_maximo: {84x5 cell}
%                ind_media: {84x5 cell}
%             ind_desv_est: {84x5 cell}
%              ind_mediana: {84x5 cell}
%                 ind_moda: {84x5 cell}
%     ind_media_geometrica: {84x5 cell}
%       ind_media_armonica: {84x5 cell}
%             ind_curtosis: {84x5 cell}                        
               %valores de matriz imagen

                        y{g}.minimo(m,s)=agrupacion.indice{g}.filtro{t}.minimo{mx,s};
                        y{g}.maximo(m,s)=agrupacion.indice{g}.filtro{t}.maximo{mx,s};
                        y{g}.media(m,s)=agrupacion.indice{g}.filtro{t}.media{mx,s};
                        y{g}.desv_est(m,s)=agrupacion.indice{g}.filtro{t}.desv_est{mx,s};
                        y{g}.mediana(m,s)=agrupacion.indice{g}.filtro{t}.mediana{mx,s};
                        y{g}.moda(m,s)=agrupacion.indice{g}.filtro{t}.moda{mx,s};
                        y{g}.media_geometrica(m,s)=agrupacion.indice{g}.filtro{t}.media_geometrica{mx,s};
                        y{g}.media_armonica(m,s)=agrupacion.indice{g}.filtro{t}.media_armonica{mx,s};
                        y{g}.curtosis(m,s)=agrupacion.indice{g}.filtro{t}.curtosis{mx,s};
              %valores de indice original
                        y{g}.ind_minimo(m,s)=agrupacion.indice{g}.filtro{t}.ind_minimo{mx,s};
                        y{g}.ind_maximo(m,s)=agrupacion.indice{g}.filtro{t}.ind_maximo{mx,s};
                        y{g}.ind_media(m,s)=agrupacion.indice{g}.filtro{t}.ind_media{mx,s};
                        y{g}.ind_desv_est(m,s)=agrupacion.indice{g}.filtro{t}.ind_desv_est{mx,s};
                        y{g}.ind_mediana(m,s)=agrupacion.indice{g}.filtro{t}.ind_mediana{mx,s};
                        y{g}.ind_moda(m,s)=agrupacion.indice{g}.filtro{t}.ind_moda{mx,s};
                        y{g}.ind_media_geometrica(m,s)=agrupacion.indice{g}.filtro{t}.ind_media_geometrica{mx,s};
                        y{g}.ind_media_armonica(m,s)=agrupacion.indice{g}.filtro{t}.ind_media_armonica{mx,s};
                        y{g}.ind_curtosis(m,s)=agrupacion.indice{g}.filtro{t}.ind_curtosis{mx,s};                        
                        
                    end
                end
            end
        end
    end
end
