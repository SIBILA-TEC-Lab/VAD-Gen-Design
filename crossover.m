function newPopulation = crossover( ...
    popu, crossoverProb, mutationProb, mutationRate)

    % Declaracion de variables
    matrixDimensions = size(popu)
    popuSize = matrixDimensions(2);
    paramNum = matrixDimensions(1);
    offspring = zeros(paramNum, popuSize);
    newPopulation = zeros(paramNum, popuSize);

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
