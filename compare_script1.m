% compare_script1.m
% 20230218 Div Bolar MD, PHD UCSD

%  This relies on you having run scripts from the first section. 

figure
tiledlayout(1,6);

nexttile
imagesc(IR_data(14).img); colormap("gray"); axis square;
title('Inversion Recovery; TI = 3000', 'FontSize', 18);

nexttile
imagesc(SR_data(13).img); colormap("gray"); axis square;
title('Saturation Recovery; TI = 3000', 'FontSize', 18);

nexttile
imagesc(SE_data(2).img); colormap("gray"); axis square;
title('Spin Echo; TE = 50', 'FontSize', 18);

nexttile
imagesc(GRE_data(5).img); colormap("gray"); axis square;
title('Gradient Echo; TE = 50', 'FontSize', 18);

nexttile
imagesc(SE_data(8).img); colormap("gray"); axis square;
title('Spin Echo; TE = 160', 'FontSize', 18);

nexttile
imagesc(GRE_data(12).img); colormap("gray"); axis square;
title('Gradient Echo; TE = 160', 'FontSize', 18);



set(gcf, 'Position', [ 69        1300        2228         731]);