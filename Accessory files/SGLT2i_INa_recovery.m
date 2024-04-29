function [P1_over_P2, fit] = SGLT2i_INa_recovery(parameters, parameter_names, states, state_names, rhs_model)
    
    % Na+ activation
    v_init = -80;
    v_rest = -80;
    v_pulse = 0;
    rest_length = 2000;
    pulse_length = 20;
    interpulse_length = [2:2:30,40:10:100];
    cycle_length = rest_length+2*pulse_length;
    prepulse_length = 0;
    end_length = 0;
    num_pulses = length(interpulse_length);
    protocol = 'recovery';
    options = odeset('MaxStep',1, 'RelTol',1e-5);

    v_clamp_amps(1:2:4*num_pulses) = v_rest; v_clamp_amps(2:2:num_pulses*4) = v_pulse;
    for i = 1:4:num_pulses*4
        if i == 1
            v_clamp_times(i) = cycle_length-(interpulse_length(i)+2*pulse_length); 
            v_clamp_times(i+1) = cycle_length-(interpulse_length(i)+pulse_length); 
            v_clamp_times(i+2) = cycle_length-pulse_length; 
            v_clamp_times(i+3) = cycle_length; 
        else
            v_clamp_times(i) = ((i-1)/4+1)*cycle_length-(interpulse_length(((i-1)/4+1))+2*pulse_length); 
            v_clamp_times(i+1) = ((i-1)/4+1)*cycle_length-(interpulse_length(((i-1)/4+1))+pulse_length); 
            v_clamp_times(i+2) = ((i-1)/4+1)*cycle_length-pulse_length; 
            v_clamp_times(i+3) = ((i-1)/4+1)*cycle_length; 
        end
    end
    R_clamp = 0.005; % (GOhm)
    
    init_tspan = [0,10000];
    [T_init, Y_init] = ode15s(rhs_model,init_tspan, states, options, parameters, v_init, init_tspan(end), R_clamp);

    tspan = [0,v_clamp_times(end)];
    [T, Y] = ode15s(rhs_model,tspan, Y_init(end,:), options, parameters, v_clamp_amps, v_clamp_times, R_clamp);

    try
        outs = SGLT2i_analyze_v_clamp(Y,T,parameters,state_names, cycle_length, prepulse_length, end_length, protocol, rhs_model);
        P1_over_P2 = outs{1};
        fit = outs{2};
    catch ME
        reason = {ME.identifier};
        disp(reason)
        P1_over_P2 = NaN;
        fit = NaN;
    end
end



