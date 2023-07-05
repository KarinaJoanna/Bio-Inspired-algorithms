clear
clc

Pob = 10; % Población
D = 4; % Dimension del problema
FM = 0.5; % Factor de muta
CR = 0.8; % Factor de cruza
max_gen = 10000; % Maximo generaciones

% Limites de busqueda
limite_inferior = [0 0 -0.55 -0.55 ]; 
limite_superior = [1200 1200 0.55 0.55]; 

% Generación de poblacion inicial
poblacion = rand(Pob, D) .* (limite_superior - limite_inferior) + limite_inferior;
aptitud = zeros(Pob,1);
evaluacion_G = zeros(Pob, 1); % Se inicializa el vector de evaluaciones de la función objetivo G a ceros.
evaluacion_H = zeros(Pob, 1); % Se inicializa el vector de evaluaciones de la función objetivo H a ceros.
hijo = zeros(1,D); % Se inicializa el vector de hijo a ceros, donde se almacenará la nueva solución generada.

% Evaluar la población inicial
deb = zeros(Pob, 1);

for i=1:Pob
    deb(i) = 3*poblacion(i,1) + (0.000001 * poblacion(i,1)^3) + 2*poblacion(i,2) + ((0.000002/3) * poblacion(i,2)^3);
    evaluacion_G(i) = g1(poblacion(i,:));
    evaluacion_H(i) = h1(poblacion(i,:));
    aptitud(i) = evaluacion_G(i)+evaluacion_H(i);
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

        % CB
        j_rand = randi(D);
        index = zeros(1, D);
        for k = 1:D
            if (rand() < CR || k == j_rand)
                index(k) = muta(k);
            else
               index(k) = poblacion(j, k);
            end
        end

        % Mejor individuo Reglas deb
        aptitud_hijo = 3*index(1) + (0.000001 * index(1)^3) + 2*index(2) + ((0.000002/3) * index(2)^3);
        evaluacion_hijoG = g1(index);
        evaluacion_hijoH = h1(index);
        deb_hijo = evaluacion_hijoG + evaluacion_hijoH;

        % Entre dos soluciones factibles, aquella con el mejor valor de la función objetivo es seleccionada
        % 2 factibles, hijo gana si su FO es mejor al padre
        if evaluacion_G(j) <= 0 && evaluacion_hijoG <= 0 && evaluacion_H(j) <= 0 && evaluacion_hijoH <= 0
            if aptitud_hijo < deb(j)
                poblacion(j,:) = index;
            end
            % Entre una solución factible y otra no factible, la factible es seleccionada.
            % hijo factible y padre no factible, el hijo gana
        elseif evaluacion_hijoG <= 0 && evaluacion_hijoH <= 0 && (evaluacion_G(j) > 0 || evaluacion_H(j) > 0)
            poblacion(j,:) = index;
            % Entre dos soluciones no factibles, aquella con la menor suma de violación de restricciones es seleccionada
            % ninguno factible, menor SVR cumpla o menor FO
        elseif evaluacion_G(j) > 0 || evaluacion_H(j) > 0
            if evaluacion_hijoG > 0 || evaluacion_hijoH > 0
                if deb_hijo < aptitud(j)
                    poblacion(j,:) = index
                end
            end
        end

        % Evalua FO en la población
        for g=1:Pob
            deb(g) = 3*poblacion(g,1) + (0.000001 * poblacion(g,1)^3) + 2*poblacion(g,2) + ((0.000002/3) * poblacion(g,2)^3);
            evaluacion_G(g) = g1(poblacion(g,:));
            evaluacion_H(g) = h1(poblacion(g,:));
            aptitud(g) = evaluacion_G(g)+evaluacion_H(g);
        end
    end
end


% Mostrar resultado
[mejor_aptitud, mejor_indice] = min(deb);
mejor_solucion = poblacion(mejor_indice, :);
fprintf('El mejor individuo encontrado es: ');
disp(mejor_solucion);
mejor_valor_aptitud = min(deb);
fprintf('con un valor de la función objetivo de: = %f\n', mejor_valor_aptitud);