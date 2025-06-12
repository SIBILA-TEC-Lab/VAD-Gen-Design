%% Prueba de funcion de eval, en donde la eval sea esperar a la respuesta
% de la otra compu

% Hará falta un puerto para recibir, otro imprimir?

function results = commsEval(population)
    %% Direcciones IP de las dos computadoras
    ipA = '172.16.31.249';
    ipB = '172.21.6.148';
    
    %% Inicializacion de flags
    commsOpened = 0;
    udpSent = 0;

    %% Se abre el puerto con esta compu como host
    [commsOpened, udpPort] = comms(ipA, ipB, 1);
    waitfor(commsOpened)

    %% Se envian los individuos a la otra compu
    % Para cada individuo
    for i = 1:size(population)
        % Se convierte el individuo en una tira de strings
        message = "";
        for j = 1:size(population(:,i))
            message = message + sprintf(j);
        end
        
        % Se envia el mensaje resultante
        udpSent = udpPrint(udpPort, message);

        % Se espera a alguna verificacion de que llego el mensaje
        waitfor(udpSent)
    end

    %% Se escucha a que se confirme que finalizo la eval
    try
        a = udpScan(udpPort)
    catch ME
    disp(ME.message);
end
end