% Problema 2

clc
clear

% Parámetros
%for i = 1:30

    Pob = 11;  % Tamaño de la población
    D = 5; % Dimension del problema
    FM = 0.7;  % Factor de amplificación-muta
    CR = 0.7; % Tasa de recombinación
    max_gen = 617; % Número de generaciones
   % O = 1e-5; % Cero gordo
    
    % Límites de las variables
    limite_inferior = [1 1 1 1 1];
    limite_superior = [12 10 12 10 10];
    
    % Generar la población inicial
    poblacion = generacion_pob(limite_inferior,limite_superior,D,Pob);
    poblacion = funcion_objetivo(poblacion,Pob,D);
    
    
    for g=1:max_gen
        g
        for i=1:Pob
            % Seleccionar tres vectores aleatorios distintos entre si
            n = 1:Pob;
            n = setdiff(n,i);
            padres = n(randperm(Pob-1,3));
            
            % Ruido
            v = poblacion(padres(1),1:D) + FM*(poblacion(padres(2),1:D) - poblacion(padres(3),1:D));
            
            % Corregir desbordamiento
            v = reparador(v, limite_inferior, limite_superior);
            
            %Realizar la recombinación
            u = poblacion(i,1:D);
            j_rand = randi(D);
            for j = 1:D
                if j == j_rand || rand() < CR
                    u(j) = v(j);
                end
            end
            
            %Evaluar FO y SVR
            u = funcion_objetivo(u,1,D);
            
            %Seleccion con DEV
            poblacion(i,:) = DEB(poblacion(i,:),u,D);
        end
        poblacion    
    end
%end


% Mostrar resultado
[best, idx] = min(poblacion(:,D+1));
x_best = poblacion(idx,:);
disp("La mejor solución es:")
disp(x_best)
disp("Valor de función objetivo:")
disp(best)