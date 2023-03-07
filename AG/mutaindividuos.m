function hijos_mutados = mutaindividuos(hijos, prob_mutacion)
% hijos: matriz de hijos a mutar
% prob_mutacion: probabilidad de mutación

% Copiamos la matriz de hijos original
hijos_mutados = hijos;

% Determinamos cuántos genes mutar
num_genes_mutados = binornd(numel(hijos), prob_mutacion);

% Elegimos aleatoriamente los índices de los genes a mutar
ind_genes_mutados = randsample(numel(hijos), num_genes_mutados);

% Mutamos los genes seleccionados
hijos_mutados(ind_genes_mutados) = hijos(ind_genes_mutados) + randn(num_genes_mutados, 1);
end
