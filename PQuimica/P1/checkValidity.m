function isValid = checkValidity(x)
    % Verificar si la solución cumple con ciertas restricciones
    if x(1) + x(2) + x(3) - 1000 > 0
        isValid = false;
        return
    end

    if x(4)*x(5) - 10000 > 0
        isValid = false;
        return
    end

    isValid = true;
end

%function isValid = checkValidity(x)
    % Verificar si la solución cumple con ciertas restricciones
 %   if x(1) + x(2) + x(3) - 1000 > 0
  %      isValid = false;
   %     return
    %end

    %if x(4)*x(5) - 10000 > 0
     %   isValid = false;
      %  return
    %end

    %isValid = true;
%end