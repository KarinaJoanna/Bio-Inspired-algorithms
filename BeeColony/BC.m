clear
clc

% Parámetros del algoritmo
NUM_FUENTES = 20; % número de fuentes de alimento
NUM_EMPLEADAS = round(0.5*NUM_FUENTES); % número de abejas empleadas
NUM_ESPERA = round(0.5*NUM_FUENTES); % número de abejas en espera
NUM_MAX_GEN = 5000; % número máximo de generaciones
LIMITE_INF = -5; % límite inferior de búsqueda
LIMITE_SUP = 5; % límite superior de búsqueda
LIMITE_ABANDONO = 10; % límite de intentos antes de abandonar una fuente

% Inicialización de las fuentes de alimentos
fuentes = LIMITE_INF + (LIMITE_SUP - LIMITE_INF) .* rand(NUM_FUENTES, 3);
valores = zeros(NUM_FUENTES, 1);
abandonos = zeros(NUM_FUENTES, 1); % contador de abandonos por fuente

% Evaluación de las fuentes de alimentos
for i = 1:NUM_FUENTES
    valores(i) = funcion_objetivo(fuentes(i,:));
end

% Ciclo de búsqueda
for generacion = 1:NUM_MAX_GEN
    % Abejas empleadas
    for i = 1:NUM_EMPLEADAS
        % Seleccionar una fuente de alimento aleatoria
        fuente = randi([1, NUM_FUENTES]);
        % Generar un valor aleatorio para φij
        phi = -1 + 2*rand();
        % Generar una nueva solución
        nueva_solucion = fuentes(fuente,:) + phi*(fuentes(fuente,:) - fuentes(randi([1, NUM_FUENTES]),:));
        % Evaluar la nueva solución
        nuevo_valor = funcion_objetivo(nueva_solucion);
        % Si la nueva solución es mejor, actualizar la fuente de alimento
        if nuevo_valor < valores(fuente)
            fuentes(fuente,:) = nueva_solucion;
            valores(fuente) = nuevo_valor;
            abandonos(fuente) = 0; % reiniciar contador de abandonos
        else
            abandonos(fuente) = abandonos(fuente) + 1; % incrementar contador de abandonos
        end
        % Si la fuente de alimento ha sido abandonada muchas veces, 
        % reemplazarla por una nueva fuente de alimento aleatoria
        if abandonos(fuente) >= LIMITE_ABANDONO
            fuentes(fuente,:) = LIMITE_INF + (LIMITE_SUP - LIMITE_INF) .* rand(1,3);
            valores(fuente) = funcion_objetivo(fuentes(fuente,:));
            abandonos(fuente) = 0;
        end
    end
    
    % Abejas en espera
    % Para que tuviera la oportunidad de evaluar todas las fuentes en cada iteración, 
    % se movio el bucle externo dentro del bucle interno.
    % for fuente = 1:NUM_FUENTES
        %for intento = 1:NUM_ESPERA
        % se cambia por:
            % for intento = 1:NUM_ESPERA
            % for fuente = 1:NUM_FUENTES
    abandonos = zeros(NUM_FUENTES,1); % reiniciar el contador de abandonos para cada fuente
    for intento = 1:NUM_ESPERA
        for fuente = 1:NUM_FUENTES
            % Generar un valor aleatorio para φij
            phi = -1 + 2*rand();
            % Seleccionar t fuentes de alimento aleatorias
            t = randi([1, NUM_FUENTES]);
            indices = randperm(NUM_FUENTES, t);
            fuentes_aleatorias = fuentes(indices,:);
            % Encontrar la mejor fuente de alimento de las t fuentes aleatorias
            [~, mejor_fuente] = min(valores(indices));
            % Generar una nueva solución
            nueva_solucion = fuentes(fuente,:) + phi*(fuentes(mejor_fuente,:) - fuentes(randi([1, NUM_FUENTES]),:));
            % Evaluar la nueva solución
            nuevo_valor = funcion_objetivo(nueva_solucion);
            % Si la nueva solución es mejor, actualizar la fuente de alimento
            if nuevo_valor < valores(fuente)
                fuentes(fuente,:) = nueva_solucion;
                valores(fuente) = nuevo_valor;
            end
            % Si la fuente de alimento ha sido abandonada muchas veces, 
            % reemplazarla por una nueva fuente de alimento aleatoria
            if (valores(fuente) == valores(mejor_fuente))
                abandonos(fuente) = abandonos(fuente) + 1;
            else
                abandonos(fuente) = 0;
            end
            if abandonos(fuente) >= LIMITE_ABANDONO
                fuentes(fuente,:) = LIMITE_INF + (LIMITE_SUP - LIMITE_INF) .* rand(1,3);
                valores(fuente) = funcion_objetivo(fuentes(fuente,:));
                abandonos(fuente) = 0;
            end
        end
    end


    % Abejas exploradoras
    for i = NUM_EMPLEADAS+1:NUM_FUENTES
        % Generar una nueva solución aleatoria
        nueva_solucion = LIMITE_INF + (LIMITE_SUP - LIMITE_INF) .* rand(1,3);
        % Evaluar la nueva solución
        nuevo_valor = funcion_objetivo(nueva_solucion);
        % Si la nueva solución es mejor que la fuente de alimento correspondiente,
        % actualizar la fuente de alimento
        if nuevo_valor < valores(i)
            fuentes(i,:) = nueva_solucion;
            valores(i) = nuevo_valor;
        end
    end
end

    % Encontrar la mejor fuente de alimento
    [~, mejor_fuente] = min(valores);
    
    % Imprimir la mejor solución encontrada
    fprintf('Mejor solución encontrada:\n');
    disp(fuentes(mejor_fuente,:));
    fprintf('Valor de la función objetivo en la mejor solución: %f\n', valores(mejor_fuente));
    