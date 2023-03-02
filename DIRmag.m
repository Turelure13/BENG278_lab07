% 20230223 Div Bolar USCD
%
% Find TIs to null two species based on two T1's


function S = DIRmag(params, plot_on)

TI1 = params(1);  
TI2 = params(2);  

T1_species1 = 954;
T1_species2 = 3137;

% % SO after first inversion you are recovering from -1
% M_TI1 =  1 - 2*exp(-TI1/T1);
% 
% % After second inversion you are recovering from -M_T1  after second inversion. 
% M_TI2 = 1- exp(-TI2/T1) - M_TI1*exp(-TI2/T1);  % Need minus sign because of inversion


counter = 1;
for t= 0:TI1
    curMag_species1(counter) =   1 - 2*exp(-t/T1_species1);
    curMag_species2(counter) =   1 - 2*exp(-t/T1_species2);
    counter = counter+1;
end

finalMagb4_Inv2_species1 = curMag_species1(t);
finalMagb4_Inv2_species2 = curMag_species2(t);

for t=0:TI2
    curMag_species1(counter) = 1- exp(-t/T1_species1) - finalMagb4_Inv2_species1*exp(-t/T1_species1);
    curMag_species2(counter) = 1- exp(-t/T1_species2) - finalMagb4_Inv2_species2*exp(-t/T1_species2);

    counter = counter+1;
end
 
% MINIMIZE based on sqrt of sum of squares (least squares)
S =  sqrt( curMag_species1(end)^2 +  curMag_species2(end)^2 ); %% THIS IS WHAT WE WANT TO MINIMIZE!


%%
% Plot recovery curves if flag on (don't want do it during optimization step, of course)

if (plot_on == 1 )
    figure; hold on
    plot(curMag_species1, 'b', 'LineWidth', 2)
    plot(curMag_species2, 'r', 'LineWidth', 2)
    yline(0)
    legend(['T1 = ' num2str(T1_species1)], ['T1 = ' num2str(T1_species2)])

    % Set font size for current figure
    set(gca,'FontSize',20)
    format short g
    
    xlabel(['TI1 =  ' num2str(round(params(1))) ' ms   TI2 = ' num2str(round(params(1) + params(2))) ' ms  '  'TI2-TI1 = '  num2str(round(params(2))) ' ms'])    

    format
    ylabel('Signal Intensity')
end


