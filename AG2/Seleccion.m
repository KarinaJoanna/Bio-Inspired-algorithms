function [ PobSel ] = Seleccion(Pob_2,ff)
%Obtener tamaño de la población
    [R, C] = size(Pob_2);
    %Calcular los costos para cada fila de la población
    costos = ff(Pob_2);
    %Ordenar la población en función de los costos (de menor a mayor)
    [~, idx] = sort(costos);
    Pob_2 = Pob_2(idx, :);
    %Seleccionar la mitad superior de la población (mejores individuos)
    PobSel = Pob_2(1:R/2, :);
end