% Parámetros
poblacionTamano = 20; % Tamaño de la población
probMutacion = 0.7; % Probabilidad de mutación
numGeneraciones = 2500; % Número de generaciones
numElitismo = 2; % Número de individuos seleccionados por elitismo

resultados = cell(1,30); % Inicializar una celda para almacenar los resultados de las 30 ejecuciones

for ejecucion = 1:30 % Iterar 30 veces
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
            end
        end
    end

    % Resultados de la ejecución
    ejecucion_resultados = zeros(poblacionTamano, 12);
    for i = 1:size(poblacion, 1)
        x = poblacion(i, :);
        fx = funcionObjetivo(x);
        ejecucion_resultados(i,:) = [ejecucion, x, fx];
    end
    resultados{ejecucion} = ejecucion_resultados;
end

% Concatenar los resultados de todas las ejecuciones
todos_los_resultados = cat(1, resultados{:});

% Imprimir los resultados
disp('Ejecución Semilla X1 X2 X3 X4 X5 X6 X7 X8 X9 X10 f(x)');
for i = 1:size(todos_los_resultados, 1)
    disp(sprintf('%d %d %0.4f %0.2f %0.2f %0.2f %0.2f %0.2f %0.2f %0.2f %0.2f %0.2f %0.2f', todos_los_resultados(i,:)));
end


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