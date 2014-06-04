function [hist,Ib]=valores_histograma(Imagen,I,b)

[n,m]=size(Imagen);
ImD=double(Imagen);
bits=2^b;
h=zeros(1,bits);

for i=1:n
    for j=1:m
        k = ImD(i,j);
        h(k+1) = h(k+1)+1;
    end
end

I_b=[];
hist_b=[];
k=1;
for i=1:length(I)
if hist(i)>0
hist_b(k)=hist(i);
I_b(k)=I(i);
k=k+1;
end
end

hist=[];
hist=hist_b;

end