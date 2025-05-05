%% ASPECTOS A CAMBIAR
% IMPLEMENTACION VECTORIAL DEL CRUCE Y PROBAR SI EXTRA FAST
% PONER ERROR MANAGEMENT POR PROBLEMAS DE ARRAY
% PONER SISTEMA PARA QUE PROBABILIDAD DE CRUCE CAMBIE CON INDIVIDUO
% AGREGAR MAS MUTACIONES, ESP TIPO GAUSSIANA Y ETC ------------|
% AGREGAR MANEJO PARA VARIOS TIPOS DE ENTRADAS DE MUTACION   «--
% MEMORY ALLOCATION EN VEZ DE CONCAT MATRICES
%
% Por ahora, se asume que poblacion = 2n, n = # de padres
% Para cumplir con esto, crossoverProb por ahora no se usa 
% No sé si llamar a rand() tan a menudo
%% CROSSOVER
% Cruce y mutación de individuos según el conjunto de padres
function newPopulation = crossover( ...
    popu, crossoverProb, mutationProb, mutationRate)

    % Declaracion de variables
    popuSize = length(popu);
    offspring = zeros(2,popuSize);
    newPopulation = zeros(2,popuSize);

    % Emparejado de los padres
    shuffledPopu = popu(:, randperm(popuSize));

    % Para cada par de individuos, se realiza el cruce
    for i = 1:2:popuSize
        parentPair = shuffledPopu(:, i:i+1);
        offspring(:, i:i+1) = linealComb(parentPair);
    end 
    
    % Para cada individuo nuevo, se corre la mutacion
    for i = 1:popuSize
        newPopulation(:,i) = limitMut( ...
            offspring(:,i), mutationProb, mutationRate);
    end
end


% Crossover por combinación lineal
function offspring = linealComb(parentPair)
    % RNG
    seed = rand();

    % Combinación lineal de los padres
    parentA = parentPair(:, 1);
    parentB = parentPair(:, 2);
    offsprA = seed.*parentA + (1-seed).*parentB;
    offsprB = (1-seed).*parentA + seed.*parentB;
    offspring = [offsprA offsprB];
end


% Mutacion por limite
function mutatedIndiv = limitMut(indiv, mutProb, mutRate)
    % RNG
    seed = rand();

    if mutProb >= seed
        % Genera un numero al azar dentro del rango [-mutRate, mutRate]
        mutation = -mutRate + (2*mutRate)*rand();
        % Se le agrega mutacion al individuo
        mutatedIndiv = indiv + mutation;
    else
        mutatedIndiv = indiv;
    end
end
