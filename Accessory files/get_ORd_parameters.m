function [parameters, parameter_names] = get_ORd_parameters(type)
%initial conditions for state variables
parameters = zeros(70,1);
parameter_names = cell(70,1);

parameters(1)=1; parameter_names{1} = 'cell';  %endo = 0, epi = 1, M = 2
% Na+ channel parameters:
parameters(2) = 3.802; parameter_names{2} = 'a11_P1';
parameters(3) = 0.1027; parameter_names{3} = 'a11_P2';
if strcmp(type,'WT')
  parameters(4) = 12.83; % a11_P3; 17.0
elseif strcmp(type,'delKPQ')
  parameters(4) = 11.62; % a11_P3;
elseif strcmp(type,'R225Q')
  parameters(4) = 9.62;
elseif strcmp(type,'delKPQ_empa')
  parameters(4) = 10.88;
elseif strcmp(type,'R225Q_empa')
  parameters(4) = 28.33;
end
parameter_names{4} = 'a11_P3';
if strcmp(type,'WT')
  parameters(5) = 0.1433; % a11_P4;  0.20
elseif strcmp(type,'delKPQ')
  parameters(5) = 0.1450; % a11_P4;
elseif strcmp(type,'R225Q')
  parameters(5) = 0.1428;
elseif strcmp(type,'delKPQ_empa')
  parameters(5) = 0.1238;
elseif strcmp(type,'R225Q_empa')
  parameters(5) = 0.3058;
end
parameter_names{5} = 'a11_P4';
if strcmp(type,'WT')
  parameters(6) = 179.3; % a11_P5;   150
elseif strcmp(type,'delKPQ')
  parameters(6) = 182.1; % a11_P5;
elseif strcmp(type,'R225Q')
  parameters(6) = 186.2;
elseif strcmp(type,'delKPQ_empa')
  parameters(6) = 248.9;
elseif strcmp(type,'R225Q_empa')
  parameters(6) = 15.63;
end
parameter_names{6} = 'a11_P5';
% --- alpha12 ---
parameters(7) = 3.802; parameter_names{7} = 'a12_P1';
parameters(8) = 0.1027; parameter_names{8} = 'a12_P2';
if strcmp(type,'WT')
  parameters(9) = 18.75; % a12_P3;     15.0
elseif strcmp(type,'delKPQ')
  parameters(9) = 17.23; % a12_P3;
elseif strcmp(type,'R225Q')
  parameters(9) = 10.37;
elseif strcmp(type,'delKPQ_empa')
  parameters(9) = 17.46;
elseif strcmp(type,'R225Q_empa')
  parameters(9) = 19.47;
end
parameter_names{9} = 'a12_P3';
if strcmp(type,'WT')
  parameters(10) = 0.2727; % a12_P4;   0.23
elseif strcmp(type,'delKPQ')
  parameters(10) = 0.2702; % a12_P4;
elseif strcmp(type,'R225Q')
  parameters(10) = 0.3090;
elseif strcmp(type,'delKPQ_empa')
  parameters(10) = 0.2633;
elseif strcmp(type,'R225Q_empa')
  parameters(10) = 0.0;
end
parameter_names{10} = 'a12_P4';
if strcmp(type,'WT')
  parameters(11) = 90.26; % a12_P5;    150
elseif strcmp(type,'delKPQ')
  parameters(11) = 88.12; % a12_P5;   
elseif strcmp(type,'R225Q')
  parameters(11) = 79.89;
elseif strcmp(type,'delKPQ_empa')
  parameters(11) = 75.19;
elseif strcmp(type,'R225Q_empa')
  parameters(11) = 14.10;
end
parameter_names{11} = 'a12_P5';
% --- alpha13 ---
parameters(12) = 3.802; parameter_names{12} = 'a13_P1';
parameters(13) = 0.1027; parameter_names{13} = 'a13_P2';
if strcmp(type,'WT')
  parameters(14) = 35.51; % a13_P3;   12.0
elseif strcmp(type,'delKPQ')
  parameters(14) = 35.00; % a13_P3;  
elseif strcmp(type,'R225Q')
  parameters(14) = 36.72;
elseif strcmp(type,'delKPQ_empa')
  parameters(14) = 30.29;
elseif strcmp(type,'R225Q_empa')
  parameters(14) = 10.81;
end
parameter_names{14} = 'a13_P3';
if strcmp(type,'WT')
  parameters(15) = 0.2106; % a13_P4;   0.25
elseif strcmp(type,'delKPQ')
  parameters(15) = 0.2499; % a13_P4;  
elseif strcmp(type,'R225Q')
  parameters(15) = 0.2410;
elseif strcmp(type,'delKPQ_empa')
  parameters(15) = 0.2172;
elseif strcmp(type,'R225Q_empa')
  parameters(15) = 0.4673;
