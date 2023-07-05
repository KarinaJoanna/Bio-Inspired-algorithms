function [x_reparado] = reparador(x, Li, Ui)
% Verificar que cada valor de la solución esté dentro de los límites permitidos
for i = 1:length(x)
    if x(i) < Li(i)
        x(i) = Li(i);
    elseif x(i) > Ui(i)
        x(i) = Ui(i);
    end
end
x_reparado = x;
end
