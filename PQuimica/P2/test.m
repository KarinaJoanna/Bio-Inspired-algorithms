% PROBLEMA 1: Se utiliza ED exponencial

clc
clear

k1 = 0.09755988;
k2 = 0.99*k1; 
k3 = 0.0391908;
k4 = 0.9*k3;

f = @(x) (k2*x(:,6).*(1 + k3) + k1*(1 + k2*x(:,6))) ./ ((1 + k1*x(:,5)).*(1 + k2*x(:,6)).*(1 + k3*x(:,5)).*(1 + k4*x(:,6)));

MAX_GEN = 2500;
D = 6; % dimensión del espacio de búsqueda
F = 0.7; % Factor de escala
CR = 0.9; % Probabilidad de recombinacion

% Definir los límites del espacio de búsqueda
limite_inferior = [0, 0, 0, 0, 10^-5, 10^5];
limite_superior = [0, 0, 0, 0, 16, 16];

% Generar población aleatoria

NP = 50; % Tamaño de la población

poblacion = rand(NP, D) .* (limite_superior - limite_inferior) + limite_inferior;

aptitud = zeros(NP,1);
evaluacion_G = zeros(NP, 1);  
evaluacion_H = zeros(NP, 1);
trial = zeros(1,D);

% Evaluar población en la función de aptitud
deb = zeros(NP, 1);

for i=1:NP
    %deb(i) = 3*poblacion(i,1) + (0.000001 * poblacion(i,1)^3) + 2*poblacion(i,2) + ((0.000002/3) * poblacion(i,2)^3);
    deb(i) = f(poblacion(i,:));
    evaluacion_G(i) = g1(poblacion(i,:));
    aptitud(i) = evaluacion_G(i);
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
        aptitud_hijo = f(trial);
        evaluacion_hijoG = g1(trial); 
        deb_hijo = f(trial);
        if evaluacion_G(i) <= 0 && evaluacion_hijoG <= 0
            if aptitud_hijo < deb(i)  
                poblacion(i,:) = trial;
            end

        elseif evaluacion_hijoG <= 0 && (evaluacion_G(i) > 0 )
            poblacion(i,:) = trial; 
        elseif evaluacion_G(i) > 0 || evaluacion_H(i) > 0
            if evaluacion_hijoG > 0 || evaluacion_hijoH > 0
                if deb_hijo < aptitud(i)
                    poblacion(i,:) = trial;
                end
            end
        end
        for p=1:NP
            %deb(g) = 3*poblacion(g,1) + (0.000001 * poblacion(g,1)^3) + 2*poblacion(g,2) + ((0.000002/3) * poblacion(g,2)^3);
             deb(p) = f(poblacion(i,:));
            evaluacion_G(p) = g1(poblacion(p,:));
            aptitud(p) = evaluacion_G(p);
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