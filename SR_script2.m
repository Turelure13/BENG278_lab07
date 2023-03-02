% SR_script2.m
% 20230218 Div Bolar MD, PHD UCSD

% Saturation Recovery %
TI_SR= [  110; 200; 400; 600; 800; 1000; 1200; 1400; 1600; 1800; 2000; 2500; 3000]';

figure

forROIdrawing = SR_data(j).img;
image(SR_data(j).img);
colormap ("gray");  axis square

% -----------------------------------------
% Use "drawcircle"to selective a decent size ROI from center of image. 

display('**********************')
display('***** Draw ROI! ******')
display('**********************')

title('Draw ROI!', 'FontSize', 18)

ROI = drawcircle(gca);  %% PLEASE INTERACT WITH IMAGE %%
mask = createMask(ROI);

% ------------------------------------

% This applies the mask you just created to ALL the images in the series

for k = 1:length(SR_data)
    meanSI_SR(k) = mean ( SR_data(k).img(mask)) ;
end
    

%%
% Now, you have your mean signal intensity for the ROI across all TIs
meanSI_SR

% And your TIs
TI_SR

%%  Plot SI versus TI
figure
plot (TI_SR, meanSI_SR, 'bo'); hold 
plot(TI_SR, meanSI_SR, 'r-')

title ('SI versus TI -- Saturation Recovery', 'FontSize', 18)
xlabel(' TI (ms)', 'FontSize', 14)
ylabel('SI (AU)', 'FontSize', 14)

% -----------------------------------


%%
% Write MATLAB code that uses the expression for Saturation Recovery and fit for T1


xdata = TI_SR;
ydata = meanSI_SR;

M0_init = meanSI_SR(end);
T1_water_init = 4000;
% x(1) = M0
% x(2) = T1_water
fun = @(x,xdata)x(1)*(1-exp(-xdata/x(2)));

x0 = [M0_init,T1_water_init];
x = lsqcurvefit(fun,x0,xdata,ydata)

figure;
times = linspace(xdata(1),xdata(end));
plot(xdata,ydata,'ko',times,fun(x,times),'b-')
legend('Data','Fitted exponential')
title('Data and Fitted Curve')
