clear all
clc


N = 20; %Número de individuos
V = 10; %Número de variables independientes
Epsilon = 1e-8; %Máximo error de la optimización
ITER_MAX = 2500; %Máximo número de iteraciones
mut = 0.7; %Porcentaje de mutación
I = [-10 10; -10 10; -10 10; -10 10; -10 10; -10 10; -10 10; -10 10; -10 10; -10 10]; %Generamos la población en el intervalo de búsqueda

% Definir función de costo
ff = @(x) 1/sum(x.^2, 2);

% Generar población inicial
PobReal = Poblacion(N,I,V);

for cont = 1:ITER_MAX
%Seleccionamos la población
PobSel = Seleccion(PobReal, ff);
%Cruzamos la Pob seleccionada
Pob_C = CruceR(PobSel,V);
%Concatenamos PobSel + Pob C
PobReal = [PobSel; Pob_C];
%Mutamos la nueva población
PobReal = Mutacion(PobReal,I,mut);
% Imprimir mejor individuo
[~, idx] = min(ff(PobReal));
fprintf('Iteración %d: Mejor individuo = %s, Función costo = %f\n', cont, mat2str(PobReal(idx, :)), ff(PobReal(idx, :)));
end

% Imprimir Población final
fprintf('Población final:\n');
disp(PobReal);

