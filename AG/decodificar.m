function P_real = decodificar(V, P, B, NI, pre, L)
% V, número de variables
% P, población codificada en binario
% B, vector con el número de bits de cada variable
% NI, número de individuos
% pre, precisión
% L, limites de las variables
P_real = zeros(NI,V);
B_cumsum = cumsum([1, B]);

for i = 1:NI
    for j = 1:V
        bin_val = num2str(P(i,B_cumsum(j):(B_cumsum(j+1)-1)));
        dec_val = bin2dec(bin_val);
        P_real(i,j) = L(j,1) + dec_val*((L(j,2)-L(j,1))/(2^B(j)-1));
    end
end
end
