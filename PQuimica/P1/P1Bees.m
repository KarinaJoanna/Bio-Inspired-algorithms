% Definir los parámetros del algoritmo
num_abejas = 100;
max_iteraciones = 2500;
limite_abejas_exploradoras = 20;
limite_inferior = [500 1200 5000 100 200 200 200 200]; % límites inferiores de búsqueda
limite_superior =[600 1500 5200 200 300 300 300 400];

% Inicializar las abejas
abejas = zeros(num_abejas, 8);
valores = zeros(num_abejas, 1);
for i = 1:num_abejas
    abejas(i, :) = limite_inferior + randn(1, 8).*(limite_superior - limite_inferior);
    valores(i) = funcion_objetivo(abejas(i, :));
end

% Ejecutar el algoritmo
for iteracion = 1:max_iteraciones
    % Seleccionar la mejor abeja y actualizar la posición de las abejas
    [valor_mejor_abeja, index_mejor_abeja] = min(valores);
    mejor_abeja = abejas(index_mejor_abeja, :);
    for i = 1:num_abejas
        if i ~= index_mejor_abeja
            % Generar una nueva posición para la abeja
            nueva_posicion = abejas(i, :) + randn(1, 8).*(abejas(i, :) - mejor_abeja);
            % Aplicar restricciones
            nueva_posicion = min(max(nueva_posicion, limite_inferior), limite_superior);
            % Evaluar la nueva posición y actualizar la posición si es mejor
            nuevo_valor = funcion_objetivo(nueva_posicion);
            if nuevo_valor < valores(i)
                abejas(i, :) = nueva_posicion;
                valores(i) = nuevo_valor;
            end
        end
    end
    
    % Exploración de abejas
    if iteracion < limite_abejas_exploradoras
        for i = 1:num_abejas
            % Generar una nueva posición para la abeja exploradora
            nueva_posicion = limite_inferior + randn(1, 8).*(limite_superior - limite_inferior);
            % Aplicar restricciones
            nueva_posicion = min(max(nueva_posicion, limite_inferior), limite_superior);
            % Evaluar la nueva posición y actualizar la posición si es mejor
            nuevo_valor = funcion_objetivo(nueva_posicion);
            if nuevo_valor < valores(i)
                abejas(i, :) = nueva_posicion;
                valores(i) = nuevo_valor;
            end
        end
    end
end

% Imprimir la mejor solución encontrada
[valor_mejor_abeja, index_mejor_abeja] = min(valores);
mejor_abeja = abejas(index_mejor_abeja, :);
%fprintf('La mejor solución encontrada es: (%f, %f, %f, %f, %f, %f, %f, %f)\n', mejor_abeja(1), mejor_abeja(2), mejor_abeja(3), mejor_abeja(4), mejor_abeja(5), mejor_abeja(6), mejor_abeja(7), mejor_abeja(8));
%fprintf('El valor de la función objetivo en la mejor solución encontrada es: %f\n', valor_mejor_abeja);

fprintf('Mejor solución encontrada:\n');
disp(abejas(index_mejor_abeja, :));
fprintf('El valor de la función objetivo en la mejor solución encontrada es: %f\n', valor_mejor_abeja);


funcion_objetivo = @(x) x(1) + x(2) + x(3);
restricciones = @(x) [
    100*x(1) - x(1)*(400 - x(4)) + 833.33252*x(4) - 83333.333;
    x(2)*x(4) - x(2)*(400 - x(5) + x(4)) - 1250*x(4) + 1250*x(5);
    x(3)*x(5) - x(3)*(100 + x(5) - 2500*x(5)) + 1250000;
    -x(1) + 100;
    x(1) - 10000;
    -x(2) + 1000;
    x(2) - 10000;
    -x(3) + 1000;
    x(3) - 10000;
    -x(4) + 10;
    x(4) - 1000;
    -x(5) + 10;
    x(5) - 1000
];