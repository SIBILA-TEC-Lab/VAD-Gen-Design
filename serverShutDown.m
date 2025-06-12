%% Función para finalizar la conexión con Comsol Server
function serverShutDown()
    import com.comsol.model.util.*;
    % Desconexion del servidor
    % NOTE: De correr esta seccion, se cortara el contacto con COMSOL Server
    % y MATLAB ya no podra correr scripts con funciones de COMSOL
    ModelUtil.disconnect;
end
