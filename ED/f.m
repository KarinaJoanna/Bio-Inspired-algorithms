function [costo] = f(individuo)
    % Calcular el costo para el individuo dado
    costo = @(x) 3*x(1) + 0.000001*x(1)^3 + 2*x(2) + (0.000002/3)*x(2)^3;
end
