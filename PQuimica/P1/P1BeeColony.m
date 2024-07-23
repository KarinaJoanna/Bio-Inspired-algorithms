clear
clc

% Parámetros del algoritmo
NUM_FUENTES = 20; % número de fuentes de alimento
NUM_EMPLEADAS = round(0.5*NUM_FUENTES); % número de abejas empleadas
NUM_ESPERA = round(0.5*NUM_FUENTES); % número de abejas en espera
NUM_MAX_GEN = 5000; % número máximo de generaciones
LIMITE_INF = [500 1200 5000 100 200 200 200 200]; % límites inferiores de búsqueda
LIMITE_SUP = [600 1500 5200 200 300 300 300 400]; % límites superiores de búsqueda
LIMITE_ABANDONO = 10; % límite de intentos antes de abandonar una fuente

% Inicialización de las fuentes de alimentos
fuentes = repmat(LIMITE_INF, NUM_FUENTES, 1) + rand(NUM_FUENTES, 8).*(repmat(LIMITE_SUP-LIMITE_INF, NUM_FUENTES, 1));
valores = zeros(NUM_FUENTES, 1);
abandonos = zeros(NUM_FUENTES, 1); % contador de abandonos por fuente

% Evaluación de las fuentes de alimentos
for i = 1:NUM_FUENTES
    [valores(i), restricciones] = funcion_objetivobees(fuentes(i,:));
    abandonos(i) = 0;
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
        nuevo_valor = funcion_objetivobees(nueva_solucion);
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
            fuentes(fuente,:) = LIMITE_INF + (LIMITE_SUP - LIMITE_INF) .* rand(1,8);
            valores(fuente) = funcion_objetivobees(fuentes(fuente,:));
            abandonos(fuente) = 0;
        end
    end
    
    % Abejas en espera
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
                fuentes(fuente,:) = LIMITE_INF + (LIMITE_SUP - LIMITE_INF) .* rand(1,8);
                valores(fuente) = funcion_objetivobees(fuentes(fuente,:));
                abandonos(fuente) = 0;
            end
        end
    end


    % Abejas exploradoras
    for i = NUM_EMPLEADAS+1:NUM_FUENTES
        % Generar una nueva solución aleatoria
        nueva_solucion = LIMITE_INF + (LIMITE_SUP - LIMITE_INF) .* rand(1,8);
        % Evaluar la nueva solución
        nuevo_valor = funcion_objetivobees(nueva_solucion);
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