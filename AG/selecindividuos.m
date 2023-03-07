function idx = selecindividuos(pob)
% pob, población de individuos

    % Seleccionar los dos mejores individuos de la población
    [~,idx] = sort(pob(:,end),'descend');
    idx = idx(1:2);

end
