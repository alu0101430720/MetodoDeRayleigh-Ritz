%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Autor: Carlos Yanes Pérez.
% Asignatura de MNEDP.
% 2025
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function graficar_aprox_solucion(n, u, s, error, coordx)
    % Graficar solución
    figure;
    hold on
    plot(coordx, u, '-r', 'LineWidth', 1.5, 'DisplayName', 'Solución exacta');
    plot(coordx, s, '--b', 'LineWidth', 1.2, 'DisplayName', 'Solución aproximada');
    grid on
    legend('show', 'Location', 'best');
    title(sprintf('n = %d, error = %.2e', n, error));
    xlabel('x');
    ylabel('');
    hold off
end