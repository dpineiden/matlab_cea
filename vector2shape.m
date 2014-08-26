%function S_shape=vector2shape(v_iv,v_lon,v_lat,Namefile,Corte)
%v_iv: vector de valors
%v_lon: vector longitud asociado a valores
%v_lat: vector latitud asociado a valores
%Namefile: nombre de archivo
%Corte: valor de corte
%Esta funcion permite transfornar valores asociados geográficamente a un
%set de archivos tipo shape para lectura en GIS.

function [S_shape,n,m]=vector2shape(v_iv,v_lon,v_lat,Namefile,Corte,orientacion)

%comprimir a solo valores <0 en indice NDVI

switch orientacion
    case 'superior'
 [I,J]=find(v_iv>=Corte);%usar J que entrega todos los índices en que ocurre
    case 'inferior'
 [I,J]=find(v_iv<=Corte);%usar J que entrega todos los índices en que ocurre
end
 %pasar vectores 
 n=length(v_lat)
 m=length(v_lon)
 r=1;
 for i=1:length(v_iv)
     if isempty(find(J==i))
        short_v_iv(r)=v_iv(i);
%         if rem(i,n)==0
%         resto_fila=n;
%         else
%         resto_fila=i-floor(i/n)*n;
%         end
%         if rem(i,m)==0
%         resto_columna=m;
%         else
%         resto_columna=i-floor(i/m)*m;
%         end
        short_v_lon(r)=v_lon(i);
        short_v_lat(r)=v_lat(i);
        r=1+r;
     end
 end
     S_shape = struct('Geometry', 'Multipoint', 'id', num2cell(short_v_iv), 'X', num2cell(short_v_lon), 'Y', num2cell(short_v_lat));
     shapewrite(S_shape, Namefile); 

end