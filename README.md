# VAD-Gen-Design
Herramienta de diseño generativo con Algoritmos Evolutivos

La herramienta utiliza COMSOL LiveLink para Matlab, una conexión hecha por medio de COMSOL Server, para acceder a los métodos, herramientas e interfaces de COMSOL por medio del entorno de scripting de Matlab.

Actualmente, el proyecto consiste las siguientes secciones principales:
 
 - nsgaiiGUI.mlx  ->  Un LiveScript de Matlab, interfaz de las funciones necesarias para correr el programa del lado del modelo.

    Actualmente, los siguientes archivos van asociados a esta sección:
        ~ binLoad.m *
        ~ binSave.m *
        ~ crossover.m
        ~ evaluation.m
        ~ fitnessFunct.m
        ~ nonDominatingSorting.m
        ~ nsgaii.m
        ~ selection.m
        ~ udpClose.m*
        ~ udpComms.m *
        ~ udpPrint.m *
        ~ udpScan.m *



 - comsolSimGUI.mlx  ->  Un LiveScript de Matlab, interfaz de las funciones necesarias para correr el programa del lado de la verificación con la simulación multifísica.

    Actualmente, los siguientes archivos van asociados a esta sección:
        ~ binLoad.m *
        ~ binSave.m *
        ~ busbar.m
        ~ busbar.mph
        ~ comsolServer.m
        ~ modelEval.m
        ~ modelShutDown.m
        ~ simEval.m
        ~ serverShutDown.m
        ~ udpClose.m*
        ~ udpComms.m *
        ~ udpPrint.m *
        ~ udpScan.m *
        


* Son scripts que ambas secciones requieren para su funcionamiento



- El archivo nsgaiiSim.m consiste en una versión del algoritmo que se corre exclusivamente en una computadora, utilizada para probar el código sin tener ambos ordenadores disponibles.



- Archivos de prototipos, utilizados como pruebas de concepto o para demostración de funcionalidad.
    ~ batchTest.m
    ~ comm_test.m
    ~ model_test.m
    ~ openfiletest.m
    ~ pareto_test.m
    ~ server_test.m
    ~ timeTest.m
    ~ udpPrintTest.m
    ~ udpScanTest.m
    ~ 