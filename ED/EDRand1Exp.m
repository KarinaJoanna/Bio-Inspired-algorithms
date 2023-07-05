% ED/Rand/1/Exp
clc
clear

MAX_GEN = 200;
D = 10; % dimensión del espacio de búsqueda
F = 0.5; % Factor de escala
CR = 0.5; % Probabilidad de recombinacion

% Definir los límites del espacio de búsqueda
limite_inferior = -10;
limite_superior = 10;

% Generar población aleatoria
NP = 50; % Tamaño de la población
poblacion = limite_inferior + (limite_superior - limite_inferior) * rand(NP, D);

% Evaluar población en la función de aptitud
aptitud = sum(poblacion.^2, 2);

for g = 0:MAX_GEN
    for i = 1:NP
        % Seleccionar aleatoriamente r1 ≠ r2 ≠ r3 ≠ i
        idx = setdiff(1:NP, i); % Obtener índices diferentes a i
        r = idx(randperm(numel(idx), 3)); % Seleccionar aleatoriamente 3 índices diferentes a i
        r1 = r(1);
        r2 = r(2);
        r3 = r(3);

        % Mutación
        mut = poblacion(r1,:) + F * (poblacion(r2,:) - poblacion(r3,:));

        % CE
        jrand = randi(D); % utiliza para seleccionar una posición aleatoria en un vector de población (poblacion(i,:)) de dimensiones D.
        trial = poblacion(i,:); % vector de prueba "trial" a partir de la población actual en la posición i.
        trial(jrand) = mut(jrand); 
        for j = 1:D % itera a través de cada elemento del vector de prueba trial.
            jrand = mod(jrand, D) + 1; % se agrega 1 para obtener un índice aleatorio entre 1 y D y mod para asegurarse de que el valor de "jrand" está en el rango de 1 a D
            if rand() <= CR
                trial(jrand) = mut(jrand);
            else
                break; % pasar a la sig iteracion
            end
        end

        % Verificar restricciones de límites del espacio de búsqueda

        trial(trial < limite_inferior) = limite_inferior;
        trial(trial > limite_superior) = limite_superior;

        % Evaluar función de aptitud
        aptitud_trial = sum(trial.^2);

        % Actualizar población si el individuo mutado es mejor
        if aptitud_trial <= aptitud(i)
            poblacion(i,:) = trial;
            aptitud(i) = aptitud_trial;
        end
    end
    poblacion
end

% Obtener la mejor solución
[mejor_aptitud, mejor_idx] = min(aptitud);
mejor_solucion = poblacion(mejor_idx,:);

% Mostrar resultados
fprintf('La mejor solución encontrada es: \n');
disp(mejor_solucion);
fprintf('con un valor de la función objetivo de:');
disp(mejor_aptitud)