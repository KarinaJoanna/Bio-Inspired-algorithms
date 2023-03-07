% Ciclo principal del algoritmo
for gen = 1:num_gen
    
    % Generación de la nueva población
    new_pop = zeros(pop_size, num_vars); % Vector para la nueva población
    for i = 1:pop_size
        
        % Selección de los individuos
        r = randperm(pop_size, 4); % Selección aleatoria de cuatro individuos
        x1 = pop(r(1), :);
        x2 = pop(r(2), :);
        x3 = pop(r(3), :);
        x4 = pop(i, :);
        
        % Evolución diferencial
        v = x1 + F*(x2 - x3);
        j_rand = randi(num_vars);
        for j = 1:num_vars
            if (rand < CR || j == j_rand)
                u(j) = v(j);
            else
                u(j) = x4(j);
            end
        end
        
        % Evaluación de la aptitud del individuo generado
        f_u = evaluate_fitness(u); % Función de aptitud a implementar
        
        % Selección del mejor individuo
        if (f_u < fitness(i))
            new_pop(i, :) = u;
            fitness(i) = f_u;
        else
            new_pop(i, :) = pop(i, :);
        end
        
        % Mostrar el progreso
        disp(['Generación: ', num2str(gen), ', Individuo: ', num2str(i), ', Aptitud: ', num2str(fitness(i))]);
        
    end
    
    % Reemplazo de la población antigua por la nueva
    pop = new_pop;
    
    % Mostrar la mejor solución encontrada en la generación actual
    [best_fitness, best_index] = min(fitness);
    best_individual = pop(best_index, :);
    disp(['Mejor solución encontrada en la generación ', num2str(gen), ':']);
    disp(['Aptitud: ', num2str(best_fitness)]);
    disp(['Valores: ', num2str(best_individual)]);
    
end

