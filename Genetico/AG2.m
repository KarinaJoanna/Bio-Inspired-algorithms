% Genetico 2: Representación utilizando números reales

% Parámetros 
poblacionTamano = 50; % Tamaño de la población
probMutacion = 0.01; % Probabilidad de mutación
numGeneraciones = 100; % Número de generaciones
numElitismo = 2; % Número de individuos seleccionados por elitismo

% Inicialización de la población
poblacion = rand(poblacionTamano, 10) * 20 - 10; % Población de números reales entre -10 y 10

%THIS
% Evolución de la población
% Bucle principal
for generacion = 1:numGeneraciones

    % Evaluación de la función objetivo
    fitness = funcionObjetivo(poblacion);
    
    % Selección de padres
    padres = seleccionarPadres(poblacion, fitness, 2);
    
    % Cruza
    hijos = cruzar(padres, poblacionTamano - numElitismo, 0.8);
    
    % Mutación
    hijos = mutar(hijos, probMutacion);
    
    % Reemplazo
    poblacion = reemplazar(poblacion, hijos, fitness);
    
    % Registro de la mejor solución
    [mejorFitness, mejorIndice] = min(fitness);
    mejorIndividuo = poblacion(mejorIndice, :);
    if generacion == 1
    mejorSolucion = mejorIndividuo;
    end
end

% Resultado final
disp(['Mejor solución encontrada: f(', num2str(mejorSolucion), ') = ', num2str(mejorFitness)]);

% Evaluación de la función objetivo para cada individuo
function fitness = funcionObjetivo(x)
    suma = 0;
        for i = 1:10
        suma = suma + x(i)^2;
        end
    fitness = suma;
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
        hijo = (padre1 + padre2) / 2;
        else
        hijo = padre1;
        end
        hijos(i, :) = hijo;
    end
end

% Mutación
function hijos = mutar(hijos, probabilidadMutacion)
    factorMutacion = 0.1; % factor de escala para la distribución normal estándar
    for i = 1:size(hijos, 1)
        if rand < probabilidadMutacion
        hijos(i,:) = hijos(i,:) + factorMutacion * randn(1,size(hijos,2));
        end
    end
end

% Reemplazo
function nuevaPoblacion = reemplazar(poblacion, hijos, fitness)
    poblacionCompleta = [poblacion; hijos];
    [~, indices] = sort(fitness);
    nuevaPoblacion = poblacionCompleta(indices(1:length(poblacion)), :);
end


% HERE GOES 
