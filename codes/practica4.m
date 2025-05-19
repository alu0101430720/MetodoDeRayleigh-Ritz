%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Autor: Carlos Yanes Pérez.
% Asignatura de MNEDP.
% 2025

% Con este codigo se busca implementar el metodo de Rayleigh-Ritz
% y de Garlerkin para resolver un problema de tipo Sturm-Liouville.

% Esta es la funcion principal, desde aqui pueden ejecutarse todos los
% ficheros agregados.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function practica4(a, b, part_int)
   if nargin < 2
        a = 1;
        b = 2;
        part_int = 100;
   end

    RelTol = 0;
    AbsTol = 1e-8;
    coordx=linspace(a,b, part_int);

    disp('1. Método de Rayleigh-Ritz (aproximantes en S3).')
    disp('2. Método de Garlerkin (aproximantes en S1).')
    disp('3. Comparación de aproximaciones para distintos n.')
    opc = input('Elija una opción: ');
    
    if opc < 3
        n = input('Valor para n: ');
    elseif opc == 3
        % Modificar la lista si queremos cambiar los n
        lista_n = [5, 10, 20, 40];
        disp('1. Comparar Método de Rayleigh-Ritz.')
        disp('2. Comparar Método de Garlerkin.')
        disp('3. Comparar ambos.')
        spline_opc = input('Opción: ');
    else
        disp('La selección no es válida. Vuelva a ejecutar el programa.')
    end

    switch opc
        case 1
            s=S3(n, a, b, coordx, RelTol, AbsTol);
        case 2
            s=S1(n, a, b, coordx, RelTol, AbsTol);
        case 3
            comparacion_spline(lista_n, a, b, spline_opc, coordx, RelTol, AbsTol);
    end
    
    if opc < 3
        u = sol_exacta(coordx);
        error = max(error_fun(s, u));
        fprintf('Error global para n=%d: %.6e\n', n, error);
        graficar_aprox_solucion(n, u, s, error, coordx);
    end
end

function y = sol_exacta(x)
    y = 63/31 * x.^2 - 32./(31*x.^3) - x.^3;
end
