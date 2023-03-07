function [P] = Poblacion(N,L,V)
% N = Numero de individuos
% L = Longitud del cromosoma
% V = Numero de variables

P = zeros(N,V);
    
for i = 1:N
    for j = 1:V
    limite_inferior = L(j, 1);
    limite_superior = L(j, 2);
    variable = limite_inferior + (limite_superior - limite_inferior) * rand();
    P(i, j) = variable;
    end
end