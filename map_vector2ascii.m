function GEO_data=map_vector2ascii(v_iv,v_lat,v_lon,Dir,NameFile,Corte)
v_iv=v_iv';
v_lat=v_lat';
v_lon=v_lon';
ID=[1:length(v_iv)];
format longg
GEO_data_pre=[ID',v_iv',v_lat',v_lon'];
%Pref::outputDigits(12)
%pasar vectores 
 n=length(v_lat)
 m=length(v_lon)
 r=1;
 for i=1:length(v_iv)
     if v_iv(i)>=Corte
        short_v_iv(r,1)=v_iv(i);
        short_v_lon(r,1)=v_lon(i);
        short_v_lat(r,1)=v_lat(i);
        ID_r(r,1)=r;
        r=1+r;
     end
 end
 GEO_data=[ID_r,short_v_iv,short_v_lon,short_v_lat];
dlmwrite([Dir '/XYZDAT/' NameFile '.csv'],GEO_data,'precision',15);
end