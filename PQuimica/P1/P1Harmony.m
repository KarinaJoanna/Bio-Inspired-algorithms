clc
clear all

% Definir la función objetivo f(x)
%f = @(x) funcion_objetivo(x);

% Definir los límites inferior (Li) y superior (Ui) de cada variable

%Li = [100 1000 100 10 10 10 10 10]; 
%Ui = [10000 10000 10000 1000 1000 1000 1000 1000];


Li = [500 1200 5000 100 200 200 200 200];
Ui = [600 1500 5200 200 300 300 300 400];

% Definir la longitud del vector de variables de decisión
N = 8;

% Definir la tasa de aceptación de la memoria de armonía (raccept),
% la tasa de ajuste de tono (rpa) y el ancho de banda de tono (bw)
raccept = 0.9;
rpa = 0.5;
ria = 0.1;

% Definir el ancho de banda de tono (bw) como la diferencia entre los límites superior e inferior dividida por 1000
bw = (Ui - Li) / 1000;
%bw = 1;

% Definir el tamaño de la memoria de armonía (k) y el número máximo de iteraciones (max_iter)
k = 20;
max_iter = 10000;

% Generar la memoria de armonía inicial HM
HM = rand(k, N) .* (Ui - Li) + Li;

% Iniciar el bucle principal
for g = 1:max_iter
    % Iniciar el bucle secundario para cada variable de decisión
    for i = 1:N
        % Generar un nuevo valor para la variable i utilizando uno de los tres métodos posibles
        if rand < raccept
            % Elegir aleatoriamente una armonía de la memoria de armonía
            index = randi([1 k]);
            if rand < rpa
                % Ajustar el valor de la variable utilizando rpa y bw
                newX(i) = HM(index,i) + bw(i) * (1 + (1 - (-1)) * rand);
                newX = reparador(newX, Li, Ui);
            else
                if rand < ria
                    % Reemplazar el valor de la variable por el mejor valor en la memoria de armonía
                    [best_fnn, best_indexnn] = min(funcion_objetivoHarmony_con_restricciones(HM,k));
                    newX(i) = HM(best_indexnn,i);
                else
                    % Mantener el valor de la variable sin cambios
                    newX(i) = HM(index,i);
                end
            end
        else
            % Generar un valor aleatorio para la variable dentro de su rango permitido
            newX(i) = Li(i) + (Ui(i) - Li(i)) * rand;
        end
    end
    % Aplicar el reparador a la nueva solución generada
    %newX = reparador(newX, Li, Ui);
    
    % Evaluar la nueva solución potencial utilizando la función objetivo
    new_f = funcion_objetivoHarmony_con_restricciones(newX,1);
    % Comparar la nueva solución con la peor solución en la memoria de armonía actual
    [best_f,best_index] = max(funcion_objetivoHarmony_con_restricciones(HM,k));
    if new_f < best_f
        % Reemplazar la mejor solución con la nueva solución generada, aplicando las condiciones de Deb
        HM(best_index,:) = newX;
    end
    %HM
end

% Mostrar la mejor solución encontrada
[best_fn, best_indexn] = min(funcion_objetivoHarmony_con_restricciones(HM,k));
bestX = HM(best_indexn,:);
fprintf('El mejor individuo encontrado es:\n');
disp(bestX);
fprintf('con un valor de la función objetivo de: \n');
disp(best_fn);