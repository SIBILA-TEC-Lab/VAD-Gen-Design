%% Evaluation
% Función de evaluación que utiliza un modelo Comsol ya declarado
function[eval] = modelEval(model, population)
import com.comsol.model.*;    
import com.comsol.model.util.*;

popuSize = length(population);


% Los valores se restringiran a numeros ente .5 y 50
high = [50; 50; 50];
low = [5; 5; 5];
denormalizedPop = (population.*(high-low))+low;


results = zeros(2, popuSize);

% Iteracion de la funcion de evaluacion con la simulacion
for i = 1:popuSize
    datum = denormalizedPop(:,i);
    results(:,i) = simEval(model, datum);
end


evalA = results(1,:);  
evalB = results(2,:);  
eval = [evalA; evalB];
end
