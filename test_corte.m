clear
%cargar imagen
%definir ruta de imagen
BaseDir='/home/david/Documents/Proyectos_CEA/CNM008/Codigo_Mat/'
File='/home/david/Documents/Proyectos_CEA/CNM008/Codigo_Mat/img_test/L5Ssat1/LT50010751985064XXX04_B1.TIF';
Ruta='/home/david/Documents/Proyectos_CEA/CNM008/Codigo_Mat/img_test/L5Ssat1';
nombre_corte='Prueba';
UTM_x=[420000,500000];
UTM_y=[-2300000,-2400000];
largo_pixel=30;
[IMc X R INFO]=corte_imagen(BaseDir,Ruta,File,nombre_corte,UTM_x,UTM_y,largo_pixel);
 figure
 imshow(IMc)
 figure
 imshow(X)
save_geotif=guardar_img_tif(IMc,R,INFO,File,nombre_corte,UTM_x,UTM_y)