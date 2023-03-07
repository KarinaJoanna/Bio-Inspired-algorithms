function [hijo1, hijo2] = cruzaindividuos(individuo1, individuo2)
% Realiza la cruza de dos individuos en un algoritmo genético de números reales.

    n_vars = size(individuo1, 2); % Obtener el número de variables del individuo
    
    % Seleccionar un punto de cruza al azar para cada variable
    pc = randi(n_vars, 1, n_vars);
    
    % Generar los hijos a partir de la cruza de los padres en cada variable
    hijo1 = zeros(1, n_vars);
    hijo2 = zeros(1, n_vars);
    for i = 1:n_vars
        if rand < 0.5 % Si es menor que 0.5, el primer hijo hereda del primer padre y el segundo hijo hereda del segundo padre
            hijo1(i) = individuo1(i);
            hijo2(i) = individuo2(i);
        else % Si es mayor que 0.5, el primer hijo hereda del segundo padre y el segundo hijo hereda del primer padre
            hijo1(i) = individuo2(i);
            hijo2(i) = individuo1(i);
        end
        
        % Aplicar la cruza para la variable i solamente si el punto de cruza es menor o igual a i
        if pc(i) <= i
            temp = hijo1(i);
            hijo1(i) = hijo2(i);
            hijo2(i) = temp;
        end
    end
end
