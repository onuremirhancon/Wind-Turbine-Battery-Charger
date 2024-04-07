
clear,clc,close all
tstepMax = 0.1e-3 ;

%%%%%% Thyristor %%%%%%%%%%%
% Run the simulink model using sim command
v_in = 20;
sim('thyristor.slx')
Data = ans.OutputData1;
% Q3 part a Figure plotting
Vav = plotter1(Data,'thyristor_1');


%%%%%% Thyristor Average Voltage vs Firing Angle %%%%%%%%%%%
clear,clc,close all
tstepMax = 0.1e-3 ;
v_in = 20;

ls = [];

firing = linspace(0,pi,40);

for k1 = 1:length(firing)
    alpha = firing(k1)*20e-3/(2*pi);
    sim('thyristor_firing.slx')
    
    Vout = ans.OutputData1{5}.Values.Data ;
    time = ans.OutputData1{5}.Values.time;
    % get last two oscilation to calculate the ratio between ripple and mean
    [Rx,Cx] = find(time>=0.36) ;
    % Steady state output waveform
    Vout_ss = Vout(min(Rx):max(Rx)) ;
    Vout_time = time(min(Rx):max(Rx)) ;
    % To find mean output voltage, use numeric integration.
    Vout_mean = trapz(Vout_time,Vout_ss) / ( (max(Vout_time))-min(Vout_time)) ;
    sprintf('%d  :Mean Output Voltage %d V', k1, Vout_mean)

    ls=[ls,Vout_mean];
end

figure  
plot(firing*180/pi, ls,'-ob')
ylabel('Average Voltage (V)')
xlabel('Firing Angle')
xlim([0 180])
% ylim([-25 40])

saveas(gcf,'firing.png')


%%%%%% Thyristor Selected %%%%%%%%%%%

clear,clc,close all
tstepMax = 0.1e-3 ;

% Run the simulink model using sim command
v_in = 20;
alpha = (103*pi/180)*20e-3/(2*pi);
sim('thyristor_selected.slx')
Data = ans.OutputData1;
% Q3 part a Figure plotting
Vav = plotter2(Data,'thyristor_selected');

