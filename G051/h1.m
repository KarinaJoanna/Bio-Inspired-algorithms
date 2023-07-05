% Restricciones igualdad
function igualdad = h1(x)

% h3(x) = (x) [1000*sin(-x(3) - 0.25) + 1000*sin(-x(4) - 0.25) + 894.8 - x(1) = 0
% h4(x) =1000*sin(x(3) - 0.25) + 1000*sin(x(3) - x(4) - 0.25) + 894.8 - x(2) = 0
% h5(x) = 1000*sin(x(4) - 0.25) + 1000*sin(x(4) - x(3) - 0.25) + 1294.8] = 0

h(1)= 1000*sin(-x(3)-0.25)+1000*sin(-x(4)-0.25)+894.8-x(1);
h(2)= 1000*sin(x(3)-0.25)+1000*sin(x(3)-x(4)-0.25)+894.8-x(2);
h(3)= 1000*sin(x(4)-0.25)+1000*sin(x(4)-x(3)-0.25)+1294.8;
epsilon = 0.001;

    % Cero gordo:
    if h(1) < epsilon
       h(1)=0;
    end
    if h(2) < epsilon
       h(2)=0;
    end
    if h(3) < epsilon
       h(3)=0;
    end
    igualdad= h(1)+h(2)+h(3);

end