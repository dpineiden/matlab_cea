%calcula en base a un vector umbral, entregan el area en hecteareas y en
%porcentaje segun recuadro la zona que 'superior' o es 'inferior' a
%cierto umbral
function [Area, Area_Total, Percent, Matriz_On]=umbral_area_ha_percent_recurrencia(imagen,umbral,p,se_requiere,cantidad_muestras)
u=length(umbral);
I=imagen/cantidad_muestras;
Q=I;
Total_pixeles=numel(I);
hectarea=10000;
Area_Total=Total_pixeles*p^2/hectarea;
for i=1:u
    elemento_umbral=umbral(i);
    if strcmp(se_requiere,'superior')
    Q(Q>=elemento_umbral)=1;
    Q(Q<elemento_umbral)=0;
    elseif strcmp(se_requiere,'inferior')
    Pixeles_on=(I(I<elemento_umbral));    
    Q(Q>=elemento_umbral)=1;
    Q(Q<elemento_umbral)=0;
    end
    sumaQ=sum(Q(:));
    Area(i)=(sumaQ*p^2/hectarea);
    Percent(i)=(sumaQ/Total_pixeles);
    Matriz_On(:,:,i)=Q;
end
end