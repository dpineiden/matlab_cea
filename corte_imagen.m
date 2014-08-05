
function [IMc, Rc, X ,R , INFO]=corte_imagen(BaseDir,File,UTM_x,UTM_y)
%cortar seccion definida
cd(BaseDir);
[X, R] = geotiffread(File);
pwd;
if ~isdir('Cortes_Imagenes')
mkdir('Cortes_Imagenes');
end
cd('Cortes_Imagenes');
ruta_actual=pwd;
cd(BaseDir);
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
%     |     X_1.................
%            .                  .  
%            .                  .
%            .                  .
%            .                  .
%            .                  .
%            .                  .
%            .                  .
%            .                  .
%..............................X_2______________
%                                             dy_2  
%                                               |
%                                ____________dx_2______X_b


 Xr=[R.XLimWorld(1):p:R.XLimWorld(2)];
 Yr=[R.YLimWorld(2):-p:R.YLimWorld(1)];
%valores en coordenads de imagen tiff

UTM_x=round(UTM_x/p)*p;
UTM_y=round(UTM_y/py)*py;

X_1=UTM_x;
X_2=UTM_y;
Rc=R;

%left=round(abs(x(1)-floor(X_1(1)/p)*p)/p)
%right=round(abs(x(1)-ceil(X_1(2)/p)*p)/p)
%upper=round(abs(y(1)-floor(X_2(1)/p)*p)/p)
%lower=round(abs(y(1)-ceil(X_2(2)/p)*p)/p)


left=find(Xr==UTM_x(1),1);
right=find(Xr==UTM_x(2),1);
upper=find(Yr==UTM_y(1),1);
lower=find(Yr==UTM_y(2),1);
YLIM=[Yr(min(upper,lower)) Yr(max(upper,lower))];
XLIM=[Xr(min(left,right)) Xr(max(left,right))];
Rc.YLimWorld=[min(YLIM) max(YLIM)];
Rc.XLimWorld=[min(XLIM) max(XLIM)];

% 
% [left_long, upper_lat] = projfwd(INFO, X_1(2), X_1(1))
% [right_long, lower_lat] = projfwd(INFO, X_2(2), X_2(1))
% 
% [left_d, upper_d] = R.worldToIntrinsic(left_long, upper_lat);
% left = round(abs(int64(left_d))/30);
% upper = round(abs(int64(upper_d))/30);
% [right_d, lower_d] = R.worldToIntrinsic(right_long, lower_lat);
% right = round(abs(int64(right_d))/30);
% lower = round(abs(int64(lower_d))/30);
FILAS=[ min(upper,lower) max(upper,lower)];
COLUMNAS=[min(left,right) max(left,right) ];
IMc = X(  min(upper,lower):max(upper,lower)-1, min(left,right):max(left,right)-1  );
Rc.RasterSize=size(IMc);
%filas en y
%columnas en x

Rc = maprasterref('RasterSize',Rc.RasterSize,'YLimWorld', Rc.YLimWorld, 'ColumnsStartFrom','north','XLimWorld', Rc.XLimWorld);

end