

%% Ejecución de trabajos
job1 = batch("nsgaii")
store1 = job1.ValueStore;

job2 = batch("nsgaii")
job2 = job2.ValueStore;

% Se espera a que el último trabajo termine de ejecutarse
wait(job2)

%% Carga de variables locales de trabajos a memoria actual
eval1 = load(job1, "eval");
eval2 = load(job2, "eval");

figure;

%subplot(1,2,1)
scatter(eval1.eval(1,:), eval1.eval(2,:))

subplot(1,2,2)
scatter(eval2.eval(1,:), eval2.eval(2,:))

%% Limpieza de trabajos
delete(job1)
clear job1

delete(job2)
clear job2