end
parameter_names{15} = 'a13_P4';
if strcmp(type,'WT')
  parameters(16) = 35.09; % a13_P5;   150
elseif strcmp(type,'delKPQ')
  parameters(16) = 33.75; % a13_P5;   
elseif strcmp(type,'R225Q')
  parameters(16) = 29.73;
elseif strcmp(type,'delKPQ_empa')
  parameters(16) = 27.87;
elseif strcmp(type,'R225Q_empa')
  parameters(16) = 13.17;
end
parameter_names{16} = 'a13_P5';
% --- beta11 ---
parameters(17) = 0.1917; parameter_names{17} = 'b11_P1';
parameters(18) = 20.3; parameter_names{18} = 'b11_P2';

% --- beta12 ---
parameters(19) = 0.20; parameter_names{19} = 'b12_P1';
parameters(20) = -5; parameter_names{20} = 'b12_P2';
parameters(21) = 20.3; parameter_names{21} = 'b12_P3';

% --- beta13 ---
parameters(22) = 0.22; parameter_names{22} = 'b13_P1';
parameters(23) = -10; parameter_names{23} = 'b13_P2';
parameters(24) = 20.3; parameter_names{24} = 'b13_P3';

% --- alpha2 ---
parameters(25) = 9.178; parameter_names{25} = 'a2_P1';
parameters(26) = 29.68; parameter_names{26} = 'a2_P2';

% --- alpha3 ---
if strcmp(type,'WT')
  parameters(27) = 1.825e-04; % a3_P1; 8.0e-04
elseif strcmp(type,'delKPQ')
  parameters(27) = 2.231e-04; % a3_P1;  
elseif strcmp(type,'R225Q')
  parameters(27) = 2.389e-04;
elseif strcmp(type,'delKPQ_empa')
  parameters(27) = 3.234e-04;
elseif strcmp(type,'R225Q_empa')
  parameters(27) = 8.580e-06;
end
parameter_names{27} = 'a3_P1';
if strcmp(type,'WT')
  parameters(28) = 0.3764; % a3_P2;    0.25 
elseif strcmp(type,'delKPQ')
  parameters(28) = 0.3744; % a3_P2;  
elseif strcmp(type,'R225Q')
  parameters(28) = 0.3984;
elseif strcmp(type,'delKPQ_empa')
  parameters(28) = 0.3799;
elseif strcmp(type,'R225Q_empa')
  parameters(28) = 0.4990;
end
parameter_names{28} = 'a3_P2';
if strcmp(type,'WT')
  parameters(29) = 5.442; %  a3_P3; 6
elseif strcmp(type,'delKPQ')
  parameters(29) = 5.940; %  a3_P3;  
elseif strcmp(type,'R225Q')
  parameters(29) = 5.829;
elseif strcmp(type,'delKPQ_empa')
  parameters(29) = 6.251;
elseif strcmp(type,'R225Q_empa')
  parameters(29) = 4.863;
end
parameter_names{29} = 'a3_P3';

% --- beta3 ---
if strcmp(type,'WT')
  parameters(30) = 0.0373; % b3_P1;  0.0084
elseif strcmp(type,'delKPQ')
  parameters(30) = 0.0397; % b3_P1;  
elseif strcmp(type,'R225Q')
  parameters(30) = 0.0696;
elseif strcmp(type,'delKPQ_empa')
  parameters(30) = 0.0599;
elseif strcmp(type,'R225Q_empa')
  parameters(30) = 0.377;
end
parameter_names{30} = 'b3_P1';

if strcmp(type,'R225Q_empa')
  parameters(31) = 4.19e-05; % b3_P2;
else
  parameters(31) = 2.0e-05; % b3_P2;
end
parameter_names{31} = 'b3_P2';

% --- alpha4 ---
if strcmp(type,'WT')
  parameters(32) = 24.44; % a4_P1;  100
elseif strcmp(type,'delKPQ')
  parameters(32) = 24.75; % a4_P1;  
elseif strcmp(type,'R225Q')
  parameters(32) = 23.69;
elseif strcmp(type,'delKPQ_empa')
  parameters(32) = 20.02;
elseif strcmp(type,'R225Q_empa')
  parameters(32) = 22.12;
end
parameter_names{32} = 'a4_P1';

% --- beta4 ---
if strcmp(type,'WT')
  parameters(33) = 0.5033; % a4_P1; 1
elseif strcmp(type,'delKPQ')
  parameters(33) = 0.5479; % a4_P1;  
elseif strcmp(type,'R225Q')
  parameters(33) = 0.4756;
elseif strcmp(type,'delKPQ_empa')
  parameters(33) = 0.5042;
elseif strcmp(type,'R225Q_empa')
  parameters(33) = 0.3531;
end
parameter_names{33} = 'b4_P1';

