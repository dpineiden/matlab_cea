%permite recuperar multiples zonas  a partir de una imagen.
function [corte_multi, X ,R , INFO]=corte_imagen_multi(BaseDir,File,UTM_x,UTM_y)
%cortar seccion definida
%UTM_x: lista de valores para posicion X {[X1(1) X1(2)],X2(1),X2(2),....]}
%UTM_y: lista de valores para posicion Y
%UTM son valores de posicion reales, no de pixeles
%obtener largo de lista----[ 1 , n ] =size(UTM_x) tomamos n por la cantidad
%de elementos apres de posicion
[fil, cols]=size(UTM_x);
[X, R] = geotiffread(File);
cd(BaseDir);
pwd;
if ~isdir('Cortes_Imagenes')
mkdir('Cortes_Imagenes');
end
cd('Cortes_Imagenes');
ruta_actual=pwd;
INFO = geotiffinfo(File);
UTM.geokey=INFO.GeoTIFFTags.GeoKeyDirectoryTag;
UTM.tipo=INFO.Projection;
[n,m]=size(X);
%pasa coordenadas a deg utm 19 N a deg
[x,y] = R.intrinsicToWorld(R.XLimIntrinsic,R.YLimIntrinsic);
%lognitud pixel largo-ancho [m]
largo_pixel= INFO.GeoTIFFTags.ModelPixelScaleTag(1);
p=largo_pixel; %en metros
py= INFO.GeoTIFFTags.ModelPixelScaleTag(2);

%entregar los dos puntos limite del corte
%X_a__dx_1___
%   dy_1
%     |     X_1(1).................
%            .                  .  
%            .                  .
%            .                  .
%            .                  .
%            .                  .
%            .                  .
%            .                  .
%            .                  .
%..............................X_2(1)______________
%                                             dy_2  
%                                               |
%                                ____________dx_2______X_b

%entregar los dos puntos limite del corte
%X_a__dx_1___
%   dy_1
%     |X_1(2)........
%      .            .  
%      .            .
%      .            .
%...................X_2(2)______________
%                              
%                              
%                              
%                         
%            
%                                             dy_2  
%                                               |
%                                ____________dx_2______X_b


 Xr=[R.XLimWorld(1):p:R.XLimWorld(2)];
 Yr=[R.YLimWorld(1):p:R.YLimWorld(2)];
%valores en coordenads de imagen tiff


%se comienza la iteracion para cada zona. recortando de la imagen inicial
%las partes de interes

for g=1:n
    UTM_x_round=round(UTM_x{g}/p)*p;
    UTM_y_round=round(UTM_y{g}/py)*py;   
    
    X_1=UTM_x_round;
    X_2=UTM_y_round;
    
    Rc=R;
    
%left=round(abs(x(1)-floor(X_1(1)/p)*p)/p)
%right=round(abs(x(1)-ceil(X_1(2)/p)*p)/p)
%upper=round(abs(y(1)-floor(X_2(1)/p)*p)/p)
%lower=round(abs(y(1)-ceil(X_2(2)/p)*p)/p)

    left=find(Xr==UTM_x_round(1),1);
    right=find(Xr==UTM_x_round(2),1);
    upper=find(Yr==UTM_y_round(1),1);
    lower=find(Yr==UTM_y_round(2),1);

    corte_multi.Rc.YLimWorld{g}=[Yr(min(upper,lower)) Yr(max(upper,lower))]
    corte_multi.Rc.XLimWorld{g}=[Xr(min(left,right)) Xr(max(left,right))]

% [left_long, upper_lat] = projfwd(INFO, X_1(2), X_1(1))
% [right_long, lower_lat] = projfwd(INFO, X_2(2), X_2(1))
% [left_d, upper_d] = R.worldToIntrinsic(left_long, upper_lat);
% left = round(abs(int64(left_d))/30);
% upper = round(abs(int64(upper_d))/30);
% [right_d, lower_d] = R.worldToIntrinsic(right_long, lower_lat);
% right = round(abs(int64(right_d))/30);
% lower = round(abs(int64(lower_d))/30);

    FILAS=[ min(upper,lower) max(upper,lower)];
    COLUMNAS=[min(left,right) max(left,right) ];
    corte_multi.imagen{g} = X(  min(upper,lower):max(upper,lower)-1, min(left,right):max(left,right)-1  );
    corte_multi.Rc.RasterSize{g}=size(corte_multi.imagen{g});
    %filas en y
    %columnas en x
    corte_multi.Rc{g} = maprasterref('RasterSize',    corte_multi.Rc.RasterSize{g},'YLimWorld', corte_multi.Rc.YLimWorld{g}, 'ColumnsStartFrom','north','XLimWorld', corte_multi.Rc.XLimWorld{g});
end


end