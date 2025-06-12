%% Definicion de params
model.param.set('L', '9[cm]', 'Length');
model.param.set('rad_1', '6[mm]', 'Bolt radius');
model.param.set('tbb', '5[mm]', 'Thickness');
model.param.set('wbb', '5[cm]', 'Width');
model.param.set('mh', '3[mm]', 'Maximum element size');
model.param.set('htc', '5[W/m^2/K]', 'Heat transfer coefficient');
model.param.set('Vtot', '2[mV]', 'Applied voltage');

% Para cambiar un param, se referencia en 1er param, luego se cambia
% model.param.set('Vtot', '20[mV]');

%% Geometria

