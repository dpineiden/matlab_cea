function nietos_Path=listar_nietos_directorio(Directorio_Padre)
cd Directorio_Padre
Hijo=1;
[lista_archivos{Hijo,1} lista_directorios{Hijo,1} lin_dir{Hijo,1} n_linea_dir]=listar_directorio(Directorio_Padre,Hijo);
%lista_archivos es el txt que tiene la lista de todos los archivos en lista
%dentro del directorio actual
%lista_directorios es el txt que tiene la lista de todos los directorios
%hijos del actual
%poner un while (mientras) lar
%leemos lista_directorios
Dir_char='/';
FID_D=fopen(lista_directorios{Hijo,1},'r')
D=1;
Hijo=2;
    while ~feof(FID_D)
        FID_A=fopen(lista_archivos{Hijo,1},'r')
        leer_linea_D=fgetl(FID_D)
        m=n_linea_dir(D);
        k=n_linea_dir(D+1);
        %siempre k es mayor que m ya que corresponde a una linea posterior
        %en lista_archivos
        a=1;
        while ~feof(FID_A)
        	leer_linea_A=fgetl(FID_A)
                if (k-2)-(m+4)>
                    nuevo_a=1;
                    N_A=length(leer_linea_A);
                    patron=leer_linea_A;
                    str=' ';
                    k=strfnd(patron,str);
                    k_espacio=k(length(k));
                    if eq(Dir_char,leer_linea_A(N_A)) 
                        Nuevo_Directorio=leer_linea_A(k_espacio+1,N-1)
                        Directorio_Padre{Hijo,1}=[Directorio_Padre{Hijo-1,1},'/',Nuevo_Directorio]
                        [lista_archivos{Hijo,1} lista_directorios{Hijo,1} lin_dir{Hijo,1} n_linea_dir]=listar_directorio(Directorio_Padre,Hijo);
                    else
                        Nuevo_Archivo{nuevo_a}=[Directorio_Padre{Hijo-1,1},'/',leer_linea_A(k_espacio+1,N)];  
                        nuevo_a=nuevo_a+1;
                    end
                end
            a=1+a;
        end
        %guardar archivos txt con nombre nuevo directorio       
        fclose(FID_A);     
    end
fclose(FID_D); 
end
