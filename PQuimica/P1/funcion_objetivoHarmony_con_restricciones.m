function f = funcion_objetivoHarmony_con_restricciones(x, k)
    f = zeros(k,1);
    for i = 1:k
    g1 = 100*x(i,1) - x(i,1)*(400 - x(i,4)) + 833.33252*x(i,4) - 83333.333;
    g2 = x(i,2)*x(i,4) - x(i,2)*(400 - x(i,5)) - x(i,4) + x(i,5);
    g3 = x(i,3)*x(i,5) - x(i,3)*(100 + x(i,5) - 2500*x(i,5) + 1250000);
    g4 = -x(i,1) + 100;
    g5 = -x(i,2) + 1000;
    g6 = -x(i,3) + 1000;
    % Sumar las penalizaciones por violación de restricciones
    penalty = max(0,g1) + max(0,g2) + max(0,g3) + max(0,g4) + max(0,g5) + max(0,g6);
    % Calcular la función objetivo penalizada
    f(i) = x(i,1) + x(i,2) + x(i,3) + penalty;
    end
end
