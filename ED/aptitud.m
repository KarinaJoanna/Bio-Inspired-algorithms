function [f, penalty] = aptitud(x)
    % Función de aptitud con función de penalización
    
    % Restricciones de desigualdad
    g1 = -x(4) + x(3) - 0.55;
    g2 = -x(3) + x(4) - 0.55;
    
    % Función de aptitud sin restricciones
    f = 3*x(1) + 0.000001*x(1)^3 + 2*x(2) + (0.000002/3)*x(2)^3;
    
    % Función de penalización para restricciones de desigualdad
    factor_penalizacion = 1000; % Número grande
    penalty = factor_penalizacion * max(0, g1)^2 + factor_penalizacion * max(0, g2)^2;
    
    % Función de aptitud con penalización
    f = f + penalty;
end
