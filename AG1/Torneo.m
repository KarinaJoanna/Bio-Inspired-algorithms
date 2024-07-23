function [PobSel ] = Torneo(Pob_2,ff)
[R, C] = size(Pob_2);
%Vector que contiene los individuos seleccionados
idx = zeros(1,R/2);

t = randperm(R);
fc = reshape(t,R/2,2);

for i = 1: R/2
    if (ff(fc(i,1)) < ff(fc(i,2)))
        idx(i) = fc(i,1);
    else
        idx(i) = fc(i,2);
    end

end
PobSel = Pob_2(idx,:);

end
