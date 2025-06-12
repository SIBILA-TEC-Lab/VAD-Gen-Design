%% Función para enviar info por el puerto
% Note: datagram max de UDP por default = 65536 bytes
% Un float single es del rango de  –3.4 × 1038 and 3.4 × 1038, 4 bytes
function udpSent = udpPrint(udpPort, message)
    % Imprimir por el puerto abierto
    fprintf(udpPort, message);

    % Verificación rápida
    udpSent = 0;  % Flag de mensaje enviado ok
    confirm = "Null";  % Variable en donde se guarda confirmacion

    while udpSent == 0
        while confirm == "Null"  % Se lee el puerto hasta recibir noticias
            confirm = fscanf(udpPort);
        end

        if confirm == message  % Si el mensaje recibido por cliente coincide
            fprintf(udpPort, "Success");
            udpSent = 1;
        else  % De lo contrario
            fprintf(udpPort, message);  % Se reenvía el mensaje

        end

end
