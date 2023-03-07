% Genetico 2 Representación utilizando números reales
% Parámetros del algoritmo genético
poblacionTamano = 50; % Tamaño de la población
probMutacion = 0.01; % Probabilidad de mutación
numGeneraciones = 100; % Número de generaciones
numElitismo = 2; % Número de individuos seleccionados por elitismo  % Inicialización de la población
poblacion = rand(poblacionTamano, 1) * 10 - 5; % Población de números reales entre -5 y 5

% Evaluación de la función objetivo para cada individuo
fitness = sum(poblacion.^2, 2);

% Evolución de la población
for i = 1:numGeneraciones
% Selección de padres mediante torneo binario
padres = zeros(numElitismo, 1);
padresFitness = zeros(numElitismo, 1);
for j = 1:numElitismo
indice1 = randi(poblacionTamano);
indice2 = randi(poblacionTamano);
if fitness(indice1) < fitness(indice2)
padres(j) = poblacion(indice1);
padresFitness(j) = fitness(indice1);
else
padres(j) = poblacion(indice2);
padresFitness(j) = fitness(indice2);
end
end
% Cruzamiento mediante interpolación lineal
hijos = zeros(poblacionTamano - numElitismo, 1);
for j = 1:2:(poblacionTamano - numElitismo)
    alfa = rand();
    hijos(j) = alfa * padres(1) + (1 - alfa) * padres(2);
    hijos(j+1) = (1 - alfa) * padres(1) + alfa * padres(2);
end

% Mutación con probabilidad probMutacion
for j = 1:size(hijos, 1)
    if rand() < probMutacion
        hijos(j) = hijos(j) + randn() * 0.1;
    end
end

% Reemplazo de la población anterior con los hijos generados
poblacion = [padres; hijos];
fitness = sum(poblacion.^2, 2);

% Selección de los mejores individuos mediante elitismo
[~, indicesElitismo] = sort(fitness);
poblacion(indicesElitismo(1:numElitismo), :) = padres;
fitness(indicesElitismo(1:numElitismo)) = padresFitness;
end

% Resultado final

[mejorFitness, mejorIndice] = min(fitness);
mejorIndividuo = poblacion(mejorIndice);
disp(['Mejor solución encontrada: f(', num2str(mejorIndividuo), ') = ', num2str(mejorFitness)]);