% Funcion a ejecutar para evaluar el modelo dado parametros que entren
function results = simEval(model, data)
import com.comsol.model.*;    
import com.comsol.model.util.*;



% Redefinicion de parametros de la simulacion
% En este caso, 3 de ellos
L = data(1);
tbb = data(2); 
wbb = data(3);

% Definicion de parametros
length = strcat(num2str(L),'[cm]');
model.param.set('L', length);

thickness = strcat(int2str(tbb), '[mm]');
model.param.set('tbb', thickness);

width = strcat(num2str(wbb),'[cm]');
model.param.set('wbb', width);



% Llamado al calculo del estudio con los parametros nuevos
model.study('std1').run(); 

% Resultado obtenido: la temperatura maxima del estudio resultante
tempResult = mphmax(model, 'T', 'volume');
voltResult = mphmax(model, 'V', 'volume');

% Note: los signos de esta salida 
% define si un parametro se minimiza o maximiza
results = [tempResult; voltResult];

end