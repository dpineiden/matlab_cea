cuadro_zc.nombre={
    'Río Loa Alto';
    'Salar de Ascotan';
    'Geyser del Tatio';
    'Oasis de Atacama';
    'Volcán Licancabur';
    'Ayllus de San Pedro de Atacama';
    'Salar de Atacama';
    'Salar de Tara';
    'Salar de aguas Calientes';
    'Sistema de Lagunas Miscanti y Miñiques';
    'Salar de Punta Negra';
    'Salar de Pujsa';
    'Laguna Lejía';
    'Sistema Hidrológico Soncor'
    };

%valores en wgs85
cuadro_zc.x={
[-68.85320,-68.09895]
[-68.26799,-67.85977]
[-68.08994,-67.81551]
[-68.30257,-68.15484]
[-67.78503,-67.60751]
[-68.65887,-68.02238]
[-69.06626,-68.88556]
[-68.97034,-68.86352] 
[-70.60807,-70.36595] 
[-70.58620,-70.44180] 
[-70.63696,-70.48724] 
[-70.09172,-69.93866] 
[-69.56745,-69.49855] 
[-68.40515,-68.18795] 
[-68.67859,-68.53386] 
};


cuadro_zc.y={
[-21.08443,-21.88897] 
[-22.26893,-22.59543] 
[-22.48025,-22.97415] 
[-22.83610,-22.98443] 
[-23.34728,-23.54745]  
[-22.93933,-23.86970]  
[-24.34012,-24.75150]
[-22.41437 ,-22.50059]
[-24.67875 ,-25.22364]
[-24.45511 ,-24.59138]
[-23.00353 ,-23.54435]
[-21.40138 ,-21.54488]
[-21.61380 ,-21.73473]
[-21.41117 ,-21.72944] 
[-24.88029 ,-25.12285]
};

[n m]=size(cuadro_zc.x);
utmzone=19;
hemi='N';
for i=1:n
    Lat=cuadro_zc.y{i}(1);
    Lon=cuadro_zc.x{i}(1);
[x,y,utmzone,utmhemi] = wgs2utm(Lat,Lon,utmzone,hemi);
cuadro_zc.UTMx{i}(1)=x;
cuadro_zc.UTMy{i}(1)=y;
    Lat=cuadro_zc.y{i}(2);
    Lon=cuadro_zc.x{i}(2);
[x,y,utmzone,utmhemi] = wgs2utm(Lat,Lon,utmzone,hemi);
cuadro_zc.UTMx{i}(2)=x;
cuadro_zc.UTMy{i}(2)=y;
end
%pasar información de recuadros de zona de control a database
%diccionario METADATA LANDSAT:
%http://glovis.usgs.gov/ImgViewer/landsat_dictionary.html

