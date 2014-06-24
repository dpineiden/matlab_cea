function Real_Indice=inversa_indice(Matriz, minimo, maximo,bits)
Real_Indice=Matriz*(maximo-minimo)/(2^bits-1)+minimo;
end