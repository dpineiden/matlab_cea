tic
%comprimir a solo valores <0 en indice NDVI
 [I,J]=find(v_iv<0);%usar J que entrega todos los índices en que ocurre
 r=1;
 for i=1:length(v_iv)
     if isempty(find(J==i))
        short_v_iv(r)=v_iv(i);
        short_v_lon(r)=b_lon(i);
        short_v_lat(r)=b_lat(i);
        r=1+r;
     end
 end
     test2 = struct('Geometry', 'Multipoint', 'id', num2cell(v_iv), 'X', num2cell(b_lon), 'Y', num2cell(b_lat));
     %shapewrite(test2, 'test2'); 
toc