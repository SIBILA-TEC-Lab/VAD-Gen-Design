%% ASPECTOS A CAMBIAR
% AGREGAR CASO DEFAULT Y CASO PARA PESOS VARIABLES
% HACER ESTO UN CICLO QUE LLAMA FUNCIONES DE MANERA CONSECUTIVA
% AGREGAR OPCIONES PARA CASOS EN DONDE TIENE CONSTRAINTS
% AGREGAR NORMALIZACION Y DESNORMALIZACION DE DATOS, USANDO RESTRICCIONES
% ENCONTRAR MINIMOS Y MAXIMOS DE RANGO DE FUNCION DE MANERA NO UNGA BUNGA
%
% Idk dónde normalizar
% Con eso también cambiaría lo de los límites, so idkkkkkkkk

%% Evaluation
function [normalizedEval] = evaluation(population)
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