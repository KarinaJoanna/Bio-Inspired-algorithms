function p = DEB(evaluacion_H,evaluacion_P,D)
    
    if  evaluacion_H(1,end) == 0 && evaluacion_P(1,end) == 0
        if evaluacion_H(1,D+1) < evaluacion_P(1,D+1)
            p(1,:) = evaluacion_H(1,:);
        else
            p(1,:) = evaluacion_P(1,:);
        end
        
        % hijo factible y padre no factible, el hijo gana
    elseif  evaluacion_H(1,end) == 0 && evaluacion_P(1,end) > 0
        p(1,:) = evaluacion_H(1,:);
        
    elseif  evaluacion_H(1,end) > 0 && evaluacion_P(1,end) == 0
        p(1,:) = evaluacion_P(1,:);
        
        % ninguno factible, menor SVR cumpla 
    else 
        if evaluacion_H(1,end) < evaluacion_P(1,end)
            p(1,:) = evaluacion_H(1,:);
        else
            p(1,:) = evaluacion_P(1,:);
        end
    end
end
