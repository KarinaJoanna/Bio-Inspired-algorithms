% ALGORITMO GENETICO BINARIO
% Optimizacion de una funcion en Rˆ2, min f(x) = xˆ2
% Intervalo de busqueda -10 ≤ x ≤ 10
clear all
clc

N = 20; % N = Numero de individuos, 
L = 10; % L= Longitud del cromosoma.
V = 10;  % Numero de variables independientes.
Epsilon = 1e-8; % Maximo error de la optimizacion
prob = 0.7; % Porcentaje de mutacion
ITER_MAX = 2499; % Generaciones
%Intervalos de busqueda
I = [-10 10; -10 10; -10 10; -10 10; -10 10; -10 10; -10 10; -10 10; -10 10; -10 10];
%Generemos la poblacion de individuos
Pob_2 = Poblacion(N,L,V);
%Poblacion en base decimal
Pob_10= PobDec(Pob_2,L,V);
%Poblaciones en R
Pob_real = Escalamiento(Pob_10,I,V,L);
cont = 1;
ff_aux = 1000; %  Inicializa el valor de la función costo en un valor alto para iniciar la iteración

% mientras el número de iteraciones es menor o igual a ITER_MAX y todas las funciones costo son mayores que Epsilon.
while ((cont <= ITER_MAX) && all(ff_aux > Epsilon))
    %Determinamos la funcion costo
    ff = (Pob_real).^2;
    
    %Graficar los individuos
    %graficar(Pob_real,ff);
        %Seleccionamos la poblacion
        PobSel_2 = Seleccion(Pob_2,ff);
        %Cruzamos la Pob seleccionada
        Pob_C = Cruce(PobSel_2,L,V);
        %Concatenamos PobSel + Pob C
        Pob_2 = [PobSel_2;Pob_C];
        %Mutamos la nueva poblacion
        Pob_2 = Mutacion(Pob_2,L,prob);
        %Poblacion en base decimal
        Pob_10= PobDec(Pob_2,L,V)
        %Poblacion en R
        Pob_real = Escalamiento(Pob_10,I,V,L)
        [ff_aux, idy] = min(ff)
        cont = cont+1
end
