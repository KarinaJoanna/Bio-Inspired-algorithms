function P = generacion_pob(limite_inferior,limite_superior,D,NP) 
    P =[];
    %P = zeros(NP,var);
    for i=1:NP
        for j=1:D
            P(i,j) = limite_inferior(1,j) + (limite_superior(1,j)-limite_inferior(1,j))*rand();
        end
    end
end