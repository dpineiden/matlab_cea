IndiceUmbral=[];
Recurrencia=[]

%Analisis de Recurrencia
%Rutina que estudia la cantidad de veces que se repite
%Toma las matrices encendidas segun valor de umbral determinado a cada tipo
%de vegetacion

%En base a la lista de sectores disponibles
%Secciones={1,2,3,5,7};

%El umbral de corte determinado es para cada sector, dado el tipo de
%vegetacion
%Porcentaje_Recurrencia=[.75,.85,.958,.75,.9212];
Porcentaje_Recurrencia=[.6,.6,.6,.6,.6];
umbral_corte=[.32,.46,.52,.32,.48];
p=30;
%Entonces, hay una asociación entre los indices de umbral de corte con la
%seccion
Cantidad_indices_analisis=length(ind_analisis);
Cantidad_muestras=length(y{g}.matriz_on);
Cantidad_secciones=length(Secciones);
%Luego se itera para cada umbral de corte y se hace una busqueda en la
%posicion de correspondencia del vector umbral de analisis
%Años intervalo estudio
years_estudio=10;
%
length(umbral_corte)
for i=1:length(umbral_corte)
    Afind=find(umbral>=umbral_corte(i)-.01);
    B_umbral(i)=Afind(1);%revela los indices de ubicacion del valor de corte en vector umbral, lo que se refleja en las matrices que contienen los valores encendidos
end
%ocupo:y{g}.matriz_on{m,s}.umbral(:,:,umbral_i)
%Llamando de esta forma a cada matriz y{g}.matriz_on{m,s}.umbral(:,:,Bumbral(s))
%g: indice, m: muestra (temporal)-->114, s: sector
%y trabajar fecha a julianos: %Indice-->Estadistico--->Sectores
%por Cada Índice, Cada estadistico: un gráfico de todos los sectores.
%year_julian=juliandate(fecha.year,0,0)-juliandate(0,0,0);
%variable_x=year_julian+fecha.day;

for g=1:Cantidad_indices_analisis
for s=1:Cantidad_secciones
   for m=1:Cantidad_muestras
       IndiceUmbral{g}.Sector{s}.Matriz_on(:,:,m)=y{g}.matriz_on{m,s}.umbral(:,:,B_umbral(s));
       IndiceUmbral{g}.Sector{s}.fecha(m,:)=[fecha.year(m),fecha.day(m)];
   end
    IndiceUmbral{g}.Sector{s}.fecha_juliana=[juliandate(fecha.year,0,0)-juliandate(0,0,0),fecha.day];   
end
end
%Con esto será posible conocer en un intervalo de 10 años, representado por el numero de muestas en esos años,
%cada pixel que ha tenido una recurrencia o ha estado encendido un tanto porciento n/10

%Con esto, activar otra matriz que cumpla con el umbral y calcular el area.
Fechas=juliandate(fecha.year,0,0)-juliandate(0,0,0)+fecha.day;
for g=1:Cantidad_indices_analisis
muestras=[];
    for s=1:Cantidad_secciones
%Obtener numero inicial
Fecha_inicio=IndiceUmbral{g}.Sector{s}.fecha_juliana(1,1)+IndiceUmbral{g}.Sector{s}.fecha_juliana(1,2);
%La fecha juliana en 10 años mas
In_n_years=Fecha_inicio+juliandate(IndiceUmbral{g}.Sector{s}.fecha_juliana(1,1)+years_estudio,0,0)-juliandate(IndiceUmbral{g}.Sector{s}.fecha_juliana(1,1),0,0);
%buscar el punto muestral mas cercano hacia abajo
%
j=0;
busqueda=find(Fechas>=In_n_years);
posicion_inicial_iteracion=busqueda(1);
%se comienza escaneo en torno a los ultimos 10 años
Recurrencia{g,s}.valores_x_recurrencia=Fechas(posicion_inicial_iteracion:end);
i=posicion_inicial_iteracion;
posicion_siguiente_iteracion=1;
while i<=length(Fechas)
    indice_umbral=IndiceUmbral{g}.Sector{s}.Matriz_on(:,:,posicion_siguiente_iteracion:i);
    [a_umbral b_umbral c_umbral]=size(indice_umbral);
    if s==20
    figure
    imshow(indice_umbral(:,:,1))
    end
    size_umbral=size(indice_umbral);
    Recurrencia{g,s}.Activadas(:,:,i-posicion_inicial_iteracion+1)=sum(indice_umbral,3);
    umbral_activado=Recurrencia{g,s}.Activadas(:,:,i-posicion_inicial_iteracion+1);
    %obtener la cantidad de muestras en ultimos 10 años
    %a partir del largo del vector que toma los datos en ese periodo    
    size(Recurrencia{g,s}.Activadas(:,:,:));
    Recurrencia{g,s}.Cantidad_muestras_periodo(i-posicion_inicial_iteracion+1)=c_umbral;
    %por lo tanto, porcentualmente
    Recurrencia{g,s}.Activadas_Porcentual(:,:,i-posicion_inicial_iteracion+1)=umbral_activado/c_umbral;
     size(Recurrencia{g,s}.Activadas);
    imagen_recurrencia=Recurrencia{g,s}.Activadas(:,:,i-posicion_inicial_iteracion+1);
    %figure
    %imshow(imagen_recurrencia/muestras(i-posicion_inicial_iteracion+1))
    %me permite obtener el area en la cual se cumple un tanto por ciento,
    %dada la matriz, p y condiciones
    cantidad_muestras=Recurrencia{g,s}.Cantidad_muestras_periodo(i-posicion_inicial_iteracion+1);
    size(imagen_recurrencia);
    [Area, Atotal, Apercent, Matriz_On]=umbral_area_ha_percent_recurrencia(imagen_recurrencia,Porcentaje_Recurrencia(s),p,'superior',cantidad_muestras);
    Recurrencia{g,s}.Area(i-posicion_inicial_iteracion+1)=Area;
    Recurrencia{g,s}.Area_Total=Atotal;
    Recurrencia{g,s}.Percent(i-posicion_inicial_iteracion+1)=Apercent;
    Recurrencia{g,s}.Matriz_On(:,:,i-posicion_inicial_iteracion+1)=Matriz_On;
    %se tendrá finalmente un vector con los valores de area cubierta en ese
    %sector durante el tiempo de 10 años con una recurrencia de.65
    %obtener fecha de la muestra actual 'i' año+dia
    fecha_actual=IndiceUmbral{g}.Sector{s}.fecha_juliana(i,1)+IndiceUmbral{g}.Sector{s}.fecha_juliana(i,2);
    %obtener fecha hace diez años 
    Back_n_years=fecha_actual-years_estudio*365;
    %buscar hace 10 años
    busqueda_backn_years=find(Fechas>=Back_n_years);
    posicion_siguiente_iteracion=busqueda_backn_years(1);   
    %aumento la iteracion de i
    i=1+i;
end
%cierre iteracion
end
end
%se tienen las matrices activades
%se tienen las areas activadas segun %recurrencia en periodo
%se tienen as fechas año dia
%se procede a graficar Area [ha] vs tpo de cada sector
%esto seria en base al umbral de corte encontrado anteriormente
%indica, finalmente, la zona de vegetacion aproximada que se puede
%encontrar en la zona en la fecha determinada, mostrando su evolucion,
%crecimiento o decrecimiento.

