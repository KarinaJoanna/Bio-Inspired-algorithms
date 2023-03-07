% Practica 1
% Generador de numeros aleatorios entre (a,b)
% Metodo congruencial lineal

a = 21;
b = 4;
m = 2^(13);

f = @(x) mod((a*x)+b,m);
x(1)=1;
for i = 1:2^13
    x(i+1) = f(x(i));
end

x
d=0;
for i = 1:2^13
    if x(i+1)==x(1)
        d=i;
        break;
    end
end
d
