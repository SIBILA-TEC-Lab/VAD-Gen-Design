import com.comsol.model.*;
import com.comsol.model.util.*;

iter = 50;

L = 9; rad1 = 5; tbb = 5; wbb = 6; mh = 4; htc = 4.5; vTot = 20;

%% Corrida secuencial de llamado a Comsol Desktop
% Tiempo requerido: 
%           73.543708 seconds. (6 individuos)
%           203.764785 seconds. (20 individuos)
tic
list1 = zeros(iter,1);
for i = 1:iter
    model = mphopen('busbar.mph');
    model.param.set('L', '10[cm]');
    model.study('std1').run(); 
    list1(i) = mphmax(model, 'T', 'volume');
    mphopen -clear;
    ModelUtil.remove("Model");
    clear model;
end
toc

%% Corrida secuencial de llamado a script de Matlab
% Tiempo requerido: 
%           119.319518 (6 individuos)
%           346.361211 seconds. (20 individuos)
tic
list2 = zeros(iter,1);
for i = 1:iter
    model = busbar();
    model.param.set('L', '10[cm]');
    model.study('std1').run(); 
    list2(i) = mphmax(model, 'T', 'volume');
    mphopen -clear;
    ModelUtil.remove("Model");
    clear model;
end
toc


%% Llamada a modificacion de parametros (Comsol Desktop)
% Tiempo requerido: 
%           45.774432 (6 individuos)
%           145.891952 seconds. (20 individuos)

tic
model = mphopen('busbar.mph');
list3 = zeros(iter,1);

for i = 1:iter
    model.param.set('L', '10[cm]');
    model.study('std1').run(); 
    list3(i) = mphmax(model, 'T', 'volume');
end

mphopen -clear;
ModelUtil.remove("Model");
clear model;
toc


%% Llamada a modificacion de parametros script
% Tiempo requerido: 
%           40.538459 seconds. (6 individuos)
%           108.775303 seconds. (20 individuos)

tic
model = busbar();
list4 = zeros(iter,1);

for i = 1:iter
    model.param.set('L', '10[cm]');
    model.study('std1').run(); 
    list4(i) = mphmax(model, 'T', 'volume');
end

mphopen -clear;
ModelUtil.remove("Model");
clear model;
toc


%% Funcion a ejecutar para simular las iteraciones de evaluacion
function tempResult = simEval(model, iter)
 
% Redefinicion de parametros de la simulacion
length = strcat(int2str(8+iter), '[cm]');
model.param.set('L', length);

thickness = strcat(int2str(3+iter), '[mm]');
model.param.set('tbb', thickness);

% Llamado al calculo del estudio con los parametros nuevos
model.study('std1').run(); 

% Resultado obtenido: la temperatura maxima del estudio resultante
tempResult = mphmax(model, 'T', 'volume');
end