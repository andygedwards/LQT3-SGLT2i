function [peak_INa_late, late_INa_amp, late_INa_AUC] = SGLT2i_INa_late(parameters, parameter_names, states, state_names, rhs_model)

    % Late INa
    v_init = -120;
    v_rest = -120;
    v_pulse = 0;
    rest_length = 1000;
    pulse_length = 300;
    cycle_length = rest_length+pulse_length;
    prepulse_length = 0;
    end_length = 0;
    num_pulses = length(v_rest);
    protocol = 'late';
    options = odeset('MaxStep',1, 'RelTol',1e-5);
    
    v_clamp_amps(1:2:2*num_pulses) = v_rest; v_clamp_amps(2:2:num_pulses*2) = v_pulse;
    v_clamp_times(1:2:2*num_pulses) = rest_length:cycle_length:num_pulses*cycle_length; v_clamp_times(2:2:num_pulses*2) = cycle_length:cycle_length:num_pulses*cycle_length;
    R_clamp = 0.001; % (GOhm)
    
    init_tspan = [0,10000];
    [T_init, Y_init] = ode15s(rhs_model, init_tspan, states, options, parameters, v_init, init_tspan(end), R_clamp);
    
    tspan = [0,v_clamp_times(end)];
    [T, Y] = ode15s(rhs_model, tspan, Y_init(end,:), options, parameters, v_clamp_amps, v_clamp_times, R_clamp);

    try
        outs = SGLT2i_analyze_v_clamp(Y, T, parameters, state_names, cycle_length, prepulse_length, end_length, protocol,rhs_model);
        peak_INa_late = outs{1};
        late_INa_amp = outs{2};
        late_INa_AUC = outs{3};
    catch ME
        reason = {ME.identifier};
        disp(reason)
        peak_INa_late = NaN;
        late_INa_amp = NaN;
        late_INa_AUC = NaN;
    end
end