clear
clc
MAX_GEN = 2500;
D = 10; % Dimensión del problema
F = 0.5; % Factor de escala
CR = 0.9; % Crossover rate

% Definir los límites del espacio de búsqueda
limite_inferior = -10;
limite_superior = 10;

% Generar población aleatoria
NP = 50; % Tamaño de la población
poblacion = limite_inferior + (limite_superior - limite_inferior) * rand(NP, D);

% Evaluar población en la función de aptitud
aptitud = zeros(NP, 1);
for i = 1:NP
    aptitud(i) = f(poblacion(i,:));
end

for g = 0:MAX_GEN
    for i = 1:NP
        % Seleccionar aleatoriamente r1 ≠ r2 ≠ r3 ≠ i
        idx = setdiff(1:NP, i); % Obtener índices diferentes a i
        r = idx(randperm(numel(idx), 3)); % Seleccionar aleatoriamente 3 índices diferentes a i
        r1 = r(1);
        r2 = r(2);
        r3 = r(3);

        jrand = randi(D);
        u = poblacion(i,:);
        for j = jrand:D 
            if rand() < CR 
                u(j) = poblacion(r1,j) + F * (poblacion(r2,j) - poblacion(r3,j));
            else
                break
            end
        end
        
        % Verificar restricciones de límites del espacio de búsqueda
        u(u < limite_inferior) = limite_inferior;
        u(u > limite_superior) = limite_superior;
        
        % Evaluar función de aptitud
        aptitud_u = f(u);
        
        % Actualizar población si el individuo mutado es mejor
        if aptitud_u <= aptitud(i)
            poblacion(i,:) = u;
            aptitud(i) = aptitud_u;
        end
    end
    poblacion
end
