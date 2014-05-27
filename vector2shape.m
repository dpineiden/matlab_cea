
function S_shape=vector2shape(v_iv,v_lon,v_lat,Namefile,Corte)

%comprimir a solo valores <0 en indice NDVI
 [I,J]=find(v_iv<Corte);%usar J que entrega todos los índices en que ocurre
 r=1;
 for i=1:length(v_iv)
     if isempty(find(J==i))
        short_v_iv(r)=v_iv(i);
        short_v_lon(r)=v_lon(i);
        short_v_lat(r)=v_lat(i);
        r=1+r;
     end
 end
     S_shape = struct('Geometry', 'Multipoint', 'id', num2cell(v_iv), 'X', num2cell(v_lon), 'Y', num2cell(v_lat));
     shapewrite(S_shape, Namefile); 

end