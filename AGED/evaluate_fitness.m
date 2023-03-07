function fitness = evaluate_fitness(population)
% Función de aptitud que evalúa la función ff = (Pob_real).^2 para una población de números reales

[n, m] = size(population); % n es el tamaño de la población y m es el número de variables de decisión
fitness = zeros(n, 1); % Vector de aptitud

for i = 1:n
    x = population(i, :); % Selecciona el individuo i
    sum = 0;
    for j = 1:m
        sum = sum + x(j)^2; % Calcula la sumatoria de la función ff
    end
    fitness(i) = sum; % Asigna la aptitud del individuo i
end

end
