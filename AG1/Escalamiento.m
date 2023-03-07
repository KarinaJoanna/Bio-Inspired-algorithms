function [Pob_float] = Escalamiento(Pob_10, I, V, L)
% I es el vector con los intervalos de búsqueda
% I = [I_min_1 I_max_1;
%      I_min_2 I_max_2;
%      ...
%      I_min_10 I_max_10];
% Donde el número de filas equivale al número de variables

    for i = 1:V % i = 1,...,10
        Pob_float(:,i) = Pob_10(:,i) / (2^L-1) * (I(i,2) - I(i,1)) + I(i,1);
    end
end
