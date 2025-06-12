%% Evaluation

% Función de evaluación que usa la simulación
function[eval] = evaluation(population)
test = 0;

if test == 1
    eval = testEvaluation(population);
    return
end

% El orden de la codificacion de individuos es
% L, tbb, vTot
high = [15; 11; 25];
low = [5; 1; 5];
end



% (Usada para probar el algoritmo evolutivo)
function [normalizedEval] = testEvaluation(population)
    high = [3; 3];
    low = [-3; -3];
    
    
    resultHigh = [9; 16];
    resultLow = [0; 0];
    
    % Se desnormalizan los datos
    % Usando valores límites de datos
    
    denormalizedPop = (population.*(high-low))+low;


    % Funciones de evaluación

    % F1: x^2 + y^2
    eval1 = sum(denormalizedPop.^2);
    % F2 : (x-1)^2 + (y-1)^2
    eval2 = sum((denormalizedPop-1).^2);
    eval = [eval1; eval2];

    % Se normalizan de vuelta los datos
    normalizedEval = (eval-resultLow)./(resultHigh-resultLow);
end