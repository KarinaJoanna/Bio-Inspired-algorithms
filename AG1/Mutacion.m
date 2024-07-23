function [ Pob ] = Mutacion(Pob,L,prob)
% Pob = Poblacion que se desea mutar.
% L = Longitud del cromosoma
% Prob= Porcentaje de mutacion

%Se determina la cantidad de genes de la poblacion
[R C] = size(Pob);
%Numero de genes que contiene la poblaciˆUn
Tgenes = R*C;
%Numero de genes a mutar
GenesMut = round(Tgenes*prob/100);

for i = 1:GenesMut
    fila = randi([1 R]); colum= randi([1 C]);
    %Se realiza el complemento del gen seleccionado
    Pob(fila, colum) = 1 - Pob(fila,colum);
end
end