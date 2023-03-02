
% 20220908 Div Bolar USCD
% Fit a curve for double IR, two species nulling based on T1s

% function [fitcurveparams Rsquared R resnorm residuals] = DIRoptimize(T1_species1, T1species2)


% Options for fminsearchbnd
options.MaxFunEvals =1e20;
options.MaxIter = 1e20;
options.MaxIter = 1000;
options.TolCon = 1e-10;
options.TolX = 1e-10;
options.TolFun = 1e-10;
options.Display='iter';
options.DiffMinChange=1;

options.OutputFcn='';

% GUESSES
TI1_guess = 556;  %% What is the maximum magnetization (i.e. fully relaxed)
TI2_guess = 2231;  %% What magnetization are we starting at?

params0 = [TI1_guess TI2_guess];

[params, feval, exitflag, lambda] = fminsearchbnd(@(params) DIRmag(params, 0), params0, [100 100 ], [100000 1000000], options);

plot_on =1;
DIRmag(params, plot_on)

format short g
params
format


