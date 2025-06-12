% Este script lee un archivo binario para extraer las variables dentro
function dataOut = binLoad(filename)

% Abre un archivo binario para leer
try
    fileID = fopen(filename, 'rb');
catch ME
    rethrow(ME)
end

% Se define el tamano de la matriz esperada usando el header
numElements = fread(fileID, 1, 'int32');  % Lee el primer dato en binario

% Segun eso, lee el tamano de las matrices a leer
header = zeros(numElements);
if numElements == 1
    rows = fread(fileID, 1, 'int32');
    columns = fread(fileID, 1, 'int32');
    % Leer la matriz en el archivo (asumiendo el tamano y formato float32
    dataOut = fread(fileID, [rows, columns], 'float32');

else
    matrixSizes = cell(1, numElements);
    for i = 1:numElements
        size = fread(fileID, 2, 'int32')';
        matrixSizes{i} = size;
    end
    % Leer las matrices en el archivo
    dataOut = cell(1,numElements);
    for i = 1:numElements
        rows = matrixSizes{i}(1);
        columns = matrixSizes{i}(2);
        datum = fread(fileID, [rows, columns], 'float32');
        dataOut{i} = datum;
    end
end


% Cerrar el archivo luego de leerlo
fclose(fileID);

disp(strcat('Carga exitosa del archivo: ', 'data.bin'))
end