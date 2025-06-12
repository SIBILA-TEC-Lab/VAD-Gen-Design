% Este script codifica datos para almacenarlos en un archivo binario

% Funcion encargada de haber solo una matriz a guardar
function binSave(filename, varargin)

% Abre un archivo binario para escribir
% SI EL ARCHIVO YA EXISTE, LO SOBREESCRIBE
try
    fileID = fopen(filename, 'wb');
catch ME
    rethrow(ME)
end


% Guarda el tamano de la matriz como una especie de header
numElements = numel(varargin);
fwrite(fileID, numElements, 'int32');

% Obtiene el tamano de cada una de las matrices de entrada
if numElements == 1 
    header = size(varargin{1});
else
    header = [];
    for i = 1:numElements
        header = [header size(varargin{i})];
    end
end
fwrite(fileID, header, 'int32');
    

% Ahora guarda las variables en el binario
% Se guarda matriz, formato Float Single
for i = 1:numElements
    fwrite(fileID, varargin{i}, 'float32');  
end


% Se cierra el archivo luego de guardar
fclose(fileID);

disp(strcat('Datos almacenados exitosamente en: ', filename));
end