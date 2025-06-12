function model = busbar()
%
% busbar.m
%
% Model exported on Jun 12 2025, 01:35 by COMSOL 5.6.0.401.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('C:\Users\cmadrigal\OneDrive - Estudiantes ITCR\COMSOL\Comsol\Modelo_test');

model.label('busbar.mph');

model.param.set('L', '9[cm]', 'Length');
model.param.set('rad_1', '6[mm]', 'Bolt radius');
model.param.set('tbb', '5[mm]', 'Thickness');
model.param.set('wbb', '5[cm]', 'Width');
model.param.set('mh', '6[mm]', 'Maximum element size');
model.param.set('htc', '5[W/m^2/K]', 'Heat transfer coefficient');
model.param.set('Vtot', '20[mV]', 'Applied voltage');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.result.table.create('evl3', 'Table');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('quickplane', 'xz');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'L+2*tbb' '0.1'});
model.geom('geom1').feature('wp1').geom.create('r2', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r2').set('pos', {'0' 'tbb'});
model.geom('geom1').feature('wp1').geom.feature('r2').set('size', {'L+tbb' '0.1-tbb'});
model.geom('geom1').feature('wp1').geom.create('dif1', 'Difference');
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input').set({'r1'});
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input2').set({'r2'});
model.geom('geom1').feature('wp1').geom.create('fil1', 'Fillet');
model.geom('geom1').feature('wp1').geom.feature('fil1').set('radius', 'tbb');
model.geom('geom1').feature('wp1').geom.feature('fil1').selection('point').set('dif1(1)', 3);
model.geom('geom1').feature('wp1').geom.create('fil2', 'Fillet');
model.geom('geom1').feature('wp1').geom.feature('fil2').set('radius', '2*tbb');
model.geom('geom1').feature('wp1').geom.feature('fil2').selection('point').set('fil1(1)', 6);
model.geom('geom1').create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').setIndex('distance', 'wbb', 0);
model.geom('geom1').feature('ext1').selection('input').set({'wp1'});
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('planetype', 'faceparallel');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').selection('face').set('ext1(1)', 8);
model.geom('geom1').feature('wp2').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp2').geom.feature('c1').set('r', 'rad_1');
model.geom('geom1').create('ext2', 'Extrude');
model.geom('geom1').feature('ext2').setIndex('distance', '-2*tbb', 0);
model.geom('geom1').feature('ext2').selection('input').set({'wp2'});
model.geom('geom1').create('wp3', 'WorkPlane');
model.geom('geom1').feature('wp3').set('planetype', 'faceparallel');
model.geom('geom1').feature('wp3').set('unite', true);
model.geom('geom1').feature('wp3').selection('face').set('ext1(1)', 4);
model.geom('geom1').feature('wp3').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp3').geom.feature('c1').set('pos', {'-L/2+1.5[cm]' '-wbb/4'});
model.geom('geom1').feature('wp3').geom.feature('c1').set('r', 'rad_1');
model.geom('geom1').feature('wp3').geom.create('copy1', 'Copy');
model.geom('geom1').feature('wp3').geom.feature('copy1').set('disply', 'wbb/2');
model.geom('geom1').feature('wp3').geom.feature('copy1').selection('input').set({'c1'});
model.geom('geom1').create('ext3', 'Extrude');
model.geom('geom1').feature('ext3').setIndex('distance', '-2*tbb', 0);
model.geom('geom1').feature('ext3').selection('input').set({'wp3'});
model.geom('geom1').run;
model.geom('geom1').run('fin');

model.material.create('mat1', 'Common', 'comp1');
model.material.create('mat2', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').propertyGroup.create('linzRes', 'Linearized resistivity');
model.material('mat2').selection.set([2 3 4 5 6 7]);
model.material('mat2').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');

model.physics.create('ec', 'ConductiveMedia', 'geom1');
model.physics('ec').model('comp1');
model.physics('ec').create('pot1', 'ElectricPotential', 2);
model.physics('ec').feature('pot1').selection.set([43]);
model.physics('ec').create('gnd1', 'Ground', 2);
model.physics('ec').feature('gnd1').selection.set([8 15]);
model.physics.create('ht', 'HeatTransfer', 'geom1');
model.physics('ht').model('comp1');
model.physics('ht').create('hf1', 'HeatFluxBoundary', 2);
model.physics('ht').feature('hf1').selection.set([1 2 3 4 5 6 7 9 10 11 12 13 14 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42]);

model.multiphysics.create('emh1', 'ElectromagneticHeating', 'geom1', 3);

model.mesh('mesh1').create('ftet1', 'FreeTet');

model.result.table('evl3').label('Evaluation 3D');
model.result.table('evl3').comments('Valores interactivos 3D');

model.view('view1').set('showmaterial', true);
model.view('view2').axis.set('xmin', -0.060047656297683716);
model.view('view2').axis.set('xmax', 0.21430188417434692);
model.view('view2').axis.set('ymin', -0.013441743329167366);
model.view('view2').axis.set('ymax', 0.12013578414916992);
model.view('view2').axis.set('manualgrid', true);
model.view('view2').axis.set('xspacing', '5e-3');
model.view('view2').axis.set('yspacing', '5e-3');
model.view('view3').axis.set('xmin', -0.06148114800453186);
model.view('view3').axis.set('xmax', 0.05148115009069443);
model.view('view3').axis.set('ymin', -0.027499999850988388);
model.view('view3').axis.set('ymax', 0.027499999850988388);
model.view('view4').axis.set('xmin', -0.05025000125169754);
model.view('view4').axis.set('xmax', 0.06525000184774399);
model.view('view4').axis.set('ymin', -0.028117788955569267);
model.view('view4').axis.set('ymax', 0.028117788955569267);

model.material('mat1').label('Copper');
model.material('mat1').set('family', 'copper');
model.material('mat1').propertyGroup('def').label('Basic');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'17e-6[1/K]' '0' '0' '0' '17e-6[1/K]' '0' '0' '0' '17e-6[1/K]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '385[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('density', '8960[kg/m^3]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]'});
model.material('mat1').propertyGroup('Enu').label('Young''s modulus and Poisson''s ratio');
model.material('mat1').propertyGroup('Enu').set('youngsmodulus', '110e9[Pa]');
model.material('mat1').propertyGroup('Enu').set('poissonsratio', '0.35');
model.material('mat1').propertyGroup('linzRes').label('Linearized resistivity');
model.material('mat1').propertyGroup('linzRes').set('rho0', '');
model.material('mat1').propertyGroup('linzRes').set('alpha', '');
model.material('mat1').propertyGroup('linzRes').set('Tref', '');
model.material('mat1').propertyGroup('linzRes').set('rho0', '');
model.material('mat1').propertyGroup('linzRes').set('alpha', '');
model.material('mat1').propertyGroup('linzRes').set('Tref', '');
model.material('mat1').propertyGroup('linzRes').set('rho0', '');
model.material('mat1').propertyGroup('linzRes').set('alpha', '');
model.material('mat1').propertyGroup('linzRes').set('Tref', '');
model.material('mat1').propertyGroup('linzRes').set('rho0', '1.72e-8[ohm*m]');
model.material('mat1').propertyGroup('linzRes').set('alpha', '0.0039[1/K]');
model.material('mat1').propertyGroup('linzRes').set('Tref', '298[K]');
model.material('mat1').propertyGroup('linzRes').addInput('temperature');
model.material('mat2').label('Titanium beta-21S');
model.material('mat2').set('family', 'titanium');
model.material('mat2').propertyGroup('def').label('Basic');
model.material('mat2').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('electricconductivity', {'7.407e5[S/m]' '0' '0' '0' '7.407e5[S/m]' '0' '0' '0' '7.407e5[S/m]'});
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'7.06e-6[1/K]' '0' '0' '0' '7.06e-6[1/K]' '0' '0' '0' '7.06e-6[1/K]'});
model.material('mat2').propertyGroup('def').set('heatcapacity', '710[J/(kg*K)]');
model.material('mat2').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('density', '4940[kg/m^3]');
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'7.5[W/(m*K)]' '0' '0' '0' '7.5[W/(m*K)]' '0' '0' '0' '7.5[W/(m*K)]'});
model.material('mat2').propertyGroup('Enu').label('Young''s modulus and Poisson''s ratio');
model.material('mat2').propertyGroup('Enu').set('youngsmodulus', '105e9[Pa]');
model.material('mat2').propertyGroup('Enu').set('poissonsratio', '0.33');

