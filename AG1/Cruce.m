function [ Pob_C ] = Cruce(Pob,L,V)
[R, C] = size(Pob); Pob_C = zeros(R,C);
    ix = 1;
    for i = 1: V
        Pob_Aux1 = Pob(:,ix:L*i); Pob_Aux2 = zeros(R,L);
         t1 = randperm(R);
         t2 = reshape(t1,R/2,2); i1 = 1;
    for j=1:R/2
        %pcruce = randi([1,L-1]);
        pcruce = round(0.85 * L);
        aux1 = Pob_Aux1(t2(j,1),1:pcruce);
        aux2 = Pob_Aux1(t2(j,1),pcruce+1:L);
        aux3 = Pob_Aux1(t2(j,2),1:pcruce);
        aux4 = Pob_Aux1(t2(j,2),pcruce+1:L);
        Pob_Aux2(i1,1:L) = [aux1 aux4];
        Pob_Aux2(i1+1,1:L) = [aux3 aux2];
        i1 = i1+2;
    end
    Pob_C(:,ix:L*i) = Pob_Aux2(:,:);
    ix = ix+L;
    end
end