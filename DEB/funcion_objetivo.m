function p = funcion_objetivo(poblacion,Np,D)

    p = poblacion;

    for i=1:Np
        
        %Funcion Objetivo
        p(i,D+1) = (1.1*p(i,1) + 1.2*p(i,2) + 2.0*p(i,3) + 1.3*p(i,4) + 3.0*p(i,5));

        g(1) = -(8*p(i,1) + 2*p(i,2) + 15*p(i,3) + 4*p(i,4) + 30*p(i,5) - 60);
        g(2) = -(9*p(i,1) + 3*p(i,2) + 3*p(i,3) + p(i,4) + 9*p(i,5) - 100);
        g(3) = -(35*p(i,1) + 3*p(i,2) + 17*p(i,3) + p(i,4) + 16*p(i,5) - 120);
        g(4) = -(100*p(i,1) + 90*p(i,2) + 350*p(i,3) + 200*p(i,4) + 410*p(i,5) - 2100);
        g(5) = -(10*p(i,1) + 20*p(i,2) + 40*p(i,3) + 25*p(i,4) + 40*p(i,5) - 400);

%         g(1) = 0;

%         v1 = 0;
%         for ii=1:length(g)
%             v1 = v1 + max(0,g(ii));
%         end
%         
%         v2 = 0;
%         for j=1:length(h)
%             v2 = v2 + max(0,abs(h(j))-O);
%         end
%         
%         SVR = v1 + v2;
%         
%         p(i,D+2) = SVR;

        v2 = 0;
        for j=1:length(g)
            v2 = v2 + max(0,(g(j)));
        end
        
        SVR = v2;
        
        p(i,D+2) = SVR;
    end
end