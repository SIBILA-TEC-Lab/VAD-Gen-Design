%% Scripts con Comsol Server (Servidor Electro)
% NOTE: Comandos varios útiles una vez que la conexión  esté activa

%% Importar librerías de Comsol a terminal
% import com.comsol.model.*;
% import com.comsol.model.util.*;

%% Imprimir los modelos en el servidor
% aka ModelUtil.tags
% mphtags -show


%% Remover modelos del servidor
% ModelUtil.remove("Model") % Elimina el modelo "Model" del servidor
    
%% Inicialización del Comsol Server
function serverUp = comsolServer()
    % Se inicializa comsolservermph.exe
    Currentdir = pwd;
    cd("C:\Program Files\COMSOL\COMSOL56\Multiphysics\bin\win64")
    system("comsolmphserver.exe &");
    cd(Currentdir)
    
    % Registra usuario actual como Servidor COM
    comserver("register")
    
    % Establece conexion
    Currentdir = pwd;
    cd("C:\Program Files\COMSOL\COMSOL56\Multiphysics\mli");
    mphstart(2036)
    cd(Currentdir);

    serverUp = 1;
end 


%% Función para finalizar la conexión con Comsol Server
% Por ahora, asume que solo un modelo está abierto
function serverDown = serverShutDown(modelName)
    % Remover modelos del servidor
    ModelUtil.remove(modelName) % Elimina el modelo indicado del servidor
    
    % Desconexion del servidor
    % NOTE: De correr esta seccion, se cortara el contacto con COMSOL Server
    % y MATLAB ya no podra correr scripts con funciones de COMSOL
    ModelUtil.disconnect

    serverDown = 1;
end
