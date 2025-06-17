%% EJECUCION CONTINUA DEL NSGA-II
import com.comsol.model.*;    
import com.comsol.model.util.*;

%% Declaración de Hyperparams
% Duracion: 0.000437 seconds.

popuSize = 12;  % Tamaño de población
generations = 6;      % Number of generations
crossoverProb = 0.9;   % Crossover probability
mutationProb = 0.5;    % Mutation probabilit
mutationRate = 0.001;    % Mutation rate

numParams = 3;
numObjects = 2;



%% INNIT %%
% Duracion: 79.066018 seconds.

% Definicion del modelo a usar durante la ejecucion del programa
% (Duracion: 12.747751 seconds.)
model = busbar();

% GENERAR POBLACIÓN PADRE AL AZAR
parentPopu = rand(numParams, popuSize*0.5);

% Evaluar población
% Duracion con modelEval: 55.002674 seconds.
parentEval = modelEval(model, parentPopu);

% GENERAR POBLACIÓN INICIAL AL AZAR
currentPopu = rand(numParams, popuSize*0.5);



%% LOOP PRINCIPAL %%
j = 4;  % Inicio de contador: Permite ejecución parcial del código

%% Duracion: 792.620932 seconds.
for i = j:generations
    % Evaluar población
    % SOLO SE EVALUAN HIJOS, PADRES NO TIENEN QUE PASAR POR SIM
    % Duracion con modelEval: 311.249581 seconds.
    currentEval = modelEval(model,currentPopu);
    
    %% Combinar poblaciones
    % Duracion: 0.001924 seconds.
    population = [parentPopu, currentPopu];
    results = [parentEval, currentEval];

    %% Almacenar los individuos en un binario
    % Duracion 0.019792 seconds.
    filename = strcat('gen', int2str(i),'.bin');
    binSave(filename, population, results);
    
    %% Sorting
    % Duracion: 0.005733 seconds.
    [fronts, crowdingDistances] = nonDominatingSorting(population, results);
    
    %% Seleccion elitista
    % Duracion:  0.001865 seconds.
    parentPopu = selection( ...
        population, fronts, crowdingDistances);

    %% Crossover & Mutacion
    %  0.010012 seconds.
    currentPopu = crossover( ...
        parentPopu, crossoverProb, mutationProb, mutationRate);
end



%% Liberacion de memoria
mphopen -clear;
ModelUtil.remove('Model');
clear model;



%% Graficos

% Se exporta el binario de la ultima gen
dataOut = binLoad(filename);
evaluation = dataOut{2};
evalA = evaluation(1,:);
evalB = evaluation(2,:);
scatter(evalA, evalB)
