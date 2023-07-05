clear all;
clc;

%Tamaño de la cuadricula NxN
N = 10;

% Probabilidad de células vivas al inicio
prob = 0.5;

% Se crea una matriz A de tamaño (N+2) x (N+2) llena de ceros. 
% Se utiliza un tamaño mayor que N para incluir un borde de ceros alrededor de la cuadrícula.
% Usar N+2 para que el borde de la cuadrícula sea cero
A = zeros(N+2, N+2);

% Se asigna a la submatriz interior de A (sin el borde) valores aleatorios generados por la función rand(N).
% Esto crea una distribución aleatoria de células vivas y muertas en la cuadrícula.
A(2:N+1, 2:N+1) = rand(N);

% Se crea una matriz G del mismo tamaño que A y se asignan valores lógicos (true o false) 
% en función de si los elementos correspondientes en A son menores que prob.
% Esto crea una matriz G donde true representa una célula viva y false representa una célula muerta.
G = (A < prob);

for i = 1:20
    % Se reinicia la matriz A a una matriz de ceros para almacenar la nueva generación de células.
    A = zeros(N+2, N+2);

    % Recorren cada posición en la cuadrícula (excepto el borde) utilizando las variables fila y columna.
    for fila = 2:N+1
       for columna = 2:N+1

           % En cada posición de la cuadrícula, se calculan los vecinos diagonales y los vecinos más cercanos.
           
           % Vecinos diagonales
           vecinos_diagonales = G(fila-1, columna-1) + G(fila-1, columna+1) + G(fila+1, columna-1) + G(fila+1, columna+1);
           % Vecinos más cercanos
           vecinos_cercanos = G(fila-1, columna) + G(fila, columna-1) + G(fila, columna+1) + G(fila+1, columna);

           % n se actualiza sumando el número de vecinos vivos.

           % Número de vecinos vivos
           n = vecinos_diagonales + vecinos_cercanos;

           % Si una célula viva tiene menos de 2 o más de 3 vecinos,
           % la célula debe morir debido a la falta de población o sobrepoblación
           if (G(fila, columna) == 1) && ((n < 2) || (n > 3))
               A(fila, columna) = 0;

           % Si una célula viva tiene 2 o 3 vecinos vivos, sigue viva
           elseif (G(fila, columna) == 1) && ((n == 2) || (n == 3))
               A(fila, columna) = 1;

           % Si una célula muerta tiene exactamente 3 vecinos vivos, se convierte en una célula viva
           % en la siguiente generación, como si fuera repoblación
           elseif (G(fila, columna) == 0) && (n == 3)
               A(fila, columna) = 1;
           end

       end
    end

    % La matriz G se actualiza con la nueva generación almacenada en A.
    G = A;

    % Grafico
    pause(0.1)
    spy(G, '.', 10)
    drawnow
end