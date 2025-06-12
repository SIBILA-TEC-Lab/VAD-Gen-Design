message = 'Null';
udpRetrieved = 0;
confirm = 'Null';

while udpRetrieved == 0
    % Escanear el puerto abierto hasta recibir noticias
    while isequal(message, 'Null')
        message = fscanf(udpPort)
        % Se remueve el caracter de final de mensaje
        message = message(1:length(message)-1);
    end
    
    % Una vez que se recibe el mensaje, se envia confirmacion
    fprintf(udpPort, message);

    % Y se lee el puerto hasta recibir confirmacion de veracidad
    while isequal(confirm, 'Null')
        confirm = fscanf(udpPort)
        confirm = confirm(1:length(confirm)-1);
    end
    
    if isequal(confirm,'Success')  % Si el mensaje recibido coincide
        udpRetrieved = 1;
    else  % De lo contrario
        % Se prepara para recibir el mensaje de vuelta
        confirm = 'Null';
        message = 'Null';
    end       
end

disp('Test exitoso!')