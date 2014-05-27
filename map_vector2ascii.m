function GEO_data=map_vector2ascii(v_iv,v_lat,v_lon,Dir,NameFile)
v_iv=v_iv';
v_lat=v_lat';
v_lon=v_lon';
ID=[1:length(v_iv)]';
GEO_data=[ID,v_iv,v_lat,v_lon];
dlmwrite([Dir '/XYZDAT/' NameFile '.dat'],GEO_data);
end