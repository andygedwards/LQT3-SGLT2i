%     Cardiac model ToR-ORd
%     Copyright (C) 2019 Jakub Tomek. Contact: jakub.tomek.mff@gmail.com
% 
%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
% 
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with this program.  If not, see <https://www.gnu.org/licenses/>.


function [states,statenames] = get_TorORd_states_SGLT2i(p,p2)
%initial conditions for state variables

    % states = zeros(61);
    % statenames = cell(61);

    states(1)=-89.0154768721342; statenames{1} = 'v';
    states(2)=12.838260526981500; statenames{2} = 'na_i'; % intracellular sodium concentration
    states(3)=12.8386296068886; statenames{3} = 'nass';
    states(4)=142.460122044002; statenames{4} = 'ki';
    states(5)=142.460073757800; statenames{5} = 'kss';
    states(6)=7.44971662963012e-05; statenames{6} = 'ca_i'; % intracellular calcium concentration
    states(7)=6.38115248479545e-05; statenames{7} = 'cass'; 
    states(8)=1.83376662673169; statenames{8} = 'ca_nsr'; % network sarcoplasmic reticulum calcium concentration
    states(9)=1.83451041520486; statenames{9} = 'ca_jsr'; % junctional sarcoplasmi
    states(10)=0.000934977025106033; statenames{10} = 'a';
    states(11)=0.999626696605431; statenames{11} = 'iF';
    states(12)=0.999623652971323; statenames{12} = 'iS';
    states(13)=0.000476380566651530; statenames{13} = 'ap';
    states(14)=0.999626696659922; statenames{14} = 'iFp';
    states(15)=0.999626199062997; statenames{15} = 'iSp';
    states(16)=3.44090020293841e-37; statenames{16} = 'd';
    states(17)=0.999999993064605; statenames{17} = 'ff';
    states(18)=0.948443428743038; statenames{18} = 'fs';
    states(19)=0.999999993064610; statenames{19} = 'fcaf';
    states(20)=0.999933400688481; statenames{20} = 'fcas';
    states(21)=0.999981769973542; statenames{21} = 'jca';
    states(22)=0.000456804180120420; statenames{22} = 'nca';
    states(23)=0.000830893014440888; statenames{23} ='nca_i';
    states(24)=0.999999993064818; statenames{24} = 'ffp';
    states(25)=0.999999993064276; statenames{25} = 'fcafp';
    states(26)=0.232708882444918; statenames{26} = 'xs1';
    states(27)=0.000172120093619941; statenames{27} = 'xs2';
    states(28)=4.14953854790051e-24; statenames{28} = 'Jrel_np';
    states(29)=0.0129726050063671; statenames{29} = 'CaMKt';
    states(30)=0.998185994327463; statenames{30} = 'ikr_c0';
    states(31)=0.000836058850210933; statenames{31} = 'ikr_c1';
    states(32)=0.000685608512717355; statenames{32} = 'ikr_c2';
    states(33)=0.000282493081467249; statenames{33} = 'ikr_o';
    states(34)=9.84492151787658e-06; statenames{34} = 'ikr_i';
    states(35)=1.70514183624061e-22; statenames{35} = 'Jrel_p';

    v = states(strcmp(statenames,'v'));
    % INa chromosome 1
    A_Rates = Markov_Na(p,v);
    a = zeros(13,1);
    a(13) = 1;
    
    x = linsolve(A_Rates, a);
    
    states(36) = x(1); statenames{36} = 'A_IC3';
    states(37) = x(2); statenames{37} = 'A_IC2';
    states(38) = x(3); statenames{38} = 'A_IF';
    states(39) = x(4); statenames{39} = 'A_IM1';
    states(40) = x(5); statenames{40} = 'A_IM2';
    states(41) = x(6); statenames{41} = 'A_C3';
    states(42) = x(7); statenames{42} = 'A_C2';
    states(43) = x(8); statenames{43} = 'A_C1';
    states(44) = x(9); statenames{44} = 'A_O';
    states(45) = x(10); statenames{45} = 'A_LC3';
    states(46) = x(11); statenames{46} = 'A_LC2';
    states(47) = x(12); statenames{47} = 'A_LC1';
    states(48) = x(13); statenames{48} = 'A_LO';
       
    % INa chromosome 2
    B_Rates = Markov_Na(p2,v);
    b = zeros(13,1);
    b(13) = 1;
    
    x2 = linsolve(B_Rates, b);
    
    states(49) = x2(1); statenames{49} = 'B_IC3';
    states(50) = x2(2); statenames{50} = 'B_IC2';
    states(51) = x2(3); statenames{51} = 'B_IF';
    states(52) = x2(4); statenames{52} = 'B_IM1';
    states(53) = x2(5); statenames{53} = 'B_IM2';
    states(54) = x2(6); statenames{54} = 'B_C3';
    states(55) = x2(7); statenames{55} = 'B_C2';
    states(56) = x2(8); statenames{56} = 'B_C1';
    states(57) = x2(9); statenames{57} = 'B_O';
    states(58) = x2(10); statenames{58} = 'B_LC3';
    states(59) = x2(11); statenames{59} = 'B_LC2';
    states(60) = x2(12); statenames{60} = 'B_LC1';
    states(61) = x2(13); statenames{61} = 'B_LO';

    states = states';
end

function [Rates] = Markov_Na(p,v)
    a1 = p(2)/(p(3)*exp(-v/p(4))+p(5)*exp(-v/p(6)));
    a2 = p(7)/(p(8)*exp(-v/p(9))+p(10)*exp(-v/p(11)));
    a3 = p(12)/(p(13)*exp(-v/p(14))+p(15)*exp(-v/p(16)));
    b1 = p(17)*exp(-v/p(18));
    b2 = p(19)*exp(-(v+p(20))/p(21));
    b3 = p(22)*exp(-(v+p(23))/p(24));
    a4 = p(25)*exp(v/p(26));
    a5 = p(27)*exp(p(28)*(-v/p(29)));  %%% new formulation
    b5 = p(30)+p(31)*v;
    b4 = (a3*a4*a5)/(b3*b5);
    a6 = a4/p(32);
    b6 = a5/p(33);          
    a7 = a4/p(34);
    b7 = a5/p(35);
    a8 = p(36);
    b8 = p(37);
    
    Rates=[-(a1+a5) b1 0 0 0 b5 0 0 0 0 0 0 0;...
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
end
