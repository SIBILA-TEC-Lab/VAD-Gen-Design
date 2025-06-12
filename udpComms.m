%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EXITOSO A NIVEL LAN, CREO?
% FUNCIONA: 
%      SERVER ELECTRO -> SIBILA - YES
%      SIBILA -> SERVER ELECTRO - YES
%      SERVER ELECTRO -> CASA - NEL
%      CASA -> SERVER ELECTRO - NEL
% HEEEEEEEECK YEA
%
% La comunicacion udp parece solo transportar strings y binario
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Función para abrir puertos
function [udpPort]  = udpComms(ipA, ipB, portA, portB, port)
    % UDP Object
    if port == 0
        % De ser la computadora el con el modelo
        udpPort = udp(ipB,portB,'LocalPort',portA);
    else
        % De ser la computadora con la sim
        udpPort = udp(ipA, portA, 'LocalPort', portB);
    end

    % Abrir canal UDP
    fopen(udpPort)
end