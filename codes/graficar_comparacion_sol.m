%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Autor: Carlos Yanes Pérez.
% Asignatura de MNEDP.
% 2025
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function  graficar_comparacion_sol(coordx, lista_n, errores_max_n, u, u_aprox, spline_opc)   
figure; 
    sgtitle('Solución vs. Aproximación') 
    for i=1:length(lista_n)    
        n=lista_n(i);
        if spline_opc < 3
        
            % Graficar solución
            subplot(2, ceil(length(lista_n)/2), i);
            hold on
            plot(coordx, u, '-r', 'LineWidth', 1.5, 'DisplayName', 'Solución exacta');
            plot(coordx, u_aprox(:, i, 1), '--b', 'LineWidth', 1.2, 'DisplayName', 'Solución aproximada');
            grid on
            %legend('show', 'Location', 'south');
            title(sprintf('n = %d, error = %.2e\n', n, errores_max_n(i, 1)));
            xlabel('x');
            ylabel('y');
            hold off
        
        else
            % Graficar solución
            subplot(2, ceil(length(lista_n)/2), i);
            hold on
            plot(coordx, u, '-r', 'LineWidth', 1.5, 'DisplayName', 'Solución exacta');
            plot(coordx, u_aprox(:, i, 1), '--b', 'LineWidth', 1.2, 'DisplayName', 'Solución aproximada (s1)');
            plot(coordx, u_aprox(:, i, 2), '--g', 'LineWidth', 1.2, 'DisplayName', 'Solución aproximada (s3)');
            grid on
            %legend('show', 'Location', 'south');
            title(sprintf('n = %d\n', n));
            xlabel('x');
            ylabel('');
            hold off
        end
        
    end
    legend('show', 'Location', 'best');
end