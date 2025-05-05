%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EXITOSO A NIVEL LAN, CREO?
% FUNCIONA: 
%      SERVER ELECTRO -> SIBILA - YES
%      SIBILA -> SERVER ELECTRO - YES
%      SERVER ELECTRO -> CASA - NEL
%      CASA -> SERVER ELECTRO - NEL
% HEEEEEEEECK YEA
%
% La comunicacion udp parece solo transportar strings y binario tho
% UDP DOC PARA FLUSH WRITE READ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Parámetros computadoras
% Compu 1
ipA = '172.16.31.249';
portA = 9090;

% Compu 2
ipB = '172.21.6.148';
portB = 9091;

%% UDP Object
udpA = udp(ipB,portB,'LocalPort',portA);

%% Abrir canal UDP
fopen(udpA)

%% Escanear este puerto
fscanf(udpA)

%% Test
fprintf(udpA, 'test test TEST';

%% Cerrar puerto y limpiar variables
fclose(udpA)
delete(udpA)
clear ipA portA ipB portB udpA
