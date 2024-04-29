function [outs] = SGLT2i_analyze_v_clamp(Y, T, parameters, state_names, CL, PP, EL, protocol,rhs_model)
% Analysis and plotting

    V_idx = find(strcmp(state_names, 'V'));
    V = Y(:, V_idx);
    
    I_Na = SGLT2i_get_currents(T, Y, parameters, rhs_model);
    
    % Decompose sweeps
    end_ind = find(T<=T(end)-EL,1,"last");
    T = T(1:end_ind);
    Y = Y(1:end_ind,:);
    V = V(1:end_ind);
    I_Na = I_Na(1:end_ind);
    
    start_ind = find(T>=PP,1,"first");
    T = T(start_ind:end);
    T = T-PP;
    Y = Y(start_ind:length(Y(:,1)),:);
    V = V(start_ind:end);
    I_Na = I_Na(start_ind:end);
    
    num_pulses = round(max(T),0)/CL;
%     figure
    for i = 1:num_pulses
        if i == 1
            sweep_start = 1;
        else
            sweep_start = find(T>=(i-1)*CL,1,"first");
        end
        sweep_end = find(T>=i*CL,1,"first");
        Sweep_Y = Y(sweep_start:sweep_end,:);
        Sweep_V = Sweep_Y (:, V_idx);
        Sweep_T = T(sweep_start:sweep_end)-T(sweep_start);
        Sweep_I_Na = I_Na(sweep_start:sweep_end);
%            
%         subplot(2,1,1), plot(Sweep_T, Sweep_V), hold on
%         subplot(2,1,2), plot(Sweep_T, Sweep_I_Na), hold on
%         subplot(2,1,1), ylabel('V_m (mV)')
%         subplot(2,1,2), ylabel('I_{Na} (pA/pF)')
%         subplot(2,1,2), xlabel('time (ms)')
    
        Sweeps_Y{i,:,:} = Sweep_Y;
        Sweeps_T{i,:} = Sweep_T;
        Sweeps_V{i,:} = Sweep_V;
        Sweeps_I_Na{i,:} = Sweep_I_Na;
    end

    switch protocol
        case 'activation'
            try
                V = -130:10:0;
                base_start = find(Sweeps_T{i}>400,1,'first');
                base_end = find(Sweeps_T{i}>490,1,'first');
                base_I(i) = mean(Sweeps_I_Na{i}(base_start:base_end));
%                 figure
                for i = 1:length(Sweeps_V)                    
                    %Peak I_Na
                    [peak_INa(i),peak_INa_ind(i)] = min(Sweeps_I_Na{i});
                    peak_INa(i) = peak_INa(i)-base_I(i);                  
%                     subplot(2,1,1), plot(Sweeps_T{i}, Sweeps_V{i})
%                     subplot(2,1,2), plot(Sweeps_T{i}, Sweeps_I_Na{i},'g'), hold on
%                     subplot(2,1,2), plot(Sweeps_T{i}(peak_INa_ind(i)), peak_INa(i), 'k*')
%                     subplot(2,1,1), ylabel('V_m (mV)')
%                     subplot(2,1,2), ylabel('I_{Na} (pA/pF)')
%                     subplot(2,1,2), xlabel('time (ms)')
%                     pause
                end
                % Pseudo-activation curve
                peak_INa_subt = peak_INa-(max(peak_INa));
                peak_INa_norm = peak_INa_subt./min(peak_INa);
                boltzmann = '1/(1+exp((a-x)/b))';
                start = [-20,5];
                [f1,gof] = fit(V',peak_INa_norm',boltzmann,'Start',start);
                
                
%                 figure
%                 plot(f1,V,peak_INa_norm,'r*')
                disp(strcat('v_half_act',num2str(f1.a)))
    
                % Find overall peaks and assign outputs
                outs(1) = {peak_INa_norm};
                outs(2) = {f1.a};
                outs(3) = {gof.rsquare};
                outs(4) = {f1};
            catch
                disp(strcat(num2str(i), ':', num2str(min(Sweeps_T{i,:})),':', num2str(max(Sweeps_T{i,:})),':',num2str((i-1)*CL),':',num2str((i)*CL), ':', num2str(max(Sweeps_T{1,:})), ':',num2str((1)*CL)));
                outs(1) = {NaN};
                outs(2) = {NaN};
                outs(3) = {NaN};
            end
%         pause
        case 'availability'
            try
                V = -130:10:0;
%                 figure
                for i = 1:length(Sweeps_V) 
                    start_pulse = find(Sweeps_T{i}>500,1,'first');
                    end_plat = find(Sweeps_T{i}<500,1,'last');
                    start_plat = find(Sweeps_T{i}>400,1,'first');
                    [peak_INa(i),peak_INa_ind(i)] = min(Sweeps_I_Na{i}(start_pulse:end));
                    [plat_INa(i)] = mean(Sweeps_I_Na{i}(start_plat:end_plat));
