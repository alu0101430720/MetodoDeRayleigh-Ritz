%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Autor: Carlos Yanes Pérez.
% Asignatura de MNEDP.
% 2025
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function escribir_fich(errores, lista_n, spline_opc)
    splines_names = {'S3', 'S1'};
    % Guardar en archivo
    filename = sprintf('tabla_errores_max_%s.txt', splines_names{spline_opc});
    fileID = fopen(filename, 'w');  % Abrir archivo para escritura
    
    fprintf(fileID, '--- Tabla de errores máx. para el espacio de aproximantes %s ---\n', splines_names{spline_opc});
    fprintf(fileID, '   n    |    Error    \n');
    fprintf(fileID, '--------+-------------\n');
    for i = 1:length(lista_n)
        fprintf(fileID, ' %4d   | %.6e \n', lista_n(i), errores(i));
    end
    
    fclose(fileID);  % Cerrar archivo

end