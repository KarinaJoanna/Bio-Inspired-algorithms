% Parámetros 
pop_size = 50; % Tamaño de la población
num_vars = 10; % Número de variables en la función objetivo
li = -10; % Límite inferior de las variables
ls = 10; % Límite superior de las variables
num_generations = 100; % Número de generaciones
mutation_rate = 0.01; % Tasa de mutación

% Inicialización de la población
population = li + (ls-li)*rand(pop_size,num_vars);

% Evaluación de la función objetivo
fitness = zeros(pop_size,1);
for i=1:pop_size
    fitness(i) = sum(power(population(i,:),1:10) - 10);
end

% Bucle principal del algoritmo genético
for gen=1:num_generations
    
    % Selección de padres por torneo binario
    parent_idxs = zeros(pop_size,2);
    for i=1:pop_size
        tournament_idxs = randperm(pop_size,2);
        if fitness(tournament_idxs(1)) < fitness(tournament_idxs(2))
            parent_idxs(i,:) = tournament_idxs(1:2);
        else
            parent_idxs(i,:) = tournament_idxs(2:-1:1);
        end
    end
    
    % Cruce de los padres
    children = zeros(pop_size,num_vars);
    for i=1:pop_size
        parent1 = population(parent_idxs(i,1),:);
        parent2 = population(parent_idxs(i,2),:);
        crossover_point = randi(num_vars-1);
        children(i,:) = [parent1(1:crossover_point) parent2(crossover_point+1:end)];
    end
    
    % Mutación de los hijos
    for i=1:pop_size
        if rand() < mutation_rate
            mutation_point = randi(num_vars);
            children(i,mutation_point) = li + (ls-li)*rand();
        end
    end
    
    % Evaluación de la función objetivo de los hijos
    children_fitness = zeros(pop_size,1);
    for i=1:pop_size
        children_fitness(i) = sum(power(children(i,:),1:10) - 10);
    end
    
    % Selección de la nueva población por elitismo
    new_population = zeros(pop_size,num_vars);
    new_fitness = zeros(pop_size,1);
    for i=1:pop_size
        if fitness(i) < children_fitness(i)
            new_population(i,:) = population(i,:);
            new_fitness(i) = fitness(i);
        else
            new_population(i,:) = children(i,:);
            new_fitness(i) = children_fitness(i);
        end
    end
    
    % Actualización de la población y la función objetivo
    population = new_population;
    fitness = new_fitness;
    
    % Mostrar información de la generación actual
    fprintf('Generación %d: Mejor valor de la función objetivo = %.4f\n', gen, min(fitness));
end

% Mostrar el mejor individuo encontrado
[best_fitness, best_idx] = min(fitness);
best_individual = population(best_idx,:);
fprintf('Mejor valor de la función objetivo encontrado: %.4f\n', best_fitness);
fprintf('Variables que producen el mejor valor: [');
for i=1:num_vars
    fprintf('%.4f ', best_individual(i));
end