%                     plot(Sweeps_T{i}, Sweeps_I_Na{i}), hold on 
%                     plot(Sweeps_T{i}(peak_INa_ind(i)+start_pulse), peak_INa(i), 'r*')
%                     plot(Sweeps_T{i}(end_plat), plat_INa(i), 'k*')
                end
                peak_INa = peak_INa-plat_INa;
                peak_INa = peak_INa-(max(peak_INa));
            %                 max_peak_INa = max(abs(peak_INa))-min(abs(peak_INa));
                peak_INa_norm = peak_INa./min(peak_INa);
                boltzmann = '1/(1+exp((x-a)/b))';
                start = [-40,9];
                [f1,gof] = fit(V',peak_INa_norm',boltzmann,'Start',start);
%                 figure
%                 plot(f1,V,peak_INa_norm,'r*')
                disp(strcat('v_half_inact',num2str(f1.a)))
            %                 pause
                v_half = f1.a;
                outs(1) = {peak_INa_norm};
                outs(2) = {v_half};
                outs(3) = {gof.rsquare};
                outs(4) = {f1};
            catch
                outs(1) = {NaN};
                outs(2) = {NaN};
                outs(3) = {NaN};
                outs(4) = {NaN};
            end
        case 'late'
            try
%                 figure
                start_pulse = find(Sweeps_T{1}>1000,1,'first');
                [peak_INa,peak_INa_ind] = min(Sweeps_I_Na{1}(start_pulse:end));
                start_late = find(Sweeps_T{1}>1060,1,'first');
                Late_INa_amp = min(Sweeps_I_Na{1}(start_late:end));
                Late_INa_AUC = trapz(Sweeps_I_Na{1}(start_late:end));
%                 plot(Sweeps_T{1}, Sweeps_I_Na{1}), hold on 
%                 plot(Sweeps_T{1}(peak_INa_ind+start_pulse), peak_INa, 'r*')
%                 plot(Sweeps_T{1}(end_late), Late_INa, 'k*')
                outs(1) = {peak_INa};
                outs(2) = {Late_INa_amp};
                outs(3) = {Late_INa_AUC};
            catch
                outs(1) = {NaN};
                outs(2) = {NaN};
                outs(3) = {NaN};
            end
        case 'recovery'
            try
                P1_start = find(Sweeps_T{i}>1900,1,'first');
                P1_end = find(Sweeps_T{i}<2020,1,'last');
%                 figure
                for i = 1:length(Sweeps_V)                    
                    %Peak I_Na
                    [P1(i),P1_ind(i)] = min(Sweeps_I_Na{i}(P1_start:P1_end));
                    [P2(i),P2_ind(i)] = min(Sweeps_I_Na{i}(P1_end:end)); 
%                     subplot(2,1,1), plot(Sweeps_T{i}, Sweeps_V{i})
%                     subplot(2,1,2), plot(Sweeps_T{i}, Sweeps_I_Na{i},'g'), hold on
%                     subplot(2,1,2), plot(Sweeps_T{i}(P1_ind(i)+P1_start), P1(i), 'k*')
%                     subplot(2,1,2), plot(Sweeps_T{i}(P2_ind(i)+P1_end), P2(i), 'r*')
%                     subplot(2,1,1), ylabel('V_m (mV)')
%                     subplot(2,1,2), ylabel('I_{Na} (pA/pF)')
%                     subplot(2,1,2), xlabel('time (ms)')
%                     pause
                end
                % Sigmoid fit
                times = [2:2:30,40:10:100];
                P2_over_P1 = P2./P1;
                sig_params = [0,max(P2_over_P1),NaN,NaN];
                [recovery_params] = sigm_fit(times',P2_over_P1,sig_params);
                frecovery.f = @(recovery_params,times) recovery_params(1)+(recovery_params(2)-recovery_params(1))./(1+10.^((recovery_params(3)-times)*recovery_params(4)));
                frecovery.params = recovery_params;
                frecovery.times = times;
%                 
%                 figure
%                 plot(f1,times,P2_over_P1,'r*')
%                 disp(strcat('v_half_act',num2str(f1.a)))
    
                % Find overall peaks and assign outputs
                outs(1) = {P2_over_P1};
                outs(2) = {frecovery};
            catch
                disp(strcat(num2str(i), ':', num2str(min(Sweeps_T{i,:})),':', num2str(max(Sweeps_T{i,:})),':',num2str((i-1)*CL),':',num2str((i)*CL), ':', num2str(max(Sweeps_T{1,:})), ':',num2str((1)*CL)));
                outs(1) = {NaN};
                outs(2) = {NaN};
            end

    end
end



