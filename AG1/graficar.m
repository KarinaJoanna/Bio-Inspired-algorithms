function graficar(Pob_real,ff)
figure(1); clf; hold on;
% Grafica la superficie
[X, Y] = meshgrid(-10:0.1:10);
Z = X.^2 + Y.^2;
surf(X,Y,Z);
shading interp;
colormap('gray');
alpha(0.3);
% Grafica los individuos
scatter3(Pob_real(:,1), Pob_real(:,2), ff, 'filled', 'red');
% Configura el gráfico
view(20,30);
axis([-10 10 -10 10 0 100]);
xlabel('x');
ylabel('y');
zlabel('f(x,y)');
title('Algoritmo Genético Binario');
drawnow;
end