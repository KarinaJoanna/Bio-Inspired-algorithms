%% Configuración del algoritmo genético
rng('shuffle'); % Semilla aleatoria
num_variables = 10; % Número de variables
tamano_poblacion = 100; % Tamaño de la población
num_generaciones = 1000; % Número de generaciones
rango = [-10, 10]; % Rango de los valores de las variables
prob_mutacion = 0.01; % Probabilidad de mutación

% Función objetivo
fobj = @(x) sum(arrayfun(@(i) i^2 * x(i), 1:num_variables));

% Inicialización de la población
poblacion = round(rand(tamano_poblacion, num_variables)); % Cada variable es representada por un número binario de 32 bits

% Ciclo principal del algoritmo genético
for generacion = 1:num_generaciones
    % Evaluación de la aptitud de la población
    aptitudes = arrayfun(@(i) fobj(poblacion(i,:)), 1:tamano_poblacion)';
    
    % Selección de los padres mediante torneo binario
    padres = zeros(tamano_poblacion, num_variables);
    for i = 1:tamano_poblacion
        indices_torneo = randperm(tamano_poblacion, 2); % Seleccionar 2 individuos aleatorios
        if aptitudes(indices_torneo(1)) < aptitudes(indices_torneo(2))
            padres(i,:) = poblacion(indices_torneo(1),:);
        else
            padres(i,:) = poblacion(indices_torneo(2),:);
        end
    end
    
    % Cruza de los padres mediante cruce de un punto
    hijos = zeros(tamano_poblacion, num_variables);
    for i = 1:2:tamano_poblacion
        punto_cruza = randi([1, num_variables-1]); % Seleccionar un punto de cruce aleatorio
        hijos(i,:) = [padres(i,1:punto_cruza), padres(i+1,punto_cruza+1:end)];
        hijos(i+1,:) = [padres(i+1,1:punto_cruza), padres(i,punto_cruza+1:end)];
    end
    
    % Mutación de los hijos mediante mutación uniforme
    for i = 1:tamano_poblacion
        for j = 1:num_variables
            if rand() < prob_mutacion
                hijos(i,j) = ~hijos(i,j); % Cambiar el bit
            end
        end
    end
    
    % Reemplazo de la población
    poblacion = hijos;
end

% Obtener el mejor individuo de la población final
aptitudes = arrayfun(@(i) fobj(poblacion(i,:)), 1:tamano_poblacion)';
[mejor_aptitud, mejor_individuo] = min(aptitudes);
mejor_solucion = poblacion(mejor_individuo,:);

