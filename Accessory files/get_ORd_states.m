function [states, statenames] = get_ORd_states(p)
    %initial conditions for state variables
    states = zeros(45,1);
    statenames = cell(45,1);
    
    states(1)=-87; statenames{1} = 'V';
    states(2)=7; statenames{2} = 'na_i'; % intracellular sodium concentration
    states(3)=145; statenames{3} = 'nass';
    states(4)=145; statenames{4} = 'ki';
    states(5)=145; statenames{5} = 'kss';
    states(6)=1.0e-4; statenames{6} = 'ca_i'; % intracellular calcium concentration
    states(7)=1.0e-4; statenames{7} = 'cass'; 
    states(8)=1.0; statenames{8} = 'ca_nsr'; % network sarcoplasmic reticulum calcium concentration
    states(9)=1.0; statenames{9} = 'ca_jsr'; % junctional sarcoplasmic reticulum calcium concentration
    states(10)=0; statenames{10} = 'a';
    states(11)=1; statenames{11} = 'iF';
    states(12)=1; statenames{12} = 'iS';
    states(13)=0; statenames{13} = 'ap';
    states(14)=1; statenames{14} = 'iFp';
    states(15)=1; statenames{15} = 'iSp';
    states(16)=0; statenames{16} = 'd';
    states(17)=1; statenames{17} = 'ff';
    states(18)=1; statenames{18} = 'fs';
    states(19)=1; statenames{19} = 'fcaf';
    states(20)=1; statenames{20} = 'fcas';
    states(21)=1; statenames{21} = 'jca';
    states(22)=0; statenames{22} = 'nca';
    states(23)=1; statenames{23} = 'ffp';
    states(24)=1; statenames{24} = 'fcafp';
    states(25)=0; statenames{25} = 'xrf';
    states(26)=0; statenames{26} = 'xrs';
    states(27)=0; statenames{27} = 'xs1';
    states(28)=0; statenames{28} = 'xs2';
    states(29)=1; statenames{29} = 'xk1';
    states(30)=0; statenames{30} = 'Jrelnp';
    states(31)=0; statenames{31} = 'Jrelp';
    states(32)=0; statenames{32} = 'CaMKt';
    
    V = states(strcmp(statenames,'V'));
    % Na+ channel Markov rates
    a11 = p(2)/(p(3)*exp(-V/p(4))+p(5)*exp(-V/p(6)));
    a12 = p(7)/(p(8)*exp(-V/p(9))+p(10)*exp(-V/p(11)));
    a13 = p(12)/(p(13)*exp(-V/p(14))+p(15)*exp(-V/p(16)));
    b11 = p(17)*exp(-V/p(18));
    b12 = p(19)*exp(-(V+p(20))/p(21));
    b13 = p(22)*exp(-(V+p(23))/p(24));
    a2 = p(25)*exp(V/p(26));
    a3 = p(27)*exp(p(28)*(-V/p(29)));  %%% new formulation
    b3 = p(30)+p(31)*V;
    b2 = (a13*a2*a3)/(b13*b3);
    a4 = a2/p(32);
    b4 = a3/p(33);          % b4, a5 and b5 are voltage dependent in Grandi model 
    a5 = a2/p(34);
    b5 = a3/p(35);
    a6 = p(36);
    b6 = p(37);
    
    A=[-(a11+a3) b11 0 0 0 b3 0 0 0 0 0 0 0;...
        a11 -(b11+a3+a12) b12 0 0 0 b3 0 0 0 0 0 0;...
            0 a12 -(b12+b2+a3+a4) b4 0 0 0 b3 a2 0 0 0 0;...
            0 0 a4 -(b4+a5) b5 0 0 0 0 0 0 0 0; ...
            0 0 0 a5 -b5 0 0 0 0 0 0 0 0;...
            a3 0 0 0 0 -(b3+a11+a6) b11 0 0 b6 0 0 0; ...
            0 a3 0 0 0 a11 -(b11+a6+a12+b3) b12 0 0 b6 0 0;...
            0 0 a3 0 0 0 a12 -(b12+a6+a13+b3) b13 0 0 b6 0; ...
            0 0 b2 0 0 0 0 a13 -(a2+b13+a6) 0 0 0 b6;...
            0 0 0 0 0 a6 0 0 0 -(a11+b6) b11 0 0; ...
            0 0 0 0 0 0 a6 0 0 a11 -(b6+b11+a12) b12 0;...
            0 0 0 0 0 0 0 a6 0 0 a12 -(b6+b12+a13) b13; ...
            1 1 1 1 1 1 1 1 1 1 1 1 1];
    
    b = zeros(13,1);
    b(13) = 1;
    
    x = linsolve(A, b);
    
    states(33) = x(1); statenames{33} = 'IC3';
    states(34) = x(2); statenames{34} = 'IC2';
    states(35) = x(3); statenames{35} = 'IF';
    states(36) = x(4); statenames{36} = 'IM1';
    states(37) = x(5); statenames{37} = 'IM2';
    states(38) = x(6); statenames{38} = 'C3';
    states(39) = x(7); statenames{39} = 'C2';
    states(40) = x(8); statenames{40} = 'C1';
    states(41) = x(9); statenames{41} = 'O';
    states(42) = x(10); statenames{42} = 'LC3';
    states(43) = x(11); statenames{43} = 'LC2';
    states(44) = x(12); statenames{44} = 'LC1';
    states(45) = x(13); statenames{45} = 'LO';
end