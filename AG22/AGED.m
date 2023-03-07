% Parámetros del algoritmo
pop_size = 10; % Tamaño de la población
vec_length = 3; % Longitud de cada vector
min_val = -10; % Valor mínimo en el vector
max_val = 10; % Valor máximo en el vector
max_iterations = 100; % Número máximo de iteraciones
mutation_rate = 0.1; % Tasa de mutación
num_targets = 3; % Número de targets

% Generar la población inicial
population = min_val + (max_val - min_val)*rand(pop_size, vec_length);
fitness_func = @(x) sum(x.^2, 2);

% Calcular la aptitud de la población inicial
fitness = zeros(pop_size, 1);
for i = 1:pop_size
    fitness(i) = fitness_func(population(i, :));
end

% Inicializar el contador de iteraciones
iteration = 1;

while iteration <= max_iterations
    % Selección de padres para cada target
    parents = zeros(3, vec_length, num_targets);
    for i = 1:num_targets
        % Generar índices aleatorios para seleccionar tres vectores de la población
        idx = randperm(pop_size, 3);
        % Seleccionar los vectores correspondientes en la población
        parents(:, :, i) = population(idx, :).';
    end

    % Crear un trial utilizando la evolución diferencial
    for i = 1:num_targets
        % Obtener los vectores de la población y los padres correspondientes
        target = population(i, :);
        parent1 = parents(1, :, i);
        parent2 = parents(2, :, i);
        parent3 = parents(3, :, i);

        % Realizar la mutación
        mutant = parent1 + mutation_rate*(parent2 - parent3);

        % Aplicar límites de valores permitidos en el vector
        mutant(mutant < min_val) = min_val;
        mutant(mutant > max_val) = max_val;

        % Realizar el cruce
        trial = target;
        crossover_point = randi([1, vec_length]);
        trial(1:crossover_point) = mutant(1:crossover_point);

        % Calcular la aptitud del target y del trial
        target_fitness = fitness(i);
        trial_fitness = fitness_func(trial);

        % Comparar la aptitud del trial con la aptitud del target
        if trial_fitness < target_fitness
            % Reemplazar el target por el trial en la población
            population(i, :) = trial;
            fitness(i) = trial_fitness;
        end
    end
    
    % Actualizar el contador de iteraciones
    iteration = iteration + 1;
end