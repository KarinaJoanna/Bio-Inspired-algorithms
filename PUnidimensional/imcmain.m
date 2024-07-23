clc
clear all

% Entrada de datos
altura = 1.80;
peso = 90;

% Cálculo del IMC
imc = peso / (altura^2);

% Interpretación del IMC
if imc < 18.5
    interpretacion = 'Bajo peso';
elseif imc >= 18.5 && imc < 25
    interpretacion = 'Peso normal';
elseif imc >= 25 && imc < 30
    interpretacion = 'Sobrepeso';
else
    interpretacion = 'Obesidad';
end

% Imprimir los resultados
fprintf('Su índice de masa corporal (IMC) es: %.2f\n', imc);
fprintf('Interpretación: %s\n', interpretacion);