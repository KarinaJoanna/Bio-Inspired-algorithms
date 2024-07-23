% PROBLEMA 1: Con PSO

clear
clc

% Parámetros 
num_particulas = 50;
num_iteraciones = 2500;

% Peso de la inercia
w = 0.1; 

% Factores de aprendizaje (cognitivo y social)
c1 = 2.0; 
c2 = 1.2;

% Límites del espacio de búsqueda

limite_inferior = [500 1200 5000 100 200 200 200 200];
limite_superior = [600 1500 5200 200 300 300 300 400];

%limite_inferior = [100 1000 100 10 10 10 10 10]; 
%limite_superior = [10000 10000 10000 1000 1000 1000 1000 1000];


% Generar aleatoriamente un cúmulo inicial de soluciones
cum_inicial = repmat(limite_inferior, num_particulas, 1) + rand(num_particulas, 8) .* repmat((limite_superior - limite_inferior), num_particulas, 1);
velocidades = zeros(num_particulas, 8);
pbest = cum_inicial;
gbest = pbest(1,:);

% Evaluar la función objetivo para cada partícula
aptitudes = zeros(num_particulas, 1);
for i = 1:num_particulas
    % Para cada partícula, se evalúa la función objetivo y las restricciones para su posición actual
    if checkValidity(cum_inicial(i,:))
        aptitudes(i) = funcion_objetivo(cum_inicial(i,:)); 
    else
        aptitudes(i) = Inf;
    end
    % Se compara el valor de la aptitud actual de la partícula con el valor
    % de la aptitud del mejor individuo encontrado hasta el momento "gbest"
    if aptitudes(i) < funcion_objetivo(gbest)
        % Si la aptitud actual de la partícula es menor que la del mejor individuo encontrado
        % entonces se actualiza el valor de "gbest" con la posición actual de la partícula
        gbest = cum_inicial(i,:);
    end
end

for iteracion = 1:num_iteraciones
    % Actualizar la velocidad y la posición de cada partícula
    for i = 1:num_particulas
        r1 = rand();
        r2 = rand();

        % Formula de vuelo
        velocidades(i,:) = w * velocidades(i,:) + c1 * r1 * (pbest(i,:) - cum_inicial(i,:)) + c2 * r2 * (gbest - cum_inicial(i,:));

        % Se realiza el vuelo
        cum_inicial(i,:) = cum_inicial(i,:) + velocidades(i,:);

        % Verificar que las posiciones estén dentro del espacio de búsqueda
        cum_inicial(i,cum_inicial(i,:) < limite_inferior) = limite_inferior(cum_inicial(i,:) < limite_inferior);
        cum_inicial(i,cum_inicial(i,:) > limite_superior) = limite_superior(cum_inicial(i,:) > limite_superior);

        % Evaluar las restricciones para la nueva posición de la partícula
        if g1(cum_inicial(i,:)) > 0 || g2(cum_inicial(i,:)) > 0 || g3(cum_inicial(i,:)) > 0
            % Si alguna restricción se viola, la partícula es inválida y se vuelve a evaluar en la siguiente iteración
            aptitudes(i) = Inf;
            continue
        end

        % Evaluar la función objetivo para la nueva posición de la partícula
        aptitud_actual = funcion_objetivo(cum_inicial(i,:));

        % Actualizar el pbest y el gbest si corresponde
        % Compara la aptitud actual con el valor actual de aptitudes(i), que es la aptitud de la partícula i en su mejor posición conocida hasta el momento (pbest):
        if aptitud_actual < aptitudes(i)
            % Si la aptitud actual es menor que la aptitud almacenada en aptitudes(i), se actualiza pbest para la partícula i
            pbest(i,:) = cum_inicial(i,:);
            % Se actualiza aptitudes(i) con el valor de la aptitud actual
            aptitudes(i) = aptitud_actual;
            % Si la aptitud actual es menor que la aptitud de la mejor partícula conocida (gbest)
            if aptitud_actual < funcion_objetivo(gbest)
                % Se actualiza gbest con la nueva posición de la partícula i
                gbest = cum_inicial(i,:);
            end
        end

    end
    
    % Verificar si se cumple alguna condición de parada
    % En este caso, se puede detener la iteración si todas las partículas son inválidas
    if all(isinf(aptitudes))
        break
    end

end


% Crear vector de iteraciones
iteraciones = 1:num_iteraciones;

% Crear vector de aptitudes del mejor individuo encontrado
mejor_aptitud = zeros(1,num_iteraciones);
for i=1:num_iteraciones
    mejor_aptitud(i) = funcion_objetivo(gbest);
end

% Mostrar resultado
disp("El mejor individuo encontrado es:")
disp(gbest)
disp("con un valor de la función objetivo de:")
disp(funcion_objetivo(gbest))