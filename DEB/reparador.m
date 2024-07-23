function y = reparador(x, rango_min, rango_max)
    y = x; % copia
    D = length(y);
    for i=1:D
        while 1
            if y(i) < rango_min(i)
                y(i) = 2*rango_min(i) - y(i); %menor
            end
            
            if y(i) > rango_max(i)
                y(i) = 2*rango_max(i) - y(i); % mayor
            end
            
            if y(i) < rango_max(i) || y(i) > rango_min(i)
                break;
            end
        end
    end
end
