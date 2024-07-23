% Restricciones desigualdad
function desigualdad = g1(k)

% g1(x) = k(5)^0.5 + k(6)^0.5  <= 4

 g(1) = sqrt(k(5)) + sqrt(k(6)) - 4;

 desigualdad = g(1);
end