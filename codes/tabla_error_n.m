%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Autor: Carlos Yanes Pérez.
% Asignatura de MNEDP.
% 2025
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function tabla_error_n(errores, lista_n, spline_opc)

    % Mostrar tabla con convergencia
    splines_names = {'S3', 'S1'};
    fprintf('\n--- Tabla de errores máx. para el espacio de aproximantes %s ---\n', splines_names{spline_opc});
    fprintf('   n    |    Error    \n');
    fprintf('--------+-------------\n');
    for i = 1:length(lista_n)
        fprintf(' %4d   | %.6e \n', lista_n(i), errores(i));
    end

end