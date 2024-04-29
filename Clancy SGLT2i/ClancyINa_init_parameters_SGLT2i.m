function [parameters, varargout] = ClancyINa_init_parameters_SGLT2i(type)
  % % Default parameter values for ODE model: Riz2014
  % % -----------------------------------------------
  % %
  % % parameters = ClancyINa_init_parameters();
  % % [parameters, parameters_names] = ClancyINa_init_parameter();

  if nargout < 1 || nargout > 2
    error('Expected 1-2 output arguments.');
  end

  % --- Default parameters values --- 
  parameters = zeros(42, 1);

  % --- Conductance ---
  parameters(1) = 23.5; % g_Na (ms/uF);

  % --- alpha1 ---
  parameters(2) = 3.802; % a1_P1;
  parameters(3) = 0.1027; % a1_P2;
  if strcmp(type,'WT')
      parameters(4) = 12.83; % a1_P3; 
  elseif strcmp(type,'delKPQ')
      parameters(4) = 11.62; 
  elseif strcmp(type,'R225Q')
      parameters(4) = 9.62;
  elseif strcmp(type,'delKPQ_empa')
      parameters(4) = 10.88;
  elseif strcmp(type,'R225Q_empa')
      parameters(4) = 28.33;
  end
  if strcmp(type,'WT')
      parameters(5) = 0.1433; % a1_P4;  
  elseif strcmp(type,'delKPQ')
      parameters(5) = 0.1450; 
  elseif strcmp(type,'R225Q')
      parameters(5) = 0.1428;
  elseif strcmp(type,'delKPQ_empa')
      parameters(5) = 0.1238;
  elseif strcmp(type,'R225Q_empa')
      parameters(5) = 0.3058;
  end
  if strcmp(type,'WT')
      parameters(6) = 179.3; % a1_P5;
  elseif strcmp(type,'delKPQ')
      parameters(6) = 182.1; 
  elseif strcmp(type,'R225Q')
      parameters(6) = 186.2;
  elseif strcmp(type,'delKPQ_empa')
      parameters(6) = 248.9;
  elseif strcmp(type,'R225Q_empa')
      parameters(6) = 15.63;
  end

  % --- alpha2 ---
  parameters(7) = 3.802; % a2_P1;
  parameters(8) = 0.1027; % a2_P2;
  if strcmp(type,'WT')
      parameters(9) = 18.75; % a2_P3;
  elseif strcmp(type,'delKPQ')
      parameters(9) = 17.23; 
  elseif strcmp(type,'R225Q')
      parameters(9) = 10.37;
  elseif strcmp(type,'delKPQ_empa')
      parameters(9) = 17.46;
  elseif strcmp(type,'R225Q_empa')
      parameters(9) = 19.47;
  end
  if strcmp(type,'WT')
      parameters(10) = 0.2727; % a2_P4;  
  elseif strcmp(type,'delKPQ')
      parameters(10) = 0.2702; 
  elseif strcmp(type,'R225Q')
      parameters(10) = 0.3090;
  elseif strcmp(type,'delKPQ_empa')
      parameters(10) = 0.2633;
  elseif strcmp(type,'R225Q_empa')
      parameters(10) = 0.0;
  end
  if strcmp(type,'WT')
      parameters(11) = 90.26; % a2_P5;  
  elseif strcmp(type,'delKPQ')
      parameters(11) = 88.12; % a2_P5;   
  elseif strcmp(type,'R225Q')
      parameters(11) = 79.89;
  elseif strcmp(type,'delKPQ_empa')
      parameters(11) = 75.19;
  elseif strcmp(type,'R225Q_empa')
      parameters(11) = 1;
  end

  % --- alpha3 ---
  parameters(12) = 3.802; % a3_P1;
  parameters(13) = 0.1027; % a3_P2;
  if strcmp(type,'WT')
      parameters(14) = 35.51; % a3_P3; 
  elseif strcmp(type,'delKPQ')
      parameters(14) = 35.00;   
  elseif strcmp(type,'R225Q')
      parameters(14) = 36.72;
  elseif strcmp(type,'delKPQ_empa')
      parameters(14) = 30.29;
  elseif strcmp(type,'R225Q_empa')
      parameters(14) = 10.81;
  end
  if strcmp(type,'WT')
      parameters(15) = 0.2106; % a3_P4;
  elseif strcmp(type,'delKPQ')
      parameters(15) = 0.2499; 
  elseif strcmp(type,'R225Q')
      parameters(15) = 0.2410;
  elseif strcmp(type,'delKPQ_empa')
      parameters(15) = 0.2172;
  elseif strcmp(type,'R225Q_empa')
      parameters(15) = 0.4673;
  end
  if strcmp(type,'WT')
      parameters(16) = 35.09; % a3_P5;
  elseif strcmp(type,'delKPQ')
      parameters(16) = 33.75;    
  elseif strcmp(type,'R225Q')
      parameters(16) = 29.73;
  elseif strcmp(type,'delKPQ_empa')
      parameters(16) = 27.87;
  elseif strcmp(type,'R225Q_empa')
      parameters(16) = 13.17;
  end

  % --- beta1 ---
  parameters(17) = 0.1917; % b1_P1;
  parameters(18) = 20.3; % b1_P2;

  % --- beta2 ---
  parameters(19) = 0.20; % b2_P1;
  parameters(20) = -5; % b2_P2;
  parameters(21) = 20.3; % b2_P3;

  % --- beta3 ---
  parameters(22) = 0.22; % b3_P1;
  parameters(23) = -10; % b3_P2;
  parameters(24) = 20.3; % b3_P3;

  % --- alpha4 ---
  parameters(25) = 9.178; % a4_P1;
  parameters(26) = 29.68; % a4_P2;

  % --- alpha5 ---
  if strcmp(type,'WT')
      parameters(27) = 1.825e-04; % a5_P1;
  elseif strcmp(type,'delKPQ')
      parameters(27) = 2.231e-04; %   
  elseif strcmp(type,'R225Q')
      parameters(27) = 2.389e-04;
  elseif strcmp(type,'delKPQ_empa')
      parameters(27) = 3.234e-04;
  elseif strcmp(type,'R225Q_empa')
      parameters(27) = 8.580e-06;
  end
  if strcmp(type,'WT')
      parameters(28) = 0.3764; % a5_P2;
  elseif strcmp(type,'delKPQ')
      parameters(28) = 0.3744;  
  elseif strcmp(type,'R225Q')
      parameters(28) = 0.3984;
  elseif strcmp(type,'delKPQ_empa')
      parameters(28) = 0.3799;
  elseif strcmp(type,'R225Q_empa')
      parameters(28) = 0.4990;
  end
  if strcmp(type,'WT')
      parameters(29) = 5.442; %  a5_P3;
  elseif strcmp(type,'delKPQ')
      parameters(29) = 5.940;  
  elseif strcmp(type,'R225Q')
      parameters(29) = 5.829;
  elseif strcmp(type,'delKPQ_empa')
      parameters(29) = 6.251;
  elseif strcmp(type,'R225Q_empa')
      parameters(29) = 4.863;
  end

  % --- beta5 ---
  if strcmp(type,'WT')
      parameters(30) = 0.0373; % b5_P1; 
  elseif strcmp(type,'delKPQ')
      parameters(30) = 0.0397;  
  elseif strcmp(type,'R225Q')
      parameters(30) = 0.0696;
  elseif strcmp(type,'delKPQ_empa')
      parameters(30) = 0.0599;
  elseif strcmp(type,'R225Q_empa')
      parameters(30) = 0.377;
  end

  if strcmp(type,'R225Q_empa')
      parameters(31) = 4.19e-05; % b5_P2;
  else
      parameters(31) = 2.0e-05; 
  end

  % --- alpha6 ---
  if strcmp(type,'WT')
      parameters(32) = 24.44; % a6_P1;
  elseif strcmp(type,'delKPQ')
      parameters(32) = 24.75; 
  elseif strcmp(type,'R225Q')
      parameters(32) = 23.69;
  elseif strcmp(type,'delKPQ_empa')
      parameters(32) = 20.02;
  elseif strcmp(type,'R225Q_empa')
      parameters(32) = 22.12;
  end

  % --- beta6 ---
  if strcmp(type,'WT')
      parameters(33) = 0.5033; % b6_P1;
  elseif strcmp(type,'delKPQ')
      parameters(33) = 0.5479;  
  elseif strcmp(type,'R225Q')
      parameters(33) = 0.4756;
  elseif strcmp(type,'delKPQ_empa')
      parameters(33) = 0.5042;
  elseif strcmp(type,'R225Q_empa')
      parameters(33) = 0.3531;
  end

  % --- alpha7 ---
  if strcmp(type,'WT')
      parameters(34) = 2050; % a7_P1;
  elseif strcmp(type,'delKPQ')
      parameters(34) = 2377;
  elseif strcmp(type,'R225Q')
      parameters(34) = 2465;
  elseif strcmp(type,'delKPQ_empa')
      parameters(34) = 1830;
  elseif strcmp(type,'R225Q_empa')
      parameters(34) = 225.7;
  end
  
  % --- beta7 ---
  if strcmp(type,'WT')
      parameters(35) = 0.2130; % b7_P1;
  elseif strcmp(type,'delKPQ')
      parameters(35) = 0.2086; %  
  elseif strcmp(type,'R225Q')
      parameters(35) = 0.2110;
  elseif strcmp(type,'delKPQ_empa')
      parameters(35) = 0.2289;
  elseif strcmp(type,'R225Q_empa')
      parameters(35) = 0.3038;
  end

  % --- alpha8 ---
  if strcmp(type,'WT')
      parameters(36) = 2.090e-05; % a8_P1;
  elseif strcmp(type,'delKPQ')
      parameters(36) = 2.471e-05; 
  elseif strcmp(type,'R225Q')
      parameters(36) = 1.658e-05;
  elseif strcmp(type,'delKPQ_empa')
      parameters(36) = 2.290e-05;
  elseif strcmp(type,'R225Q_empa')
      parameters(36) = 2.481e-05;
  end

  % --- beta8 ---
  if strcmp(type,'WT')
      parameters(37) = 2.900e-03; % b8_P1;
  elseif strcmp(type,'delKPQ')
      parameters(37) = 1.056e-03;
  elseif strcmp(type,'R225Q')
      parameters(37) = 1.271e-03;
  elseif strcmp(type,'delKPQ_empa')
      parameters(37) = 1.700e-03;
  elseif strcmp(type,'R225Q_empa')
      parameters(37) = 2.980e-03;
  end

  % --- Environment ------
 parameters(38) = 8.314; % R
 parameters(39) = 295; % T
 parameters(40) = 96.485; % F
 parameters(41) = 140; % Nao
 parameters(42) = 5; % Nai

  if nargout == 2

    % --- Parameter names --- 
    parameter_names = cell(41, 1);

    % --- g_Na ---
    parameter_names{1} = 'g_Na';
    
    % --- alpha1 ---
    parameter_names{2} = 'a1_P1';
    parameter_names{3} = 'a1_P2';
    parameter_names{4} = 'a1_P3';
    parameter_names{5} = 'a1_P4';
    parameter_names{6} = 'a1_P5';

    % --- alpha2 ---
    parameter_names{7} = 'a2_P1';
    parameter_names{8} = 'a2_P2';
    parameter_names{9} = 'a2_P3';
    parameter_names{10} = 'a2_P4';
    parameter_names{11} = 'a2_P5';

    % --- alpha3 ---
    parameter_names{12} = 'a3_P1';
    parameter_names{13} = 'a3_P2';
    parameter_names{14} = 'a3_P3';
    parameter_names{15} = 'a3_P4';
    parameter_names{16} = 'a3_P5';

    % --- beta1 ---
    parameter_names{17} = 'b1_P1';
    parameter_names{18} = 'b1_P2';

    % --- beta2 ---
    parameter_names{19} = 'b2_P1';
    parameter_names{20} = 'b2_P2';
    parameter_names{21} = 'b2_P3';

    % --- beta3 ---
    parameter_names{22} = 'b3_P1';
    parameter_names{23} = 'b3_P2';
    parameter_names{24} = 'b3_P3';

    % --- alpha4 ---
    parameter_names{25} = 'a4_P1';
    parameter_names{26} = 'a4_P2';

    % --- alpha5 ---
    parameter_names{27} = 'a5_P1';
    parameter_names{28} = 'a5_P2';
    parameter_names{29} = 'a5_P3';

    % --- beta5 ---
    parameter_names{30} = 'b5_P1';
    parameter_names{31} = 'b6_P2';

    % --- alpha6 ---
    parameter_names{32} = 'a6_P1';

    % --- beta6 ---
    parameter_names{33} = 'b6_P1';

    % --- alpha7 ---
    parameter_names{34} = 'a7_P1';
    
    % --- beta7 ---
    parameter_names{35} = 'b7_P1';

    % --- alpha8 ---
    parameter_names{36} = 'a8_P1';
    
    % --- beta8 ---
    parameter_names{37} = 'b8_P1';

    % --- Environment ---
    parameter_names{38} = 'R';
    parameter_names{39} = 'T';
    parameter_names{40} = 'F';
    parameter_names{41} = 'Nao';
    parameter_names{42} = 'Nai';

    varargout(1) = {parameter_names};
  end
end