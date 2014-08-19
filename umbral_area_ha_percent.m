%calcula en base a un vector umbral, entregan el area en hecteareas y en
%porcentaje segun recuadro la zona que 'superior' o es 'inferior' a
%cierto umbral
function [Area, Area_Total, Percent, Matriz_On]=umbral_area_ha_percent(imagen,umbral,p,se_requiere)
u=length(umbral);
I=imagen;
Q=I;
Total_pixeles=numel(I);
hectarea=10000;
Area_Total=Total_pixeles*p^2/hectarea;
for i=1:u
    elemento_umbral=umbral(i)
    if strcmp(se_requiere,'superior')
    Pixeles_on=numel(I(I>elemento_umbral-0.01));
    Q(Q<elemento_umbral)=0;
    Q(Q>=elemento_umbral)=1;
    elseif strcmp(se_requiere,'inferior')
    Pixeles_on=(I(I<elemento_umbral+0.01));   
    Q(Q<elemento_umbral)=0;
    Q(Q>=elemento_umbral)=1;
    end
    Area(i)=Pixeles_on*p^2/hectarea;
    Percent(i)=Pixeles_on/Total_pixeles;
    Matriz_On(:,:,i)=Q;
end
end