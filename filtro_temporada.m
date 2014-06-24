function filtro=filtro_temporada(Estructura_Indices,temporada)
Lista_temporadas=Estructura_Indices.temporada;
[n,m]=size(Lista_temporadas);
[sn,sm]=size(Estructura_Indices.minimo);
filtro.temporada=temporada;
k=1;
    for i=1:n
        if strcmp(temporada,Estructura_Indices.temporada{i})
% corte_multi = 
% 
%               nombre: {348x1 cell}
%                   Rc: {348x1 cell}
%               imagen: {348x1 cell}
%                  dia: {348x1 cell}
%                 year: {348x1 cell}
%            temporada: {348x1 cell}
%               minimo: {348x5 cell}
%               maximo: {348x5 cell}
%                media: {348x5 cell}
%             desv_est: {348x5 cell}
%              mediana: {348x5 cell}
%                 moda: {348x5 cell}
%     media_geometrica: {348x5 cell}
%       media_armonica: {348x5 cell}
%             curtosis: {348x5 cell}

        filtro.nombre{k,1}=Estructura_Indices.nombre{i};
        filtro.Rc{k,1}=Estructura_Indices.Rc{i};
        filtro.imagen{k,1}=Estructura_Indices.imagen{i};
        filtro.dia{k,1}=Estructura_Indices.dia{i};
        filtro.year{k,1}=Estructura_Indices.year{i};
        filtro.orden_total(k,1)=Estructura_Indices.orden_total(i);
          for g=1:sm
        filtro.minimo{k,g}=Estructura_Indices.minimo{i,g};
        filtro.maximo{k,g}=Estructura_Indices.maximo{i,g};
        filtro.media{k,g}=Estructura_Indices.media{i,g};
        filtro.desv_est{k,g}=Estructura_Indices.desv_est{i,g};
        filtro.mediana{k,g}=Estructura_Indices.mediana{i,g};
        filtro.moda{k,g}=Estructura_Indices.moda{i,g};
        filtro.media_geometrica{k,g}=Estructura_Indices.media_geometrica{i,g};
        filtro.media_armonica{k,g}=Estructura_Indices.media_armonica{i,g};
        filtro.curtosis{k,g}=Estructura_Indices.curtosis{i,g};
          end
        k=k+1;
        end
    end
    filtro.indices=k-1;
end


