%% Inicia Comsol Server
Currentdir = pwd;
cd("C:\Program Files\COMSOL\COMSOL56\Multiphysics\bin\win64")
system("comsolmphserver.exe &");
cd(Currentdir)

% Registra usuario actual como Servidor COM
comserver("register")

%% Establece conexion
Currentdir = pwd;
cd("C:\Program Files\COMSOL\COMSOL56\Multiphysics\mli");
mphstart(2036)
cd(Currentdir);

%% Comandos varios
import com.comsol.model.*;
import com.comsol.model.util.*;

%% Imprime los modelos en el servidor
% aka ModelUtil.tags
mphtags -show

%% Remover modelos del servidor
ModelUtil.remove("Model") % Elimina el modelo "Model" del servidor

%% Desconexion del servidor
% NOTE: De correr esta seccion, se cortara el contacto con COMSOL Server
% y MATLAB ya no podra correr scripts con funciones de COMSOL
ModelUtil.disconnect
