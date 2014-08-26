 p=30;
for s=1:MS
[a_tot,b_tot,c_tot]=size(Recurrencia{g,s}.Matriz_On);
imagen=sum((Recurrencia{g,s}.Matriz_On),3)/c_tot;
limit_recurrencia{s}=[min(imagen),max(imagen)];
%%pasar a shape imagen
%conseguir vvalor
aim=size(imagen)
Irs=reshape(imagen,numel(imagen),1);
%conseguir v lat, rescatamos los limites de cada sector
A=corte_multi.indice{g}.Rc{1}{s}
%conseguir v lon
Xlim=A.XLimWorld;
x_lon=[Xlim(1):p:Xlim(2)]';
ax=length(x_lon)%
Ylim=A.YLimWorld;
y_lat=[Ylim(2):-p:Ylim(1)]';
ay=length(y_lat);%
Xlon =repmat(x_lon',ay,1);%crea matriz de posicion longitudinal
longitud=reshape(Xlon,numel(Xlon),1);
Ylat =repmat(y_lat,1,ax);
latitud=reshape(Ylat,numel(Ylat),1);

%Valor de corte
corte=umbral_corte(s);
%orientacion: superior
orientacion='superior';
nombre_archivo=['area_recurrente_sector_' num2str(Secciones{s})];
%%%%% vetor a shape
%[S_shape,nsh,msh]=vector2shape(Irs,longitud,latitud,nombre_archivo,corte,orientacion);
R=corte_multi.indice{g}.Rc{1}{s};
%%%%%%%%%%%%o TXT
            v_iv=Irs;
            v_lat=latitud+10000000;
            v_lon=longitud;
        GEO_data=map_vector2ascii(v_iv,v_lat,v_lon,directorio,nombre_archivo, 0.1);
%%%%
 end