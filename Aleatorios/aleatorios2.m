% Matriz de números aleatorios
% Genere una matriz de 5 por 5 de números aleatorios distribuidos de manera uniforme entre 0 y 1.

r = rand(5)

% Números aleatorios dentro de un intervalo específico
% Genere un vector columna de 10 por 1 de números distribuidos uniformemente en el intervalo (-5,5).

r = -5 + (5+5)*rand(10,1)

% Enteros aleatorios
% Utilice la función randi (en lugar de rand) para generar 5 enteros aleatorios a partir de la distribución uniforme entre 10 y 50.

r = randi([10 50],1,5)