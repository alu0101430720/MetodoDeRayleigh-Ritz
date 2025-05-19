%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Autor: Carlos Yanes Pérez.
% Asignatura de MNEDP.
% 2025
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function comparacion_spline(lista_n, a, b, spline_opc, coordx, RelTol, AbsTol)
    
    u = sol_exacta(coordx);

    errores = NaN(length(u), length(lista_n), 2);
    errores_max_n = NaN(length(lista_n), 2);
    u_aprox = errores;
    
    tiempos_1 = zeros(length(lista_n), 1);
    tiempos_3 = zeros(length(lista_n), 1);
    for i=1:length(lista_n)
        n=lista_n(i);
        if spline_opc==1
            s=S3(n, a, b, coordx, RelTol, AbsTol);
        elseif spline_opc==2
            s=S1(n, a, b, coordx, RelTol, AbsTol);
        else
            tic;
            s3 = S3(n, a, b, coordx, RelTol, AbsTol);
            tiempos_3(i) = toc;
            tic;
            s1 = S1(n, a, b, coordx, RelTol, AbsTol);
            tiempos_1(i) = toc;
        end
        
        if spline_opc < 3
           errores(:, i, 1) = error_fun(s, u);
           errores_max_n(i, 1) = max(errores(:, i, 1));

           u_aprox(:, i, 1) = s; 
        else
           errores(:, i, 1) = error_fun(s1, u);
           errores_max_n(i, 1) = max(errores(:, i, 1));
            
           errores(:, i, 2) = error_fun(s3, u);
           errores_max_n(i, 2) = max(errores(:, i, 2));

           u_aprox(:, i, 1) = s1;
           u_aprox(:, i, 2) = s3;
        end
    end

    graficar_comparacion_sol(coordx, lista_n, errores_max_n, u, u_aprox, spline_opc)
    graficar_comparacion_errores(coordx, lista_n, errores, errores_max_n, spline_opc)

    if spline_opc < 3
       tabla_error_n(errores_max_n(:, 1), lista_n, spline_opc)
       fich_opc = lower(input('¿Desea guardar un fichero .txt (s/n)? ', 's'));

    
       if fich_opc == 's'
          escribir_fich(errores_max_n(:, 1), lista_n, spline_opc)
       end
    else
       tabla_error_n(errores_max_n(:, 1), lista_n, 2) 
       tabla_error_n(errores_max_n(:, 2), lista_n, 1) 
       tiempos(spline_opc, lista_n, tiempos_1, tiempos_3)
    end

end

function y = sol_exacta(x)
    y = 63/31 * x.^2 - 32./(31*x.^3) - x.^3;
end
