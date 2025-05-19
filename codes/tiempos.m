%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Autor: Carlos Yanes Pérez.
% Asignatura de MNEDP.
% 2025
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function tiempos(spline_opc, lista_n, tiempos_1, tiempos_3)
    figure;
    hold on;
    if spline_opc == 3
        plot(lista_n, tiempos_3, '-o', 'DisplayName', 'S3', 'LineWidth', 1.5);
        plot(lista_n, tiempos_1, '-s', 'DisplayName', 'S1', 'LineWidth', 1.5);
    end
    xlabel('n');
    ylabel('Tiempo de ejecución (s)');
    title('Comparación de tiempos de ejecución');
    legend('Location', 'northwest');
    grid on;
    hold off;
end