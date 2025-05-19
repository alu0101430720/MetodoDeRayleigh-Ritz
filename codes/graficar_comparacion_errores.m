%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Autor: Carlos Yanes Pérez.
% Asignatura de MNEDP.
% 2025
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function graficar_comparacion_errores(coordx, lista_n, errores, errores_max_n, spline_opc)
    figure;  
    sgtitle('Errores') 
    for i=1:length(lista_n)  
        n=lista_n(i);
        if spline_opc < 3
            % Graficar errores
            subplot(2, ceil(length(lista_n)/2), i);
            hold on
            plot(coordx, errores(:, i, 1), 'b', 'LineWidth', 1.2);
            grid on
            title(sprintf('n = %d, error = %.2e\n', n, errores_max_n(i, 1)));
            xlabel('x');
            ylabel('y');
            hold off
        
        else
            % Graficar errores
            subplot(2, ceil(length(lista_n)/2), i);
            hold on
            plot(coordx, errores(:, i, 1), 'b', 'LineWidth', 1.2, 'DisplayName', 'Error (s1)');
            plot(coordx, errores(:, i, 2), 'g', 'LineWidth', 1.2, 'DisplayName', 'Error (s3)');
            grid off
            %legend('show', 'Location', 'south');
            title(sprintf('n = %d\n', n));
            xlabel('x');
            ylabel('');
            set(gca,'yscale','log');
            hold off
        end
    end

    if spline_opc < 3
        figure;
        hold on
        
        % Colores diferentes para cada curva
        colores = lines(length(lista_n));
        
        for i = 1:length(lista_n)
            n = lista_n(i);
            plot(coordx, errores(:, i, 1), ...
                 'Color', colores(i, :), ...
                 'LineWidth', 1.2, ...
                 'DisplayName', sprintf('Error con n = %d', n));
        end
        
        grid off
        title('Errores para cada n');
        xlabel('x');
        ylabel('y');
        set(gca, 'yscale', 'log');
        legend('show', 'Location', 'south');
        hold off
        return
    else
        legend('show', 'Location', 'south');
        figure;
        hold on
        
        colores = lines(length(lista_n));
        handles = gobjects(length(lista_n), 1); % Preasigna el vector con tamaño fijo
        
        for i = 1:length(lista_n)
            n = lista_n(i);
            
            plot(coordx, errores(:, i, 1), ...
                 'Color', colores(i, :), ...
                 'LineWidth', 1.2, ...
                 'LineStyle', '--');
            
            handles(i) = plot(coordx, errores(:, i, 2), ...
                              'Color', colores(i, :), ...
                              'LineWidth', 1.2, ...
                              'DisplayName', sprintf('Error con n = %d', n));
        end
        
        grid off
        title('Errores para cada n');
        xlabel('x');
        ylabel('y');
        set(gca, 'yscale', 'log');
        
        legend(handles, 'Location', 'south');
        
        hold off
    end
end