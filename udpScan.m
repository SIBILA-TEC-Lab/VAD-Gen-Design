%% Función para recuperar información en puerto
function message = udpScan(udpPort)
    % Escanear el puerto abierto
    message = fscanf(udpPort);

    % Verificación del mensaje
    udpRetrieved = 0;  % Flag de mensaje enviado ok

    fprintf(udpPort, message);
    
end
