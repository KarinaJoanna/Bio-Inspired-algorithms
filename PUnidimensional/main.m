clc
clear all

% Datos históricos de precios de una acción
precios = [100, 98, 105, 110, 115, 112, 108, 115, 120, 125, 122, 128, 132];

% Parámetro del modelo de media móvil
ventana = 3; % Tamaño de la ventana móvil

% Predicción de precios utilizando media móvil
predicciones = zeros(1, length(precios));

for i = ventana:length(precios)
    ventana_actual = precios(i-ventana+1:i);
    media_movil = mean(ventana_actual);
    predicciones(i) = media_movil;
end

% Imprimir los resultados
fprintf('Día\tPrecio\tPredicción\n');
for i = 1:length(precios)
    fprintf('%d\t%.2f\t%.2f\n', i, precios(i), predicciones(i));
end

% Gráfico de precios y predicciones
dias = 1:length(precios);
plot(dias, precios, 'b-o', dias, predicciones, 'r-');
xlabel('Día');
ylabel('Precio');
legend('Precios reales', 'Predicciones');
