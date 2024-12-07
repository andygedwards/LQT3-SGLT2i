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
      parameters(4) = 12.07; 
  elseif strcmp(type,'R225Q')
      parameters(4) = 9.66;
  elseif strcmp(type,'delK1500')
      parameters(4) = 11.17;
  elseif strcmp(type,'WT_empa')
      parameters(4) = 13.07;
  elseif strcmp(type,'delKPQ_empa')
      parameters(4) = 10.32;
  elseif strcmp(type,'R225Q_empa')
      parameters(4) = 28.80;
  elseif strcmp(type,'delK1500_empa')
      parameters(4) = 9.49;
  end
  if strcmp(type,'WT')
      parameters(5) = 0.1433; % a1_P4;  
  elseif strcmp(type,'delKPQ')
      parameters(5) = 0.1419; 
  elseif strcmp(type,'R225Q')
      parameters(5) = 0.1556;
  elseif strcmp(type,'delK1500')
      parameters(5) = 0.1535;
  elseif strcmp(type,'WT_empa')
      parameters(5) = 0.1379;
  elseif strcmp(type,'delKPQ_empa')
      parameters(5) = 0.1323;
  elseif strcmp(type,'R225Q_empa')
      parameters(5) = 0.3132;
  elseif strcmp(type,'delK1500_empa')
      parameters(5) = 0.1095;
  end
  if strcmp(type,'WT')
      parameters(6) = 179.3; % a1_P5;
  elseif strcmp(type,'delKPQ')
      parameters(6) = 165.4; 
  elseif strcmp(type,'R225Q')
      parameters(6) = 164.2;
  elseif strcmp(type,'delK1500')
      parameters(6) = 326.9;
  elseif strcmp(type,'WT_empa')
      parameters(6) = 166.2;
  elseif strcmp(type,'delKPQ_empa')
      parameters(6) = 208.8;
  elseif strcmp(type,'R225Q_empa')
      parameters(6) = 14.76;
  elseif strcmp(type,'delK1500_empa')
      parameters(6) = 253.3;
  end

  % --- alpha2 ---
  parameters(7) = 3.802; % a2_P1;
  parameters(8) = 0.1027; % a2_P2;
  if strcmp(type,'WT')
      parameters(9) = 18.75; % a2_P3;
  elseif strcmp(type,'delKPQ')
      parameters(9) = 17.49; 
  elseif strcmp(type,'R225Q')
      parameters(9) = 9.78;
  elseif strcmp(type,'delK1500')
      parameters(9) = 12.66;
  elseif strcmp(type,'WT_empa')
      parameters(9) = 19.75;
  elseif strcmp(type,'delKPQ_empa')
      parameters(9) = 17.97;
  elseif strcmp(type,'R225Q_empa')
      parameters(9) = 20.59;
  elseif strcmp(type,'delK1500_empa')
      parameters(9) = 11.65;
  end
  if strcmp(type,'WT')
      parameters(10) = 0.2727; % a2_P4;  
  elseif strcmp(type,'delKPQ')
      parameters(10) = 0.2905; 
  elseif strcmp(type,'R225Q')
      parameters(10) = 0.3323;
  elseif strcmp(type,'delK1500')
      parameters(10) = 0.2066;
  elseif strcmp(type,'WT_empa')
      parameters(10) = 0.2767;
  elseif strcmp(type,'delKPQ_empa')
      parameters(10) = 0.3323;
  elseif strcmp(type,'R225Q_empa')
      parameters(10) = 0.0;
  elseif strcmp(type,'delK1500_empa')
      parameters(10) = 0.2941;
  end
  if strcmp(type,'WT')
      parameters(11) = 90.26; % a2_P5;  
  elseif strcmp(type,'delKPQ')
      parameters(11) = 95.37; % a2_P5;   
  elseif strcmp(type,'R225Q')
      parameters(11) = 107.0;  
  elseif strcmp(type,'delK1500')
      parameters(11) = 19.02;
  elseif strcmp(type,'WT_empa')
      parameters(11) = 92.30; 
  elseif strcmp(type,'delKPQ_empa')
      parameters(11) = 67.67;
  elseif strcmp(type,'R225Q_empa')
      parameters(11) = 1.09;
  elseif strcmp(type,'delK1500_empa')
      parameters(11) = 27.42;
  end

  % --- alpha3 ---
  parameters(12) = 3.802; % a3_P1;
  parameters(13) = 0.1027; % a3_P2;
  if strcmp(type,'WT')
      parameters(14) = 35.51; % a3_P3; 
  elseif strcmp(type,'delKPQ')
      parameters(14) = 34.65;   
  elseif strcmp(type,'R225Q')
      parameters(14) = 37.21;
  elseif strcmp(type,'delK1500')
      parameters(14) = 39.79;
  elseif strcmp(type,'WT_empa')
      parameters(14) = 40.18;
  elseif strcmp(type,'delKPQ_empa')
      parameters(14) = 34.17;
  elseif strcmp(type,'R225Q_empa')
      parameters(14) = 11.55;
  elseif strcmp(type,'delK1500_empa')
      parameters(14) = 39.04;
  end
  if strcmp(type,'WT')
      parameters(15) = 0.2106; % a3_P4;
  elseif strcmp(type,'delKPQ')
      parameters(15) = 0.2192; 
  elseif strcmp(type,'R225Q')
      parameters(15) = 0.1422;
  elseif strcmp(type,'delK1500')
      parameters(15) = 0.1619;
  elseif strcmp(type,'WT_empa')
      parameters(15) = 0.2098;
  elseif strcmp(type,'delKPQ_empa')
      parameters(15) = 0.2128;
  elseif strcmp(type,'R225Q_empa')
      parameters(15) = 0.5102;
  elseif strcmp(type,'delK1500_empa')
      parameters(15) = 0.1563;  
  end
  if strcmp(type,'WT')
      parameters(16) = 35.09; % a3_P5;
  elseif strcmp(type,'delKPQ')
      parameters(16) = 33.95;    
  elseif strcmp(type,'R225Q')
      parameters(16) = 36.46;
  elseif strcmp(type,'delK1500')
      parameters(16) = 39.13;
  elseif strcmp(type,'WT_empa')
      parameters(16) = 29.34; 
  elseif strcmp(type,'delKPQ_empa')
      parameters(16) = 33.32;
  elseif strcmp(type,'R225Q_empa')
      parameters(16) = 12.70;
  elseif strcmp(type,'delK1500_empa')
      parameters(16) = 43.26;
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
      parameters(27) = 2.252e-04; %   
  elseif strcmp(type,'R225Q')
      parameters(27) = 2.243e-04;
  elseif strcmp(type,'delK1500')
      parameters(27) = 7.902e-06;
  elseif strcmp(type,'WT_empa')
      parameters(27) = 1.875e-04;
  elseif strcmp(type,'delKPQ_empa')
      parameters(27) = 2.897e-04;
  elseif strcmp(type,'R225Q_empa')
      parameters(27) = 8.468e-06;
  elseif strcmp(type,'delK1500_empa')
      parameters(27) = 6.543e-06;
  end
  if strcmp(type,'WT')
      parameters(28) = 0.3764; % a5_P2;
  elseif strcmp(type,'delKPQ')
      parameters(28) = 0.3598;  
  elseif strcmp(type,'R225Q')
      parameters(28) = 0.4048;
  elseif strcmp(type,'delK1500')
      parameters(28) = 0.4689;
  elseif strcmp(type,'WT_empa')
      parameters(28) = 0.3789; 
  elseif strcmp(type,'delKPQ_empa')
      parameters(28) = 0.3592;
  elseif strcmp(type,'R225Q_empa')
      parameters(28) = 0.4990;
  elseif strcmp(type,'delK1500_empa')
      parameters(28) = 0.5304;
  end
  if strcmp(type,'WT')
      parameters(29) = 5.442; %  a5_P3;
  elseif strcmp(type,'delKPQ')
      parameters(29) = 5.829;  
  elseif strcmp(type,'R225Q')
      parameters(29) = 6.248;
  elseif strcmp(type,'delK1500')
      parameters(29) = 4.339;
  elseif strcmp(type,'WT_empa')
      parameters(29) = 5.624;
  elseif strcmp(type,'delKPQ_empa')
      parameters(29) = 6.198;
  elseif strcmp(type,'R225Q_empa')
      parameters(29) = 4.863;
  elseif strcmp(type,'delK1500_empa')
      parameters(29) = 4.834;
  end

  % --- beta5 ---
  if strcmp(type,'WT')
      parameters(30) = 0.0373; % b5_P1; 
  elseif strcmp(type,'delKPQ')
      parameters(30) = 0.0366;  
  elseif strcmp(type,'R225Q')
      parameters(30) = 0.0479;
  elseif strcmp(type,'delK1500')
      parameters(30) = 0.4017;
  elseif strcmp(type,'WT_empa')
      parameters(30) = 0.0332;
  elseif strcmp(type,'delKPQ_empa')
      parameters(30) = 0.0385;
  elseif strcmp(type,'R225Q_empa')
      parameters(30) = 0.3700;
  elseif strcmp(type,'delK1500_empa')
      parameters(30) = 0.3407;
  end

  if strcmp(type,'WT')
      parameters(31) = 2.0e-05;  % b5_P2;
  elseif strcmp(type,'delKPQ')
      parameters(31) = 2.0e-05; 
  elseif strcmp(type,'R225Q')
      parameters(31) = 2.0e-05; 
  elseif strcmp(type,'delK1500')
      parameters(31) = 4.19e-05; 
  elseif strcmp(type,'WT_empa')
      parameters(31) = 2.0e-05;  
  elseif strcmp(type,'delKPQ_empa')
      parameters(31) = 2.0e-05; 
  elseif strcmp(type,'R225Q_empa')
      parameters(31) = 4.19e-05; 
  elseif strcmp(type,'delK1500_empa')
      parameters(31) = 4.19e-05; 
  end

  % --- alpha6 ---
  if strcmp(type,'WT')
      parameters(32) = 24.44; % a6_P1;
  elseif strcmp(type,'delKPQ')
      parameters(32) = 24.50; 
  elseif strcmp(type,'R225Q')
      parameters(32) = 26.00;
  elseif strcmp(type,'delK1500')
      parameters(32) = 18.73; 
  elseif strcmp(type,'WT_empa')
      parameters(32) = 23.57;
  elseif strcmp(type,'delKPQ_empa')
      parameters(32) = 20.28;
  elseif strcmp(type,'R225Q_empa')
      parameters(32) = 21.61;
  elseif strcmp(type,'delK1500_empa')
      parameters(32) = 17.29;
  end

  % --- beta6 ---
  if strcmp(type,'WT')
      parameters(33) = 0.5033; % b6_P1;
  elseif strcmp(type,'delKPQ')
      parameters(33) = 0.4782;  
  elseif strcmp(type,'R225Q')
      parameters(33) = 0.3581;
  elseif strcmp(type,'delK1500')
      parameters(33) = 0.3677;  
  elseif strcmp(type,'WT_empa')
      parameters(33) = 0.5178;
  elseif strcmp(type,'delKPQ_empa')
      parameters(33) = 0.4159;
  elseif strcmp(type,'R225Q_empa')
      parameters(33) = 0.3348;
  elseif strcmp(type,'delK1500_empa')
      parameters(33) = 0.3441;  
  end

  % --- alpha7 ---
  if strcmp(type,'WT')
      parameters(34) = 2050; % a7_P1;
  elseif strcmp(type,'delKPQ')
      parameters(34) = 2155;
  elseif strcmp(type,'R225Q')
      parameters(34) = 2239;
  elseif strcmp(type,'delK1500')
      parameters(34) = 234.1;
  elseif strcmp(type,'WT_empa')
      parameters(34) = 2338;
  elseif strcmp(type,'delKPQ_empa')
      parameters(34) = 2256;
  elseif strcmp(type,'R225Q_empa')
      parameters(34) = 212.6;
  elseif strcmp(type,'delK1500_empa')
      parameters(34) = 200.1;
  end
  
  % --- beta7 ---
  if strcmp(type,'WT')
      parameters(35) = 0.2130; % b7_P1;
  elseif strcmp(type,'delKPQ')
      parameters(35) = 0.2124;  
  elseif strcmp(type,'R225Q')
      parameters(35) = 0.2192;
  elseif strcmp(type,'delK1500')
      parameters(35) = 0.3007;  
  elseif strcmp(type,'WT_empa')
      parameters(35) = 0.2198;
  elseif strcmp(type,'delKPQ_empa')
      parameters(35) = 0.2030;
  elseif strcmp(type,'R225Q_empa')
      parameters(35) = 0.3004;
  elseif strcmp(type,'delK1500_empa')
      parameters(35) = 0.3640;  
  end

  % --- alpha8 ---
  if strcmp(type,'WT')
      parameters(36) = 1.538e-05; % a8_P1; % revised from 2.090e-05
  elseif strcmp(type,'delKPQ')
      parameters(36) = 1.988e-05; 
  elseif strcmp(type,'R225Q')
      parameters(36) = 2.152e-05;
  elseif strcmp(type,'delK1500')
      parameters(36) = 2.313e-05;
  elseif strcmp(type,'WT_empa')
      parameters(36) = 1.119e-05;
  elseif strcmp(type,'delKPQ_empa')
      parameters(36) = 1.287e-05;
  elseif strcmp(type,'R225Q_empa')
      parameters(36) = 2.098e-05;
  elseif strcmp(type,'delK1500_empa')
      parameters(36) = 1.113e-05;
  end

  % --- beta8 ---
  if strcmp(type,'WT')
      parameters(37) = 3.664e-03; % b8_P1; %revised from 2.900e-03;
  elseif strcmp(type,'delKPQ')
      parameters(37) = 1.565e-03;
  elseif strcmp(type,'R225Q')
      parameters(37) = 1.600e-03;
  elseif strcmp(type,'delK1500')
      parameters(37) = 3.800e-03;
  elseif strcmp(type,'WT_empa')
      parameters(37) = 4.500e-03;
  elseif strcmp(type,'delKPQ_empa')
      parameters(37) = 2.1e-03;
  elseif strcmp(type,'R225Q_empa')
      parameters(37) = 3.500e-03;
  elseif strcmp(type,'delK1500_empa')
      parameters(37) = 5.500e-03;
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