clc;
clear;

rand('twister',sum(100*clock));
var = 10; %Numero de variables
pob = []; %Individuo en binario
pobhijos = []; %Vector para descendientes
pobgen = [];
rango = [-10 10; -10 10; -10 10; -10 10; -10 10; -10 10; -10 10; -10 10; -10 10; -10 10]; %Limites de las variables

%Condiciones iniciales del algoritmo
num_gen = 2500; %Cantidad de generaciones
NP = 20; %Cantidad de individuos de la población;
pre = [6 6 6 6 6 6 6 6 6 6]; %Precisión
[P, B] = genepoblacion(NP, var, rango, pre); %Generación de población inicial
pob = P;

for i = 1:num_gen
i
for j = 1:NP/2
%Selección de individuos
seleccionado1 = selecindividuos(pob);
seleccionado2 = selecindividuos(pob);
    %Cruza de individuos
    [hijo1, hijo2] = cruzaindividuos(pob(seleccionado1,:), pob(seleccionado2,:));
    pobhijos(2*j-1,:) = hijo1;
    pobhijos(2*j,:) = hijo2;
end

%Mutación de individuos
pobhijos = mutaindividuos(pobhijos);

%Unión de la población actual y la descendencia
pobgen(1:NP,:) = pob(1:NP,:);
pobgen(NP+1:2*NP,:) = pobhijos(1:NP,:);

%Decodificación de la población
P_real = decodificar(var, pobgen, B, NP, pre, rango);
%Evaluación de la población según la función objetivo
colfo = var+1;
pobgen(:,colfo) = evaluapoblacion(P_real);

%Ordenamiento de la población según la función objetivo
pobgen = sortrows(pobgen,colfo,'descend');

%Selección de los mejores individuos
pob = pobgen(1:NP,:); 
pobhijos = []; 
end
