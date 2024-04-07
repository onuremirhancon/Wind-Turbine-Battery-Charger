
clear,clc,close all
tstepMax = 0.1e-3 ;

%%%%%% Q_3_1_a %%%%%%%%%%%
% Run the simulink model using sim command
v_in = 15*sqrt(2);
sim('Q_3_2_a.slx')
% Q3 part a Figure plotting
plotter(OutputData1,'Q_3_2_a')


