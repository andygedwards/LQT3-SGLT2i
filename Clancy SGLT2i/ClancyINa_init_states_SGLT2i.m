function [states, varargout] = ClancyINa_init_states_SGLT2i(V,p)
  % % Default state values for ODE model: Riz2014
  % % -------------------------------------------
  % %
  % % states = Riz2014_init_states();
  % % [states, states_names] = Riz2014_init_states();

  % --- Default initial state values --- 
  states = zeros(14, 1);

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
        1 1 1 1 1 1 1 1 1 1 1 1 1];

  b = zeros(13,1);
  b(13) = 1;

  x = linsolve(A, b);

  states(1) = x(1); % IC3;
  states(2) = x(2); % IC2;
  states(3) = x(3); % IF;
  states(4) = x(4); % IM1;
  states(5) = x(5); % IM2;
  states(6) = x(6); % C3;
  states(7) = x(7); % C2;
  states(8) = x(8); % C1;
  states(9) = x(9); % O;
  states(10) = x(10); % LC3;
  states(11) = x(11); % LC2;
  states(12) = x(12); % LC1;
  states(13) = x(13); % LO;
  states(14) = V; % membrane potential;

  if nargout == 2

    % --- State names --- 
    state_names = cell(13, 1);

    state_names{1} = 'IC3';
    state_names{2} = 'IC2';
    state_names{3} = 'IF';
    state_names{4} = 'IM1';
    state_names{5} = 'IM2';
    state_names{6} = 'C3';
    state_names{7} = 'C2';
    state_names{8} = 'C1';
    state_names{9} = 'O';
    state_names{10} = 'LC3';
    state_names{11} = 'LC2';
    state_names{12} = 'LC1';
    state_names{13} = 'LO';
    state_names{14} = 'V';

    varargout(1) = {state_names};
  end
end