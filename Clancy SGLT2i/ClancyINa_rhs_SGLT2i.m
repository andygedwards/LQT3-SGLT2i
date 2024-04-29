function [values, current] = ClancyINa_rhs_SGLT2i(t, states, p, varargin)
  % Compute the right hand side of the Riz2014 ODE

  % check states
  if length(states)~=14
    error('Expected the states array to be of size 14.');
  end

  % check mandatory parameters
  if length(p)~=42
    error('Expected the parameters array to be of size 41.');
  end

  % check for voltage clamp parameters
  if ~isempty(varargin)
      if length(varargin) < 2
          error('Voltage clamp parameters must be passed as a 3-element cell array: varargin{1} = command step amplitude (mV); varargin{2} = step duration (ms); varargin{3} = Clamp resistance (GOhm).');
      else
        v_clamp_amps = varargin{1};
        v_clamp_times = varargin{2};
        R_clamp = varargin{3};
      end
  end

  % Calculate constants and assign V explicitly
  ENa = p(38)*p(39)/p(40)*log(p(41)/p(42)); 
  V = states(14);

  % Calculate INa
  I_Na = p(1)*(-ENa + V)*(states(9)+states(13));

  % Init return args
  values = zeros(14, 1);

  % Calculate Markov rates
  a1 = p(2)/(p(3)*exp(-V/p(4))+p(5)*exp(-V/p(6)));
  a2 = p(7)/(p(8)*exp(-V/p(9))+p(10)*exp(-V/p(11)));
  a3 = p(12)/(p(13)*exp(-V/p(14))+p(15)*exp(-V/p(16)));
  b1 = p(17)*exp(-V/p(18));
  b2 = p(19)*exp(-(V+p(20))/p(21));
  b3 = p(22)*exp(-(V+p(23))/p(24));
  a4 = p(25)*exp(V/p(26));
  a5 = p(27)*exp(p(28)*(-V/p(29)));  %%% new formulation
  b5 = p(30)+p(31)*V;
  b4 = (a3*a4*a5)/(b3*b5);
  a6 = a4/p(32);
  b6 = a5/p(33);          
  a7 = a4/p(34);
  b7 = a5/p(35);
  a8 = p(36);
  b8 = p(37);

  % Solve the state vector
  A=[-(a1+a5) b1 0 0 0 b5 0 0 0 0 0 0 0;...
    a1 -(b1+a5+a2) b2 0 0 0 b5 0 0 0 0 0 0;...
        0 a2 -(b2+b4+a5+a6) b6 0 0 0 b5 a4 0 0 0 0;...
        0 0 a6 -(b6+a7) b7 0 0 0 0 0 0 0 0; ...
        0 0 0 a7 -b7 0 0 0 0 0 0 0 0;...
        a5 0 0 0 0 -(b5+a1+a8) b1 0 0 b8 0 0 0; ...
        0 a5 0 0 0 a1 -(b1+a8+a2+b5) b2 0 0 b8 0 0;...
        0 0 a5 0 0 0 a2 -(b2+a8+a3+b5) b3 0 0 b8 0; ...
        0 0 b4 0 0 0 0 a3 -(a4+b3+a8) 0 0 0 b8;...
        0 0 0 0 0 a8 0 0 0 -(a1+b8) b1 0 0; ...
        0 0 0 0 0 0 a8 0 0 a1 -(b8+b1+a2) b2 0;...
        0 0 0 0 0 0 0 a8 0 0 a2 -(b8+b2+a3) b3; ...
        0 0 0 0 0 0 0 0 a8 0 0 a3 -(b8+b3)];

  b = A*states(1:13);

  values(1) = b(1); % IC3;
  values(2) = b(2); % IC2;
  values(3) = b(3); % IF;
  values(4) = b(4); % IM1;
  values(5) = b(5); % IM2;
  values(6) = b(6); % C3;
  values(7) = b(7); % C2;
  values(8) = b(8); % C1;
  values(9) = b(9); % O;
  values(10) = b(10); % LC3;
  values(11) = b(11); % LC2;
  values(12) = b(12); % LC1;
  values(13) = b(13); % LO;

    % Apply voltage clamp protocol
  if ~isempty(varargin)
      if t <= v_clamp_times(1)
          v_clamp_amp = v_clamp_amps(1);
          I_vclamp = (v_clamp_amp - V)/R_clamp;
          I_stim = 0;
      else 
          for i = 2:length(v_clamp_times)
               if and(t >= v_clamp_times(i-1),t <= v_clamp_times(i))
                    v_clamp_amp = v_clamp_amps(i);
                    I_vclamp = (v_clamp_amp - V)/R_clamp;
                    I_stim = 0;
                    break
               end
          end
      end
  else
      I_vclamp = 0;
      I_stim = 0;
  end

  % Expressions for the Membrane potential component
  I_tot = I_Na - I_stim - I_vclamp;
  values(14) = -I_tot;

  % Assign INa output
  current = I_Na;
end