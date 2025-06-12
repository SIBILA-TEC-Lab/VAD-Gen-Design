%% Parametros computadoras
% Compu 1
ipA = '172.16.27.183'; 
portA = 9090;

% Compu 2
ipB = '172.21.6.148';  
portB = 9091;

%% UDP Object
udpB = udp(ipA,portA,'LocalPort',portB);

%% Abrir canal UDP
fopen(udpB)

%% Imprimir en otro puerto
fprintf(udpB,'Test')

%% Escanear este puerto
fscanf(udpB)

%% Cerrar puerto y limpiar variables
fclose(udpB)
delete(udpB)
clear ipA portA ipB portB udpB notes