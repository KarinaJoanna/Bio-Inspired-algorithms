function y = funcion_objetivo(x,h)
    for k=1:h
        y(k) = x(k,1)^2 + x(k,2)^2 + x(k,3)^2;
    end
end