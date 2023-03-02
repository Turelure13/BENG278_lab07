% GRE_script1.m
% 20230218 Div Bolar MD, PHD UCSD

addpath ./NIfTI_20140122/

% Gradient Echo EPI %
TE_GRE = [  20; 30; 40; 50; 60; 70; 80; 90; 100; 120; 140; 160]';

filenames = dir('./GRE_NIFTI/*.nii');

cd GRE_NIFTI/

for i = 1:numel(filenames)
    GRE_data(i) = load_nii(filenames(i).name)
end

cd ..

%%
close all

t= tiledlayout(2,6);
for j = 1:length(GRE_data)
        nexttile
        imagesc(GRE_data(j).img, [0 700]);
        colormap ("gray");  axis square
        curTE = ['TE = ' num2str(TE_GRE(j))];
        title(curTE)
end

title(t,'Agar phantom vs TE for Gradient Echo Sequence', 'FontSize', 20)
set(gcf, 'Position', [ 56        1103        2349         942])

%%
% Describe qualitatively what you see.  What governs this behavior?
% Provide the expression for the decay you see here (i.e SI as a function of TE). 
% 




