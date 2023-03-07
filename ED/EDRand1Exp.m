% Definir la función objetivo
f = @(x) sum(x.^2); % Función de prueba (suma de cuadrados)

% Parámetros del algoritmo
MAX_GEN = 200; % Número máximo de generaciones
NP = 50; % Tamaño de la población
F = 0.5; % Factor de amplificación de la diferencia
CR = 0.9; % Tasa de recombinación
D = 5; % Número de variables de decisión

% Definir los límites del espacio de búsqueda
limite_inferior = -10;
limite_superior = 10;

% Generar población aleatoria
poblacion = limite_inferior + (limite_superior - limite_inferior) * rand(NP, D);

% Evaluar población en la función de aptitud
aptitud = zeros(NP, 1);
for i = 1:NP
    aptitud(i) = f(poblacion(i,:));
end

for g = 0:MAX_GEN
    for i = 1:NP
        % Seleccionar aleatoriamente r1, r2, r3
        idx = setdiff(1:NP, i); % Obtener índices diferentes a i
        r = idx(randperm(numel(idx), 3)); % Seleccionar aleatoriamente 3 índices diferentes a i
        r1 = r(1);
        r2 = r(2);
        r3 = r(3);

        % Generar un vector de diferencia aleatorio
        v_diff = poblacion(r1,:) + F * (poblacion(r2,:) - poblacion(r3,:));

        % Mutación/extrapolación
        v_exp = poblacion(i,:) + CR * (v_diff - poblacion(i,:));

        % Verificar restricciones de límites del espacio de búsqueda
        v_exp(v_exp < limite_inferior) = limite_inferior;
        v_exp(v_exp > limite_superior) = limite_superior;

        % Evaluar función de aptitud
        aptitud_exp = f(v_exp);

        % Actualizar población si el individuo mutado es mejor
        if aptitud_exp <= aptitud(i)
            poblacion(i,:) = v_exp;
            aptitud(i) = aptitud_exp;
        end
    end
end
