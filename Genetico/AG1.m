% Genetico 1:  representación binaria para números reales

% Parámetros
poblacionTamano = 20; % Tamaño de la población
probMutacion = 0.7; % Probabilidad de mutación
numGeneraciones = 2500; % Número de generaciones
numElitismo = 2; % Número de individuos seleccionados por elitismo

% Inicialización de la población
poblacion = randi([0 1], poblacionTamano, 10); % Población binaria de 50 individuos con 10 genes cada uno

% Evolución de la población
% Bucle principal
for generacion = 1:numGeneraciones
    % Evaluación de la función objetivo
    fitness = zeros(size(poblacion, 1), 1);
    for i = 1:size(poblacion, 1)
        fitness(i) = funcionObjetivo(poblacion(i, :));
    end
    
    % Selección de padres
    padres = seleccionarPadres(poblacion, fitness, numElitismo);
    
    % Cruza
    hijos = cruzar(padres, poblacionTamano - numElitismo, 0.85);
    
    % Mutación
    hijos = mutar(hijos, probMutacion);
    
    % Reemplazo
        poblacion = reemplazar(poblacion, hijos, fitness);
    
        % Registro de la mejor solución
        [mejorFitness, mejorIndice] = min(fitness);
        mejorIndividuo = poblacion(mejorIndice, :);
        if generacion == 1
        mejorSolucion = mejorIndividuo;
        mejorFitnessHistorico = mejorFitness;
        else
            if mejorFitness < mejorFitnessHistorico
                mejorSolucion = mejorIndividuo;
                mejorFitnessHistorico = mejorFitness;
                mejorFitnessAbsoluto = 1/mejorFitnessHistorico;
            end
        end
end

% Resultado final

%disp('Población:');
%disp(poblacion);
for i = 1:size(poblacion, 1)
    x = poblacion(i, :);
    fx = funcionObjetivo(x);
    disp(['Individuo ', num2str(i), ': x = [', num2str(x), '], f(x) = ', num2str(fx)]);
end

disp(['Mejor solución encontrada: x = [', num2str(mejorIndividuo), '], f(x) = ', num2str(mejorFitness)]);

% Evaluación de la función objetivo para cada individuo
function fitness = funcionObjetivo(x)
    valorDecimal = bin2dec(num2str(x)) / 1023 * 20 - 10; % Conversión de binario a decimal y escalamiento a un rango entre -10 y 10
    fitness = valorDecimal^2;
end

% Selección de padres
function padres = seleccionarPadres(poblacion, fitness, numPadres)
    [~, indices] = sort(fitness);
    indices = flip(indices); % invertir el orden para que los individuos con menor fitness estén al principio
    padres = poblacion(indices(1:numPadres), :);
end

% Cruza
function hijos = cruzar(padres, numHijos, probabilidadCruza)
    hijos = zeros(numHijos, size(padres, 2));
    for i = 1:numHijos
        padre1 = padres(randi(size(padres, 1)), :);
        padre2 = padres(randi(size(padres, 1)), :);
        if rand < probabilidadCruza
        puntoCruza = randi(size(padre1, 2) - 1) + 1;
        hijo = [padre1(1:puntoCruza) padre2(puntoCruza+1:end)];
        else
        hijo = padre1;
        end
        hijos(i, :) = hijo;
    end
end

% Mutación
function hijos = mutar(hijos, probabilidadMutacion)
    for i = 1:size(hijos, 1)
        for j = 1:size(hijos, 2)
            if rand < probabilidadMutacion
            hijos(i, j) = 1 - hijos(i, j); % Cambio de bit
            end
        end
    end
end

% Reemplazo
function nuevaPoblacion = reemplazar(poblacion, hijos, fitness)
    poblacionCompleta = [poblacion; hijos];
    [~, indices] = sort(fitness);
    nuevaPoblacion = poblacionCompleta(indices(1:length(poblacion)), :);
end