% PROBLEMA 1: Se utiliza ED exponencial

clc
clear all

Pob = 200; % Población
D = 8; % Dimension del problema
FM = 0.2; % Factor de muta
CR = 0.3; % Factor de cruza
max_gen = 2000; % Maximo generaciones

% Limites de busqueda
%limite_inferior = [100 1000 100 10 10 10 10 10]; 
%limite_superior = [10000 10000 10000 1000 1000 1000 1000 1000];

limite_inferior = [500 1200 5000 100 200 200 200 200];
limite_superior = [600 1500 5200 200 300 300 300 400];

% Generación de poblacion inicial
poblacion = rand(Pob, D) .* (limite_superior - limite_inferior) + limite_inferior;

aptitud = zeros(Pob,1);
evaluacion_G = zeros(Pob, 1);  
evaluacion_H = zeros(Pob, 1);
hijo = zeros(1,D);

% Evaluar la población inicial
deb = zeros(Pob, 1);

for i = 1:Pob
    x = poblacion(i,:);
    deb(i) = funcion_objetivo(x); % FO
    evaluacion_G(i) = g1(x);
    evaluacion_H(i) = g2(x);
    evaluacion_H(i) = g3(x);
    g = g4(x); % evaluación de restricciones de límites
    if any(g > 0)
        %deb(i) = inf;
    else
        deb(i) = sum(x(1:3));
        g1_val = g1(x);
        g2_val = g2(x);
        g3_val = g3(x);
        if g1_val > 0 || g2_val > 0 || g3_val > 0
            %deb(i) = inf;
        end
    end
    aptitud(i) = deb(i);
end


for i = 1:max_gen
    for j = 1:Pob

        % Seleccionar tres vectores aleatorios
        r = randperm(Pob,3);
        while r(1) == r(2) || r(1) == r(3) || r(2) == r(3)
            r = randperm(Pob,3);
        end

        % Mutación
        muta = poblacion(r(1),:) + FM * (poblacion(r(2),:) - poblacion(r(3),:));

        % Reparador 
        for k = 1:D
            if muta(k) < limite_inferior(k)
                muta(k) = limite_inferior(k);
            elseif muta(k) > limite_superior(k)
                muta(k) = limite_superior(k);
            end
        end

        % Cruza exponencial
        hijo = poblacion(j,:);
        j_rand = randi(D);
        L = randi(D-1) + 1;
        for k = 1:D
            if rand() <= CR || k == j_rand || k >= j_rand+L
                hijo(k) = muta(k);
            end
        end

        % Evaluación del hijo
        x = hijo;
        evaluacion_G_hijo = g1(x);
        evaluacion_H_hijo = g2(x);
        evaluacion_H_hijo = g3(x);
        deb_hijo = sum(x(1:3));
        if ~checkValidity(x)
            deb_hijo = inf;
        end
        aptitud_hijo = deb_hijo;

        % Selección
        if aptitud_hijo < aptitud(j)
            poblacion(j,:) = hijo;
            aptitud(j) = aptitud_hijo;
        end
    end
end

% Mostrar resultado
[mejor_aptitud, idx] = min(aptitud);
mejor_solucion = poblacion(idx, :);
fprintf('El mejor individuo encontrado es: ');
disp(mejor_solucion);
mejor_valor_aptitud = min(aptitud);
fprintf('con un valor de la función objetivo de: %f\n', mejor_valor_aptitud); 
