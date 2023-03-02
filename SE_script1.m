% SE_script1.m
% 20230218 Div Bolar MD, PHD UCSD

addpath ./NIfTI_20140122/

% Spin Echo EPI %
TE_SE = [33; 50; 60; 80; 100; 120; 140; 160; 180; 200]';

filenames = dir('./SE_NIFTI/*.nii');

cd SE_NIFTI/

for i = 1:numel(filenames)
    SE_data(i) = load_nii(filenames(i).name)
end

cd ..

%%
close all

t= tiledlayout(2,5);
for j = 1:length(SE_data)
        nexttile
        imagesc(SE_data(j).img, [0 400]);
        colormap ("gray");  axis square
        curTE = ['TE = ' num2str(TE_SE(j))];
        title(curTE)
end

title(t,'Agar phantom vs TE for Spin Echo Sequence', 'FontSize', 20)
set(gcf, 'Position', [ 56        1103        2349         942])

%%
% Describe qualitatively what you see.  What governs this behavior?
% Provide the expression for the decay you see here (i.e SI as a function of TE). 
% 
