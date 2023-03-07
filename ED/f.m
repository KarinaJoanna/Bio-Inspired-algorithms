function [costo] = f(individuo)
% Calcular el costo para el individuo dado
costo = sum(individuo.^2);
end
