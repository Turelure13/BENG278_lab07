% SE_script2.m
% 20230218 Div Bolar MD, PHD UCSD

% Spin Echo EPI %
TE_SE = [33; 50; 60; 80; 100; 120; 140; 160; 180; 200]';

figure

forROIdrawing = SE_data(1).img;
imagesc(SE_data(1).img);
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

for k = 1:length(SE_data)
    meanSI_SE(k) = mean ( SE_data(k).img(mask)) ;
end
    

%%
% Now, you have your mean signal intensity for the ROI across all TEs
meanSI_SE

% And your TEs
TE_SE

%%  Plot SI versus TE
figure
plot (TE_SE, meanSI_SE, 'bo'); hold 
plot(TE_SE, meanSI_SE, 'r-')

title ('SI versus TE -- Spin Echo', 'FontSize', 18)
xlabel(' TI (ms)', 'FontSize', 14)
ylabel('SI (AU)', 'FontSize', 14)

% -----------------------------------


%%
% Modify your MATLAB code to solve for T2* (T2 star) relaxation.  What value do you find?

xdata = TE_SE;
ydata = meanSI_SE;

M0_init = meanSI_SE(1);
T2_water_init = 200;
% x(1) = M0
% x(2) = T1_water
fun = @(x,xdata)x(1)*(exp(-xdata/x(2)));

x0 = [M0_init,T2_water_init];
x = lsqcurvefit(fun,x0,xdata,ydata)

figure;
times = linspace(xdata(1),xdata(end));
plot(xdata,ydata,'ko',times,fun(x,times),'b-')
legend('Data','Fitted exponential')
title('Data and Fitted Curve')
