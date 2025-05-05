%% ASPECTOS A CAMBIAR
% PONER DIFERENTES VERSIONES DE SELECCIÓN
% SEPARAR EL CROWDING DISTANCE CALC?
%% SELECTION
% Selección de padres usando Non-Dominated Sorting and Crowding Distance
function newPopu = selection(population, fronts, crowdingDistances)
    newPopu = [];
    popuSize = length(population)*0.5;
    currentPopuSize = 0;

    % Se analiza cada frente, del mejor al peor
    for k = 1:length(fronts)
        currentFront = fronts{k};

        % Si aún queda espacio, agrega todos los individuos en dicho frente
        if currentPopuSize + length(currentFront) <= popuSize
            newPopu = [newPopu population(:,currentFront)];
            currentPopuSize = currentPopuSize + length(currentFront);

        % De lo contrario, elije qué individuos del frente
        % según Distancia de Molote
        else
            % Select based on crowding distance if needed
            [~, sortedIdx] = sort(crowdingDistances(currentFront), 'descend');
            newPopu = [newPopu population(:, currentFront(sortedIdx(1:popuSize - currentPopuSize)))];
            break;
        end
    end
end