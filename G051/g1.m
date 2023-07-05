% Restricciones desigualdad
function desigualdad = g1(x)

% g1(x) = -x(4) + x(3) - 0.55 <= 0
% g2(x) = -x(3) + x(4) - 0.55 <=0

 g(1) = -x(4) + x(3) - 0.55;
 g(2) = -x(3) + x(4) - 0.55;

 desigualdad = g(1)+g(2);
end