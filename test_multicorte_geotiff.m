%dar ruta nombre imagen
directorio='/home/david/Documents/Proyectos_CEA/CNM008/Codigo_Mat/Output/';
proyecto='ANG006_IMG';
directorio_tiff= strcat(directorio,proyecto,'/TIFF/');
nombre_archivo='LE72330831999312EDC00_NDVI.tif';
%entrgar lisas UTM_X UTM_y (ej 3 recuadros)
UTM_x={[381050,381532],[380206,380770],[378315,378992]};
UTM_y={[6323758,6323272]-10000000,[6320748,6320122]-10000000,[6317251,6316736]-10000000};
%--->%leer con geotiffreader
%procesar con corte_imagen_multi
cd(directorio_tiff)
[corte_multi, X ,R , INFO]=corte_imagen_multi(directorio_tiff,nombre_archivo,UTM_x,UTM_y)