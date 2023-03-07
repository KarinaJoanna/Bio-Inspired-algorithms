function [P, B] = genepoblacion(NI, V, L, pre)
% NI, número de individuos
% V, número de variables
% L, limites de las variables
% pre, precisión

P = [];
for i = 1:V
    gen = L(i,1) + (L(i,2) - L(i,1)) .* rand(NI, 1);
    P = [P, gen];
end

% Codificación de los números reales a binario
B = zeros(1,V);
for i = 1:V
    B(i) = round(log((L(i,2)-L(i,1))*10^pre(i))/log(2)+0.9);
end

B_cumsum = cumsum([1, B]);
P_bin = zeros(NI, sum(B));
for i = 1:NI
    for j = 1:V
        bin_val = dec2bin(round((P(i,j)-L(j,1))/((L(j,2)-L(j,1))/(2^B(j)-1))), B(j));
        P_bin(i, B_cumsum(j):(B_cumsum(j+1)-1)) = bin_val - '0';
    end
end

P = P_bin;
end

