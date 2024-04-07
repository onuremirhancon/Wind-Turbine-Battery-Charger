function  Vout_mean = plotter1(data, name)

    Vp_A = data{1}.Values.Data ;
    Vp_C = data{2}.Values.Data ;
    Vp_B = data{3}.Values.Data ;
    SW1 = data{4}.Values.Data ;
    Vout = data{5}.Values.Data ;

    time = data{1}.Values.time;

    figure  
    plot(time, Vp_A,'-ob'); hold on;
    plot(time, Vp_B,'-or'); hold on;
    plot(time, Vp_C,'-og'); hold on;
    plot(time, SW1,'-c'); hold on;
    plot(time, Vout,'-om'); hold on;
    ylabel('Voltage (V)')
    xlabel('Time (s)')
    xlim([0.360 0.400])
    ylim([-40 40])
   
    saveas(gcf,[name '.png'])


    % get last two oscilation to calculate the ratio between ripple and mean
    [Rx,Cx] = find(time>=0.36) ;
    % Steady state output waveform
    Vout_ss = Vout(min(Rx):max(Rx)) ;
    Vout_time = time(min(Rx):max(Rx)) ;
    % To find mean output voltage, use numeric integration.
    Vout_mean = trapz(Vout_time,Vout_ss) / ( (max(Vout_time))-min(Vout_time)) ;
    sprintf([name, '  :Mean Output Voltage %d V'],Vout_mean)
    
end