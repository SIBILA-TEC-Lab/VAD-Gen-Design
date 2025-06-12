%% ASPECTOS A CAMBIAR
% TAL VEZ SEA MÁS RÁPIDO COSAS COMO # PARAMS SEA PROPIEDAD DE PARAMS?
% CAMBIAR COSAS A QUE SEAN MÁS DE VECTORES Y APROVECHAR OPS MATRIX
% DECLARAR TAMAÑO DE MATRICES DE ANTEMANO PARA RESERVAR MEMORIA
% IMPLEMENTAR CAMBIOS EN #PADRES/#HIJOS =/= 0.5
% AGREGAR HALL OF FAME
% AGREGAR LOGBOOK
% VER SI SEARCH O SORT MAS EFICIENTE, esp porque deja todo ya org so cerca
% de best-case scenario

%% Hyperparams
popuSize = 1000;  % Tamaño de población
%popuSplit = 0.5;  % Cuanto de la población corresponde a individuos nuevos
% Prioridad baja
generations = 200;      % Number of generations
crossoverProb = 0.9;   % Crossover probability
mutationProb = 0.5;    % Mutation probability
mutationRate = 0.001;    % Mutation rate

numParams = 2;
numObjects = 2;  

%% INNIT %%
% GENERAR POBLACIÓN PADRE AL AZAR
% RNG
parentPopu = rand(numParams, popuSize*0.5);
% Evaluar población
parentEval = evaluation(parentPopu);

% IDK si es necesario pasarlo al dominio de los params, si se normaliza ig
% (se pasa al dominio de params, esp si alguno discreto/categórico)

% GENERAR POBLACIÓN INICIAL AL AZAR
% RNG
currentPopu = rand(numParams, popuSize*0.5);

%% LOOP %%
for i = 1:generations
    % Evaluar población
    % SOLO SE EVALUAN HIJOS, PADRES NO TIENEN QUE PASAR POR SIM
    currentEval = evaluation(currentPopu);
    
    %% Combinar poblaciones
    population = [parentPopu, currentPopu];
    results = [parentEval, currentEval];
    
    %% Sorting
    [fronts, crowdingDistances] = nonDominatingSorting(population, results);
    
    %% Elitist selection
    parentPopu = selection( ...
        population, fronts, crowdingDistances);
    
    %% Crossover & Mutation
    currentPopu = crossover( ...
        parentPopu, crossoverProb, mutationProb, mutationRate);
end

%% Graphics
high = [3; 3];
low = [-3; -3];
denormalizedPop = (population.*(high-low))+low;

% F1: x^2 + y^2
eval1 = sum(denormalizedPop.^2);
% F2 : (x-1)^2 + (y-1)^2
eval2 = sum((denormalizedPop-1).^2);
eval = [eval1; eval2];

%scatter(eval(1,:), eval(2,:))

%{
Ejemplo de plots multicolor:

x = linspace(0,3*pi,200);
y = cos(x) + rand(1,200);
c = linspace(1,10,length(x));
scatter(x,y,[],c)

%}