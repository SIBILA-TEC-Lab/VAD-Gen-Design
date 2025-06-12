% Duracion: 

tic
% Imprimir por el puerto abierto
fprintf(udpPort, message);
pause(0.001)

% Verificación rápida
udpSent = 0;  % Flag de mensaje enviado ok
confirm = 'Null';  % Variable en donde se guarda confirmacion

while udpSent == 0
    % Se lee el puerto hasta recibir noticias
    while isequal(confirm, 'Null')  
        confirm = fscanf(udpPort)
        confirm = confirm(1:length(confirm)-1);
    end
    
    % Si el mensaje recibido por cliente coincide
    if isequal(confirm, message)  % Si el mensaje recibido por cliente coincide
        fprintf(udpPort, 'Success')
        udpSent = 1;
    else  % De lo contrario
        fprintf(udpPort, message);  % Se reenvía el mensaje
        confirm = 'Null';
    end
end

disp('Test exitoso!')
toc