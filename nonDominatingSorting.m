%% SORTING
% Non-dominating Sorting
function [fronts, crowdingDistances] = nonDominatingSorting(popu, evalResults)
    
    numObjects = size(popu, 1);  % Numero de objetivos a usar en comparacion
    popuSize = size(popu, 2);  % Número de elementos a comparar
    
    % Ininicializacion de arrays
    dominationCount = zeros(1, popuSize); % # veces cada individuo es dominado
    dominatedSolutions = cell(popuSize, 1); % Elementos dominados por indiv durante ciclo
    crowdingDistances = zeros(1, popuSize);

    fronts = {};  % # de Frentes de Pareto
    fronts{1} = [];  % Frentes de Pareto para rankings
    
    % Encontrar el Frente de Pareto óptimo
    for i = 1:popuSize 
        indivA = evalResults(:, i);
        for j = i+1:popuSize
             % Se analiza para cada individuo si domina el resto
            indivB = evalResults(:, j);

            % De ser el caso que "i" domina a "j"
            if dominates(indivA, indivB)
                % Se agrega j a lista de i
                dominatedSolutions{i} = [dominatedSolutions{i} j];
                % Se le agrega a la cuenta de # veces dominado a j
                dominationCount(j) = dominationCount(j) + 1;

            % De ser el caso que "j" domina  a "i"
            elseif dominates(indivB, indivA)
                % Se agrega j a lista de i
                dominatedSolutions{j} = [dominatedSolutions{j} i];
                % Se le agrega a la cuenta de # veces dominado a j
                dominationCount(i) = dominationCount(i) + 1;
            end
        end

        % Si "i" no es dominado por nadie
        if dominationCount(i) == 0
            fronts{1} = [fronts{1}, i];  % Se agrega al frente principal
        end
    end
    
    % Encontrar el resto de frentes (non-dominated sorting)
    k = 1;
    while ~isempty(fronts{k}) 
        analizedFront = [];
        
        % Se analiza cada elemento en cada frente, comenzando con el óptimo
        for i = 1:length(fronts{k})
            individual = fronts{k}(i);

            for j = 1:length(dominatedSolutions{individual})
                % Se extrae cada individuo que domina
                dominatedIndiv = dominatedSolutions{individual}(j);

                % Y se disminuye la cuenta de individuos dominados
                dominationCount(dominatedIndiv) = dominationCount(dominatedIndiv) - 1;
                
                % Si el individuo es dominado únicamente por el frente 
                % analizado, se agrega al nuevo frente
                if dominationCount(dominatedIndiv) == 0
                    analizedFront = [analizedFront, dominatedIndiv];
                end
            end
        end

        % Se continúa mientras hayan frentes sin analizar
        k = k + 1;
        fronts{k} = analizedFront;
    end
    
        
    % Cálculo de Distancia de "Molote"
    for k = 1:length(fronts)
        % Se analiza cada frente obtenido
        currentFront = fronts{k};
        frontIndiv = length(currentFront);

        if frontIndiv > 0
            for i = 1:numObjects

                % Se ordenan los elementos en el frente según su valor
                [~, sortedIndx] = sort(evalResults(currentFront));

                % Se le asignan a los dos valores extremos una distancia oo
                crowdingDistances(currentFront(sortedIndx(1))) = Inf;
                crowdingDistances(currentFront(sortedIndx(end))) = Inf;

                % Para el resto, se le aplica una fórmula que compara la
                % distancia entre sus vecinos, con el rango total
                for j = 2:frontIndiv-1
                    crowdingDistances(currentFront(sortedIndx(j))) = ...
                        (evalResults(currentFront(sortedIndx(j+1))) - ...
                        evalResults(currentFront(sortedIndx(j-1)))) / ...
                        abs(max(evalResults(:, i)) - min(evalResults(:, i)));
                end
            end
        end
    end
end

% Check de dominancia
function result = dominates(indiv1, indiv2)
    result = all(indiv1 <= indiv2) && any(indiv1 < indiv2);
end
