function [costos] = ff(Pob)
%Obtener el número de filas (individuos) y columnas (variables) de la población
[R, V] = size(Pob);
%Inicializar la matriz de costos
costos = zeros(R, 1);
%Calcular el costo para cada individuo de la población
    for i = 1:R
    %Calcular el costo para cada variable del individuo
        for j = 1:V
        %Sumar el cuadrado de cada variable
        costos(i) = costos(i) + Pob(i,j)^2;
        end
    end
end