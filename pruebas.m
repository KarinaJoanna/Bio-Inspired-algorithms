rng('shuffle'); % Inicializar el generador de números aleatorios.
var = 10; % Número de variables.
pob = 50; % Tamaño de la población.
rango = [-10 10]; % Rango de valores de las variables.
num_gen = 1000; % Número de generaciones.
pres = 3; % Precisión.
nb = round(log2((rango(2)-rango(1))*(10^pres)+1)); % Número de bits por variable.
pobgen = rango(1) + (rango(2)-rango(1))*rand(pob, var); % Generar la población inicial.
pobgen = conv_bin(pobgen, rango, nb); % Convertir la población a representación binaria.

for i = 1:num_gen
pobgen = eval_pob(pobgen); % Evaluar la población.
pobgen = seleccion_torneo(pobgen); % Seleccionar los padres mediante torneo binario.
pobhijos = recombinacion_uniforme(pobgen); % Recombinación uniforme de los padres.
pobhijos = mutacion_uniforme(pobhijos); % Mutación uniforme de los hijos.
pobhijos = conv_real(pobhijos, rango, nb); % Convertir los hijos a representación real.
pobgen = seleccion_elitista(pobgen, pobhijos); % Selección elitista de la nueva población.
pobgen = conv_bin(pobgen, rango, nb); % Convertir la población a representación binaria.
% Imprimir los resultados de la generación actual.
fprintf('Generación %d:\n', i);
for j = 1:pob
fprintf('Individuo %d: ', j);
fprintf('Valor = %f, ', conv_real(pobgen(j,:), rango, nb));
fprintf('Fitness = %f\n', eval_ind(pobgen(j,:)));
end
% Imprimir la mejor solución encontrada hasta ahora.
[~, best_idx] = min(eval_pob(pobgen));
fprintf('Mejor solución encontrada en la generación %d: ', i);
fprintf('Valor = %f, ', conv_real(pobgen(best_idx,:), rango, nb));
fprintf('Fitness = %f\n', eval_ind(pobgen(best_idx,:)));
end

function real_val = conv_real(bin, rango, nb)
% CONV_REAL Convierte valores en código binario a su representación real.
% REAL_VAL = CONV_REAL(BIN, RANGO, NB) convierte la matriz de valores binarios
% BIN en su representación real. RANGO es el rango de valores de las variables,
% especificado como un vector [MIN MAX], y NB es el número de bits de
% representación por variable. La salida es una matriz REAL_VAL de la misma
% dimensión que BIN, pero con valores reales en lugar de binarios.

% Calcular el número de variables y el tamaño de la población.
[num_pob, num_var] = size(bin);

% Calcular el rango de valores representable en código binario.
bin_range = 2^nb - 1;

% Escalar los valores binarios al rango [0, 1].
scaled_val = bin ./ bin_range;

% Escalar los valores al rango especificado por RANGO.
real_val = scaled_val * (rango(2) - rango(1)) + rango(1);
end

function fitness = eval_ind(ind)
% EVAL_IND Evalúa la función objetivo para un individuo.
% FITNESS = EVAL_IND(IND) evalúa la función objetivo para el individuo IND
% y devuelve su valor de fitness.

fitness = sum(ind.^2);
end

function fitness = eval_pob(pob)
% EVAL_POB Evalúa la función objetivo para una población.
% FITNESS = EVAL_POB(POB) evalúa la función objetivo para cada individuo
% en la población POB y devuelve un vector con sus valores de fitness.

fitness = zeros(size(pob, 1), 1);
for i = 1:size(pob, 1)
fitness(i) = eval_ind(pob(i,:));
end
end

function padres = seleccion_torneo(pob)
% SELECCION_TORNEO Selecciona los padres mediante torneo binario.
% PADRES = SELECCION_TORNEO(POB) selecciona los padres de la población POB
% mediante el método del torneo binario y devuelve una matriz PADRES con los
% padres seleccionados.

% Calcular el tamaño de la población y el número de variables.
[num_pob, num_var] = size(pob);

% Seleccionar los padres.
padres = zeros(num_pob, num_var);
for i = 1:num_pob
% Seleccionar dos individuos al azar.
idx1 = randi(num_pob);
idx2 = randi(num_pob);
% Evaluar los valores de fitness de los individuos.
fitness1 = eval_ind(pob(idx1,:));
fitness2 = eval_ind(pob(idx2,:));

% Seleccionar el individuo con menor valor de fitness.
if fitness1 < fitness2
    padres(i,:) = pob(idx1,:);
else
    padres(i,:) = pob(idx2,:);
end
end
end

function hijos = recombinacion_uniforme(padres)
% RECOMBINACION_UNIFORME Realiza la recombinación uniforme de los padres.
% HIJOS = RECOMBINACION_UNIFORME(PADRES) realiza la recombinación uniforme
% de los padres en la matriz PADRES y devuelve una matriz HIJOS con los
% hijos generados.
