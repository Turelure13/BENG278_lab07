% SR_script1.m
% 20230218 Div Bolar MD, PHD UCSD

addpath ./NIfTI_20140122/

% Saturation Recovery %
TI_SR= [  110; 200; 400; 600; 800; 1000; 1200; 1400; 1600; 1800; 2000; 2500; 3000]';

filenames = dir('./SR_NIFTI/*.nii');

cd SR_NIFTI/

for i = 1:numel(filenames)
    SR_data(i) = load_nii(filenames(i).name)
end

cd ..

%%
close all

t= tiledlayout(2,7);
for j = 1:length(SR_data)
        nexttile
        image(SR_data(j).img);
        colormap ("gray");  axis square
        curTI = ['TI = ' num2str(TI_SR(j))];
        title(curTI)
end
% 
% title(t,'Agar phantom vs TI for Saturation Recovery Sequence', 'FontSize', 10)
% set(gcf, 'Position', [ 56        1103        2349         942])

