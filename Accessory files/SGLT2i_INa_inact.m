function [INa_inact, v_half_inact, r2_inact, f_inact] = SGLT2i_INa_inact(parameters, parameter_names, states, state_names, rhs_model)

    % Na+ availability 
    v_init = -130;
    v_rest = (-130:10:0);
    v_pulse = 0;
    rest_length = 500;
    pulse_length = 300;
    cycle_length = rest_length+pulse_length;
    prepulse_length = 0;
    end_length = 0;
    num_pulses = length(v_rest);
    protocol = 'availability';
    options = odeset('MaxStep',1, 'RelTol',1e-5);
    
    v_clamp_amps(1:2:2*num_pulses) = v_rest; v_clamp_amps(2:2:num_pulses*2) = v_pulse;
    v_clamp_times(1:2:2*num_pulses) = rest_length:cycle_length:num_pulses*cycle_length; v_clamp_times(2:2:num_pulses*2) = cycle_length:cycle_length:num_pulses*cycle_length;
    R_clamp = 0.001; % (GOhm)
    
    init_tspan = [0,10000];
    [T_init, Y_init] = ode15s(rhs_model,init_tspan, states, options, parameters, v_init, init_tspan(end), R_clamp);
    
    tspan = [0,v_clamp_times(end)];
    [T, Y] = ode15s(rhs_model,tspan, Y_init(end,:), options, parameters, v_clamp_amps, v_clamp_times, R_clamp);

    try
        outs = SGLT2i_analyze_v_clamp(Y,T,parameters, state_names, cycle_length, prepulse_length, end_length, protocol);
        INa_inact = outs{1};
        v_half_inact = outs{2};
        r2_inact = outs{3};
        f_inact = outs{4};

    catch ME
        reason = {ME.identifier};
        disp(reason)
        INa_inact = NaN;
        v_half_inact = NaN;
        r2_inact = NaN;
        f_inact = NaN;
    end
end