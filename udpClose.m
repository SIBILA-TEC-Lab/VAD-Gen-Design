%% Función para cerrar puerto y limpiar variables
function udpClose(udpPort, ipA, portA, ipB, portB)
    fclose(udpPort);
    delete(udpPort);

end
