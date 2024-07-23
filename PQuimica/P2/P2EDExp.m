% PROBLEMA 1: Se utiliza ED exponencial

clc
clear

k1 = 0.09755988;
k2 = 0.99*k1; 
k3 = 0.0391908;
k4 = 0.9*k3;

f = @(x) (k2*x(:,6).*(1 + k3) + k1*(1 + k2*x(:,6))) ./ ((1 + k1*x(:,5)).*(1 + k2*x(:,6)).*(1 + k3*x(:,5)).*(1 + k4*x(:,6)));

g1 = @(x) x(5) - 10^5;
g2 = @(x) x(6) - 10^5;
g3 = @(x) 16 - x(5);
g4 = @(x) 16 - x(6);
g5 = @(x) sqrt(x(5)) + sqrt(x(6)) - 4;
g = @(x) g1(x) + g2(x) + g3(x) + g4(x) + max(0, g5(x))^2;

MAX_GEN = 2500;
D = 6; % dimensión del espacio de búsqueda
F = 0.7; % Factor de escala
CR = 0.9; % Probabilidad de recombinacion

% Definir los límites del espacio de búsqueda
limite_inferior = [0, 0, 0, 0, 10^-5, 10^5];
limite_superior = [0, 0, 0, 0, 16, 16];

% Generar población aleatoria
NP = 50; % Tamaño de la población
%D = length(limite_inferior); % Dimensión del espacio de búsqueda
%poblacion = limite_inferior + (limite_superior - limite_inferior) .* rand(NP, D);

poblacion = rand(NP, D) .* (limite_superior - limite_inferior) + limite_inferior;

aptitud = zeros(NP,1);
evaluacion_G = zeros(NP, 1);  
evaluacion_H = zeros(NP, 1);
trial = zeros(1,D);

% Evaluar población en la función de aptitud
deb = zeros(NP, 1);

for i = 1:NP
    x = poblacion(i,:);
    deb(i) = f(x); % FO
    evaluacion_G(i) = g1(x);
    evaluacion_H(i) = g2(x);
    g3_val = g3(x);
    g4_val = g4(x);
    g5_val = g5(x);
    g = [g1(x); g2(x); g3_val; g4_val; g5_val]; % evaluación de restricciones
    if any(g > 0)
        %deb(i) = inf;
    else
        deb(i) = sum(x(1:3));
        if g1(x) > 0 || g2(x) > 0 || g3_val > 0 || g4_val > 0 || g5_val > 0
            %deb(i) = inf;
        end
    end
    aptitud(i) = deb(i);
end


for g = 1:MAX_GEN
    for i = 1:NP

        % Seleccionar tres vectores aleatorios
        r = randperm(NP,3);
        while r(1) == r(2) || r(1) == r(3) || r(2) == r(3)
            r = randperm(NP,3);
        end
    
        % Mutación
        mut = poblacion(r(1),:) + F * (poblacion(r(2),:) - poblacion(r(3),:));
    
        % Reparador 
        for k = 1:D
            if mut(k) < limite_inferior(k)
                mut(k) = limite_inferior(k);
            elseif mut(k) > limite_superior(k)
                mut(k) = limite_superior(k);
            end
        end

        % CE
        trial = poblacion(i,:);
        jrand = randi(D);
        trial(jrand) = mut(jrand);
        L = randi(D-1) + 1;
        for k = 1:D
            if rand() <= CR || k == jrand || k >= jrand+L
                trial(k) = mut(k);
            end
        end

        % Evaluación del hijo
        x = trial;
        g1_val = g1(x);
        g2_val = g2(x);
        g3_val = g3(x);
        g4_val = g4(x);
        g5_val = g5(x);
        evaluacion_G_hijo = [g1_val; g2_val; g3_val; g4_val; g5_val];
        if any(evaluacion_G_hijo > 0)
            deb_hijo = inf;
        else
            deb_hijo = sum(x(1:3));
        end
            aptitud_i = deb_hijo;

        % Actualizar población si el individuo mutado es mejor
        if aptitud_i < aptitud(i)
            poblacion(i,:) = trial;
            aptitud(i) = aptitud_i;
        end
    end

    %poblacion
end

% Obtener la mejor solución
[mejor_aptitud, mejor_idx] = min(aptitud);
mejor_solucion = poblacion(mejor_idx,:);

% Mostrar resultados
fprintf('La mejor solución encontrada es: \n');
disp(mejor_solucion);
fprintf('con un valor de la función objetivo de:');
disp(mejor_aptitud)