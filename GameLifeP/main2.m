clear all;
clc;

% Tamaño de la cuadrícula NxN
N = 10;

% Probabilidad de células vivas al inicio
prob = 0.2;

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

for i = 1:1
    % Se crea una matriz A_temp para almacenar la nueva generación de células.
    A_temp = zeros(N+2, N+2);

    % Recorren cada posición en la cuadrícula (incluyendo el borde) utilizando las variables fila y columna.
    for fila = 1:N+2
       for columna = 1:N+2

           % En cada posición de la cuadrícula, se calculan los vecinos diagonales y los vecinos más cercanos.

           % Vecinos diagonales
           vecinos_diagonales = G(mod(fila-2, N)+1, mod(columna-2, N)+1) + G(mod(fila-2, N)+1, mod(columna, N)+1) ...
               + G(mod(fila, N)+1, mod(columna-2, N)+1) + G(mod(fila, N)+1, mod(columna, N)+1);

           % Vecinos más cercanos
           vecinos_cercanos = G(mod(fila-2, N)+1, columna) + G(fila, mod(columna-2, N)+1) + G(fila, mod(columna, N)+1) ... 
               + G(mod(fila, N)+1, columna);

           % n se actualiza sumando el número de vecinos vivos.

           % Número de vecinos vivos
           n = vecinos_diagonales + vecinos_cercanos;

           % Si una célula viva tiene menos de 2 o más de 3 vecinos vivos,
           % la célula debe morir debido a la falta de población o sobrepoblación
           if (G(fila, columna) == 1) && ((n < 2) || (n > 3))
               A_temp(fila, columna) = 0;

           % Si una célula viva tiene 2 o 3 vecinos vivos, sigue viva
           elseif (G(fila, columna) == 1) && ((n == 2) || (n == 3))
               A_temp(fila, columna) = 1;

           % Si una célula muerta tiene exactamente 3 vecinos vivos, se convierte en una célula viva
           % en la siguiente generación, como si fuera repoblación
           elseif (G(fila, columna) == 0) && (n == 3)
               A_temp(fila, columna) = 1;
           end

       end
    end

    % Se actualiza la matriz G con la nueva generación almacenada en A_temp.
    G = A_temp

    % Gráfico
    pause(0.1)
    %spy(G(2:N+1, 2:N+1), '.', 10)  % Excluir el borde al graficar
    spy(G, '.', 10)
    drawnow
end

