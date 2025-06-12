%% Funcion para cerrar todos los modelos de Comsol
% Esta llamada asume que hay al menos un elemento abierto
function modelShutDown()
    import com.comsol.model.util.*;
    
    % Limpiar lista de archivos abiertos al servidor
    try
        mphopen -clear
    end

    % Remover modelos del servidor
    modelTags = mphtags;
    for i = 1:numel(modelTags)
        ModelUtil.remove(modelTags{i});
    end
end