% --- alpha5 ---
if strcmp(type,'WT')
  parameters(34) = 2050; % a5_P1; 9.5e04
elseif strcmp(type,'delKPQ')
  parameters(34) = 2377; % a5_P1; 
elseif strcmp(type,'R225Q')
  parameters(34) = 2465;
elseif strcmp(type,'delKPQ_empa')
  parameters(34) = 1830;
elseif strcmp(type,'R225Q_empa')
  parameters(34) = 225.7;
end
parameter_names{34} = 'a5_P1';

% --- beta5 ---
if strcmp(type,'WT')
  parameters(35) = 0.2130; % b5_P1;  50
elseif strcmp(type,'delKPQ')
  parameters(35) = 0.2086; % b5_P1;  
elseif strcmp(type,'R225Q')
  parameters(35) = 0.2110;
elseif strcmp(type,'delKPQ_empa')
  parameters(35) = 0.2289;
elseif strcmp(type,'R225Q_empa')
  parameters(35) = 0.3038;
end
parameter_names{35} = 'b5_P1';

% --- alpha6 ---
if strcmp(type,'WT')
  parameters(36) = 2.090e-05; % a6_P1;
elseif strcmp(type,'delKPQ')
  parameters(36) = 2.471e-05; % a6_P1;
elseif strcmp(type,'R225Q')
  parameters(36) = 1.658e-05;
elseif strcmp(type,'delKPQ_empa')
  parameters(36) = 2.290e-05;
elseif strcmp(type,'R225Q_empa')
  parameters(36) = 2.481e-05;
end
parameter_names{36} = 'a6_P1';

% --- beta6 ---
if strcmp(type,'WT')
  parameters(37) = 2.900e-03; % WT b6_P1;
elseif strcmp(type,'delKPQ')
  parameters(37) = 1.056e-03; % WT b6_P1;
elseif strcmp(type,'R225Q')
  parameters(37) = 1.271e-03;
elseif strcmp(type,'delKPQ_empa')
  parameters(37) = 1.700e-03;
elseif strcmp(type,'R225Q_empa')
  parameters(37) = 2.980e-03;
end
parameter_names{37} = 'b6_P1';

parameters(38)=8314.0; parameter_names{38} = 'R';
parameters(39)=310.0; parameter_names{39} = 'T';
parameters(40)=96485.0; parameter_names{40} = 'F';
parameters(41)=0.01; parameter_names{41} = 'L';
parameters(42)=0.0011; parameter_names{42} = 'rad';
parameters(43)=1000*pi()*parameters(42)*parameters(42)+parameters(41); parameter_names{43} = 'vcell';
parameters(44)=1000*pi()*parameters(42)*parameters(42)+2*pi()*parameters(42)*parameters(41); parameter_names{44} = 'Ageo';
parameters(45)=parameters(44)*2; parameter_names{45} = 'Acap';
parameters(46)=0.68*parameters(43); parameter_names{46} = 'vmyo';
parameters(47)=0.0552*parameters(43); parameter_names{47} = 'vnsr'; % network sarcoplasmic reticulum volume
parameters(48)=0.0048*parameters(43); parameter_names{48} = 'vjsr'; % junctional sarcoplasmic reticulum volume
parameters(49)=0.02*parameters(43); parameter_names{49} = 'vss';
parameters(50)=0.1908; parameter_names{50} = 'g_K1';
parameters(51)=0.046; parameter_names{51} = 'g_Kr';
parameters(52)=0.0034; parameter_names{52} = 'g_Ks';
parameters(53)=0.02; parameter_names{53} = 'g_to';
parameters(54)=0.00005; parameter_names{54} = 'g_CaL';
parameters(55)=2.5e-8; parameter_names{55} = 'g_bCa';
parameters(56)=75; parameter_names{56} = 'g_Na';
parameters(57)=0.0075; parameter_names{57} = 'g_NaL';
parameters(58)=30; parameter_names{58} = 'g_NaK';
parameters(59)=0.0008; parameter_names{59} = 'g_NaCa';
parameters(60)=0.0005; parameter_names{60} = 'g_pCa';
parameters(61)=0.004375; parameter_names{61} = 'J_SERCA_bar';
parameters(62)=1; parameter_names{62} = 'K_RyR';
parameters(63)=140.0; parameter_names{63} = 'Nao';
parameters(64)=1.8; parameter_names{64} = 'Cao';
parameters(65)=5.4; parameter_names{65} = 'Ko';
parameters(66)=1; parameter_names{66} = 'ODE';
parameters(67)=0; parameter_names{67} = 'Vclamp';
parameters(68)=0; parameter_names{68} = 'stim_start';
parameters(69)=0; parameter_names{69} = 'stim_amp';
parameters(70)=0; parameter_names{70} = 'stim_duration';