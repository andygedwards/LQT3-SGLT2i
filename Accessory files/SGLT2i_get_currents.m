function [I_Na] = SGLT2i_get_currents(time, values, parameters, rhs_model)
% Extraction of time course of I_Na

    I_Na = zeros(size(time));

    for i= 1:size(values,1)
        [~, data] = rhs_model(time(i), values(i,:)', parameters);
        I_Na(i) = data(1);
    end
end