model.physics('ec').feature('pot1').set('V0', 'Vtot');
model.physics('ht').feature('hf1').set('HeatFluxType', 'ConvectiveHeatFlux');
model.physics('ht').feature('hf1').set('h', 'htc');

model.mesh('mesh1').feature('size').set('custom', 'on');
model.mesh('mesh1').feature('size').set('hmax', 'mh');
model.mesh('mesh1').feature('size').set('hmin', 'mh-mh/3');
model.mesh('mesh1').feature('size').set('hcurve', 0.2);
model.mesh('mesh1').run;

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').attach('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('se1', 'Segregated');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').create('ll1', 'LowerLimit');
model.sol('sol1').feature('s1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature.remove('fcDef');

model.result.create('pg1', 'PlotGroup3D');
model.result.create('pg2', 'PlotGroup3D');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg1').create('mslc1', 'Multislice');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'T');
model.result('pg3').create('iso1', 'Isosurface');
model.result('pg3').feature('iso1').set('expr', 'T');

model.sol('sol1').attach('std1');
model.sol('sol1').feature('st1').label('Compilar ecuaciones: Estacionario');
model.sol('sol1').feature('v1').label('Variables dependientes 1.1');
model.sol('sol1').feature('s1').label('Resolvedor estacionario 1.1');
model.sol('sol1').feature('s1').feature('dDef').label('Directo 2');
model.sol('sol1').feature('s1').feature('aDef').label('Avanzado 1');
model.sol('sol1').feature('s1').feature('se1').label('Segregado 1.1');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').label(['Corrientes el' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'ctricas']);
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_V'});
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').label('Temperatura');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp1_T'});
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('subdamp', 0.8);
model.sol('sol1').feature('s1').feature('se1').feature('ll1').label(['L' native2unicode(hex2dec({'00' 'ed'}), 'unicode') 'mite inferior 1.1']);
model.sol('sol1').feature('s1').feature('se1').feature('ll1').set('lowerlimit', 'comp1.T 0');
model.sol('sol1').feature('s1').feature('i1').label('Iterativo 1.1');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'cg');
model.sol('sol1').feature('s1').feature('i1').feature('ilDef').label(['Factorizaci' native2unicode(hex2dec({'00' 'f3'}), 'unicode') 'n LU incompleta 1']);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').label('Multimalla 1.1');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'amg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').label('Presuavizado 1');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('soDef').label('SOR 1');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').label('Postsuavizado 1');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('soDef').label('SOR 1');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').label('Resolvedor grueso 1');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('dDef').label('Directo 1');
model.sol('sol1').feature('s1').feature('d1').label('Directo, temperatura (ht)');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('i2').label('AMG, temperatura (ht)');
model.sol('sol1').feature('s1').feature('i2').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i2').set('rhob', 20);
model.sol('sol1').feature('s1').feature('i2').feature('ilDef').label(['Factorizaci' native2unicode(hex2dec({'00' 'f3'}), 'unicode') 'n LU incompleta 1']);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').label('Multimalla 1.1');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').label('Presuavizado 1');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('soDef').label('SOR 2');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('so1').label('SOR 1.1');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').label('Postsuavizado 1');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('soDef').label('SOR 2');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('so1').label('SOR 1.1');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').label('Resolvedor grueso 1');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('dDef').label('Directo 2');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').label('Directo 1.1');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').runAll;

model.result('pg1').label(['Potencial el' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'ctrico (ec)']);
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').feature('mslc1').set('colortable', 'RainbowLight');
model.result('pg1').feature('mslc1').set('resolution', 'normal');
model.result('pg2').label('Temperatura (ht)');
model.result('pg2').feature('surf1').label('Superficie');
model.result('pg2').feature('surf1').set('rangecoloractive', true);
model.result('pg2').feature('surf1').set('rangecolormin', 322.923094901252);
model.result('pg2').feature('surf1').set('rangecolormax', 330.960645576687);
model.result('pg2').feature('surf1').set('colortable', 'Traffic');
model.result('pg2').feature('surf1').set('colortablerev', true);
model.result('pg2').feature('surf1').set('resolution', 'normal');
model.result('pg3').label(['Contornos isot' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'rmicos (ht)']);
model.result('pg3').feature('iso1').label('Isosuperficie');
model.result('pg3').feature('iso1').set('number', 10);
model.result('pg3').feature('iso1').set('levelrounding', false);
model.result('pg3').feature('iso1').set('colortable', 'ThermalLight');
model.result('pg3').feature('iso1').set('resolution', 'normal');
end