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
function output=TorORd_rhs_SGLT2i(t,X,flag_ode,cellType, ICaL_Multiplier, ...
    INa_Multiplier, Ito_Multiplier, INaL_Multiplier, IKr_Multiplier, IKs_Multiplier, IK1_Multiplier, IKb_Multiplier,INaCa_Multiplier,...
    INaK_Multiplier, INab_Multiplier, ICab_Multiplier, IpCa_Multiplier, ICaCl_Multiplier, IClb_Multiplier, Jrel_Multiplier,Jup_Multiplier, nao,cao,ko,ICaL_fractionSS,INaCa_fractionSS, stimAmp, stimDur,stimStart, vcParameters, apClamp, extraParams)

celltype=cellType; %endo = 0, epi = 1, mid = 2

%physical constants
R=8314.0;
T=310.0;
F=96485.0;

%cell geometry
L=0.01;
rad=0.0011;
vcell=1000*3.14*rad*rad*L;
Ageo=2*3.14*rad*rad+2*3.14*rad*L;
Acap=2*Ageo;
vmyo=0.68*vcell;
vnsr=0.0552*vcell;
vjsr=0.0048*vcell;
vss=0.02*vcell;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%give names to the state vector values
v=X(1);
nai=X(2);
nass=X(3);
ki=X(4);
kss=X(5);
cai=X(6);
cass=X(7);
cansr=X(8);
cajsr=X(9);
%% Original INa
% m=X(10);
% hp=X(11);
% h=X(12);
% j=X(13);
% jp=X(14);
% mL=X(15);
% hL=X(16);
% hLp=X(17);
%% Ito
a=X(10);
iF=X(11);
iS=X(12);
ap=X(13);
iFp=X(14);
iSp=X(15);
%% ical
d=X(16);
ff=X(17);
fs=X(18);
fcaf=X(19);
fcas=X(20);
jca=X(21);
nca=X(22);
nca_i=X(23);
ffp=X(24);
fcafp=X(25);
%% end ical
xs1=X(26);
xs2=X(27);
Jrel_np=X(28);
CaMKt=X(29);
%% new MM ICaL states
ikr_c0 = X(30);
ikr_c1 = X(31);
ikr_c2 = X(32);
ikr_o = X(33);
ikr_i = X(34);
Jrel_p=X(35);
%% Clancy INa 
A_IC3 = X(36);
A_IC2 = X(37);
A_IF = X(38);
A_IM1 = X(39);
A_IM2 = X(40);
A_C3 = X(41);
A_C2 = X(42);
A_C1 = X(43);
A_O = X(44);
A_LC3 = X(45);
A_LC2 = X(46);
A_LC1 = X(47);
A_LO = X(48);
B_IC3 = X(49);
B_IC2 = X(50);
B_IF = X(51);
B_IM1 = X(52);
B_IM2 = X(53);
B_C3 = X(54);
B_C2 = X(55);
B_C1 = X(56);
B_O = X(57);
B_LC3 = X(58);
B_LC2 = X(59);
B_LC1 = X(60);
B_LO = X(61);

cli = 24;   % Intracellular Cl  [mM]
clo = 150;  % Extracellular Cl  [mM]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%CaMK constants
KmCaMK=0.15;

aCaMK=0.05;
bCaMK=0.00068;
CaMKo=0.05;
KmCaM=0.0015;
%update CaMK
CaMKb=CaMKo*(1.0-CaMKt)/(1.0+KmCaM/cass);
CaMKa=CaMKb+CaMKt;
dCaMKt=aCaMK*CaMKb*(CaMKb+CaMKt)-bCaMK*CaMKt;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%reversal potentials
ENa=(R*T/F)*log(nao/nai);
EK=(R*T/F)*log(ko/ki);
PKNa=0.01833;
EKs=(R*T/F)*log((ko+PKNa*nao)/(ki+PKNa*nai));

%convenient shorthand calculations
vffrt=v*F*F/(R*T);
vfrt=v*F/(R*T);
frt = F/(R*T);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fINap=(1.0/(1.0+KmCaMK/CaMKa));
fINaLp=(1.0/(1.0+KmCaMK/CaMKa));
fItop=(1.0/(1.0+KmCaMK/CaMKa));
fICaLp=(1.0/(1.0+KmCaMK/CaMKa));

%% SGLT2i INa

zygosity = extraParams{1};
genotype1 = extraParams{2};
genotype2 = extraParams{3};
GNa = 11.7802; if(length(extraParams)>3), GNa = extraParams{4}; end
[A_INaf,A_INaL,A_dIC3,A_dIC2,A_dIF,A_dIM1,A_dIM2,A_dC3,A_dC2,A_dC1,A_dO,A_dLC3,A_dLC2,A_dLC1,A_dLO] = getINa_SGLT2i(v,genotype1,A_IC3,A_IC2,A_IF,A_IM1,A_IM2,A_C3,A_C2,A_C1,A_O,A_LC3,A_LC2,A_LC1,A_LO,ENa,INa_Multiplier,GNa,zygosity);
[B_INaf,B_INaL,B_dIC3,B_dIC2,B_dIF,B_dIM1,B_dIM2,B_dC3,B_dC2,B_dC1,B_dO,B_dLC3,B_dLC2,B_dLC1,B_dLO] = getINa_SGLT2i(v,genotype2,B_IC3,B_IC2,B_IF,B_IM1,B_IM2,B_C3,B_C2,B_C1,B_O,B_LC3,B_LC2,B_LC1,B_LO,ENa,INa_Multiplier,GNa,1-zygosity);

%% ITo
[Ito,da,diF,diS,dap,diFp, diSp] = getITo_ORd2011(v, a, iF, iS, ap, iFp, iSp, fItop, EK, celltype, Ito_Multiplier);


%% ICaL
[ICaL_ss,ICaNa_ss,ICaK_ss,ICaL_i,ICaNa_i,ICaK_i,dd,dff,dfs,dfcaf,dfcas,djca,dnca,dnca_i,...
    dffp,dfcafp, PhiCaL_ss, PhiCaL_i, gammaCaoMyo, gammaCaiMyo] = getICaL_ORd2011_jt(v, d,ff,fs,fcaf,fcas,jca,nca,nca_i,ffp,fcafp,...
    fICaLp, cai, cass, cao, nai, nass, nao, ki, kss, ko, cli, clo, celltype, ICaL_fractionSS, ICaL_Multiplier );

ICaL = ICaL_ss + ICaL_i;
ICaNa = ICaNa_ss + ICaNa_i;
ICaK = ICaK_ss + ICaK_i;
ICaL_tot = ICaL + ICaNa + ICaK;
%% IKr
[IKr, dt_ikr_c0, dt_ikr_c1, dt_ikr_c2, dt_ikr_o, dt_ikr_i ] = getIKr_ORd2011_MM(v,ikr_c0,ikr_c1, ikr_c2, ikr_o, ikr_i,...
    ko, EK, celltype, IKr_Multiplier);

%% IKs
[IKs,dxs1, dxs2] = getIKs_ORd2011(v,xs1, xs2, cai,  EKs,  celltype, IKs_Multiplier);

%% IK1
IK1 = getIK1_CRLP(v, ko, EK, celltype, IK1_Multiplier);

%% INaCa
[INaCa_i, INaCa_ss] = getINaCa_ORd2011(v,F,R,T, nass, nai, nao, cass, cai, cao, celltype, INaCa_Multiplier, INaCa_fractionSS);

%% INaK
INaK = getINaK_ORd2011(v, F, R, T, nai, nao, ki, ko, celltype, INaK_Multiplier);

%% Minor/background currents
%calculate IKb
xkb=1.0/(1.0+exp(-(v-10.8968)/(23.9871)));
GKb=0.0189*IKb_Multiplier;
if celltype==1
    GKb=GKb*0.6;
end
IKb=GKb*xkb*(v-EK);

%calculate INab
PNab=1.9239e-09*INab_Multiplier;
INab=PNab*vffrt*(nai*exp(vfrt)-nao)/(exp(vfrt)-1.0);

%calculate ICab
PCab=5.9194e-08*ICab_Multiplier;
% 
ICab=PCab*4.0*vffrt*(gammaCaiMyo*cai*exp(2.0*vfrt)-gammaCaoMyo*cao)/(exp(2.0*vfrt)-1.0);

%calculate IpCa
GpCa=5e-04*IpCa_Multiplier;
IpCa=GpCa*cai/(0.0005+cai);

%% Chloride
% I_ClCa: Ca-activated Cl Current, I_Clbk: background Cl Current

ecl = (R*T/F)*log(cli/clo);            % [mV]

Fjunc = 1;   Fsl = 1-Fjunc; % fraction in SS and in myoplasm - as per literature, I(Ca)Cl is in junctional subspace

Fsl = 1-Fjunc; % fraction in SS and in myoplasm
GClCa = ICaCl_Multiplier * 0.2843;   % [mS/uF]
GClB = IClb_Multiplier * 1.98e-3;        % [mS/uF] %
KdClCa = 0.1;    % [mM]

I_ClCa_junc = Fjunc*GClCa/(1+KdClCa/cass)*(v-ecl);
I_ClCa_sl = Fsl*GClCa/(1+KdClCa/cai)*(v-ecl);

I_ClCa = I_ClCa_junc+I_ClCa_sl;
I_Clbk = GClB*(v-ecl);

%% Calcium handling
%calculate ryanodione receptor calcium induced calcium release from the jsr
fJrelp=(1.0/(1.0+KmCaMK/CaMKa));

%% Jrel
[Jrel, dJrel_np, dJrel_p] = getJrel_ORd2011(Jrel_np, Jrel_p, ICaL_ss,cass, cajsr, fJrelp, celltype, Jrel_Multiplier);


fJupp=(1.0/(1.0+KmCaMK/CaMKa));
[Jup, Jleak] = getJup_ORd2011(cai, cansr, fJupp, celltype, Jup_Multiplier);

%calculate tranlocation flux
Jtr=(cansr-cajsr)/60;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% calculate the stimulus current, Istim
amp=stimAmp;
duration=stimDur;
start=stimStart;
if isempty(vcParameters)
    Ivclamp=0;
    if t>start && t<=start+duration
        Istim=amp;
    else
        Istim=0;
    end
else
      % check for voltage clamp parameters
    if length(vcParameters) < 2
        error('Voltage clamp parameters must be passed as a 3-element cell array: {1} = command step amplitude (mV); {2} = step duration (ms); {3} = Clamp resistance (GOhm).');
    else
        v_clamp_amps = vcParameters{1};
        v_clamp_times = vcParameters{2};
        R_clamp = vcParameters{3};
    end
    if t <= v_clamp_times(1)
        v_clamp_amp = v_clamp_amps(1);
        Ivclamp = (v_clamp_amp - V)/R_clamp;
        Istim = 0;
    else 
        for i = 2:length(v_clamp_times)
           if and(t >= v_clamp_times(i-1),t <= v_clamp_times(i))
                v_clamp_amp = v_clamp_amps(i);
                Ivclamp = (v_clamp_amp - V)/R_clamp;
                Istim = 0;
                break
           end
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%update the membrane voltage

dv=-(A_INaf+A_INaL+B_INaf+B_INaL+Ito+ICaL+ICaNa+ICaK+IKr+IKs+IK1+INaCa_i+INaCa_ss+INaK+INab+IKb+IpCa+ICab+I_ClCa+I_Clbk+Istim+Ivclamp);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%calculate diffusion fluxes
JdiffNa=(nass-nai)/2.0;
JdiffK=(kss-ki)/2.0;
Jdiff=(cass-cai)/0.2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%calcium buffer constants 
cmdnmax= 0.05; 
if celltype==1
    cmdnmax=cmdnmax*1.3;
end
kmcmdn=0.00238; 
trpnmax=0.07;
kmtrpn=0.0005;
BSRmax=0.047;
KmBSR = 0.00087;
BSLmax=1.124;
KmBSL = 0.0087;
csqnmax=10.0;
kmcsqn=0.8;

%update intracellular concentrations, using buffers for cai, cass, cajsr
dnai=-(ICaNa_i+A_INaf+A_INaL+B_INaf+B_INaL+3.0*INaCa_i+3.0*INaK+INab)*Acap/(F*vmyo)+JdiffNa*vss/vmyo;
dnass=-(ICaNa_ss+3.0*INaCa_ss)*Acap/(F*vss)-JdiffNa;

dki=-(ICaK_i+Ito+IKr+IKs+IK1+IKb+Istim-2.0*INaK)*Acap/(F*vmyo)+JdiffK*vss/vmyo;
dkss=-(ICaK_ss)*Acap/(F*vss)-JdiffK;

Bcai=1.0/(1.0+cmdnmax*kmcmdn/(kmcmdn+cai)^2.0+trpnmax*kmtrpn/(kmtrpn+cai)^2.0);
dcai=Bcai*(-(ICaL_i + IpCa+ICab-2.0*INaCa_i)*Acap/(2.0*F*vmyo)-Jup*vnsr/vmyo+Jdiff*vss/vmyo);


Bcass=1.0/(1.0+BSRmax*KmBSR/(KmBSR+cass)^2.0+BSLmax*KmBSL/(KmBSL+cass)^2.0);
dcass=Bcass*(-(ICaL_ss-2.0*INaCa_ss)*Acap/(2.0*F*vss)+Jrel*vjsr/vss-Jdiff);

dcansr=Jup-Jtr*vjsr/vnsr;

Bcajsr=1.0/(1.0+csqnmax*kmcsqn/(kmcsqn+cajsr)^2.0);
dcajsr=Bcajsr*(Jtr-Jrel);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%output the state vector when ode_flag==1, and the calculated currents and fluxes otherwise
if flag_ode==1
    output=[dv dnai dnass dki dkss dcai dcass dcansr dcajsr da diF diS dap diFp diSp,...
        dd dff dfs dfcaf dfcas djca dnca dnca_i dffp dfcafp dxs1 dxs2 dJrel_np dCaMKt,...
        dt_ikr_c0 dt_ikr_c1 dt_ikr_c2 dt_ikr_o dt_ikr_i dJrel_p A_dIC3 A_dIC2 A_dIF A_dIM1 A_dIM2,...
        A_dC3 A_dC2 A_dC1 A_dO A_dLC3 A_dLC2 A_dLC1 A_dLO B_dIC3 B_dIC2 B_dIF B_dIM1 B_dIM2,...
        B_dC3 B_dC2 B_dC1 B_dO B_dLC3 B_dLC2 B_dLC1 B_dLO]';
else
    output=[A_INaf A_INaL B_INaf B_INaL Ito ICaL IKr IKs IK1 INaCa_i INaCa_ss INaK  IKb INab ICab IpCa Jdiff JdiffNa JdiffK Jup Jleak Jtr Jrel CaMKa Istim Ivclamp fINap ...
        fINaLp fICaLp fJrelp fJupp cajsr cansr PhiCaL_ss v ICaL_i I_ClCa I_Clbk ICaL_tot];
end

end



% %% INa formulations
% function [INa, dm, dh, dhp, dj, djp] = getINa_Grandi(v, m, h, hp, j, jp, fINap, ENa, INa_Multiplier)
% % The Grandi implementation updated with INa phosphorylation.
% %% m gate
% mss = 1 / ((1 + exp( -(56.86 + v) / 9.03 ))^2);
% taum = 0.1292 * exp(-((v+45.79)/15.54)^2) + 0.06487 * exp(-((v-4.823)/51.12)^2);
% dm = (mss - m) / taum;
% 
% %% h gate
% ah = (v >= -40) * (0)...
%     + (v < -40) * (0.057 * exp( -(v + 80) / 6.8 ));
% bh = (v >= -40) * (0.77 / (0.13*(1 + exp( -(v + 10.66) / 11.1 )))) ...
%     + (v < -40) * ((2.7 * exp( 0.079 * v) + 3.1*10^5 * exp(0.3485 * v)));
% tauh = 1 / (ah + bh);
% hss = 1 / ((1 + exp( (v + 71.55)/7.43 ))^2);
% dh = (hss - h) / tauh;
% %% j gate
% aj = (v >= -40) * (0) ...
%     +(v < -40) * (((-2.5428 * 10^4*exp(0.2444*v) - 6.948*10^-6 * exp(-0.04391*v)) * (v + 37.78)) / ...
%     (1 + exp( 0.311 * (v + 79.23) )));
% bj = (v >= -40) * ((0.6 * exp( 0.057 * v)) / (1 + exp( -0.1 * (v + 32) ))) ...
%     + (v < -40) * ((0.02424 * exp( -0.01052 * v )) / (1 + exp( -0.1378 * (v + 40.14) )));
% tauj = 1 / (aj + bj);
% jss = 1 / ((1 + exp( (v + 71.55)/7.43 ))^2);
% dj = (jss - j) / tauj;
% 
% %% h phosphorylated
% hssp = 1 / ((1 + exp( (v + 71.55 + 6)/7.43 ))^2);
% dhp = (hssp - hp) / tauh;
% %% j phosphorylated
% taujp = 1.46 * tauj;
% djp = (jss - jp) / taujp;
% 
% GNa = 11.7802;
% INa=INa_Multiplier * GNa*(v-ENa)*m^3.0*((1.0-fINap)*h*j+fINap*hp*jp);
% end
% 
% %% INaL
% function [INaL,dmL,dhL,dhLp] = getINaL_ORd2011(v, mL, hL, hLp, fINaLp, ENa, celltype, INaL_Multiplier)
% %calculate INaL
% mLss=1.0/(1.0+exp((-(v+42.85))/5.264));
% tm = 0.1292 * exp(-((v+45.79)/15.54)^2) + 0.06487 * exp(-((v-4.823)/51.12)^2); 
% tmL=tm;
% dmL=(mLss-mL)/tmL;
% hLss=1.0/(1.0+exp((v+87.61)/7.488));
% thL=200.0;
% dhL=(hLss-hL)/thL;
% hLssp=1.0/(1.0+exp((v+93.81)/7.488));
% thLp=3.0*thL;
% dhLp=(hLssp-hLp)/thLp;
% GNaL=0.0279 * INaL_Multiplier;
% if celltype==1
%     GNaL=GNaL*0.6;
% end
% 
% INaL=GNaL*(v-ENa)*mL*((1.0-fINaLp)*hL+fINaLp*hLp);
% end

function [INa,INaL,dIC3,dIC2,dIF,dIM1,dIM2,dC3,dC2,dC1,dO,dLC3,dLC2,dLC1,dLO] = getINa_SGLT2i(v,genotype,IC3,IC2,IF,IM1,IM2,C3,C2,C1,O,LC3,LC2,LC1,LO,ENa,INa_Multiplier,GNa,zygosity)

[p,p_names] = ClancyINa_init_parameters_SGLT2i(genotype); 

% Calculate Markov rates
    Rates = Markov_Na(p,v);
    states = [IC3,IC2,IF,IM1,IM2,C3,C2,C1,O,LC3,LC2,LC1,LO];
    states = states(:); % ensuring correct dimension for inner product
    A = Rates*states;
    dIC3=A(1);
    dIC2=A(2); 
    dIF=A(3); 
    dIM1=A(4);
    dIM2=A(5); 
    dC3=A(6); 
    dC2=A(7); 
    dC1=A(8); 
    dO=A(9); 
    dLC3=A(10); 
    dLC2=A(11); 
    dLC1=A(12); 
    dLO=A(13);  

    INa=INa_Multiplier*zygosity*GNa*(v-ENa)*O;
    INaL=INa_Multiplier*zygosity*GNa*(v-ENa)*LO;
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

  % Solve the state vector
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
        0 0 0 0 0 0 0 0 a8 0 0 a3 -(b8+b3)];
end

%% ITo
function [Ito,da,diF,diS,dap,diFp, diSp] = getITo_ORd2011(v, a, iF, iS, ap, iFp, iSp, fItop, EK, celltype, Ito_Multiplier)

%calculate Ito
ass=1.0/(1.0+exp((-(v-14.34))/14.82));
ta=1.0515/(1.0/(1.2089*(1.0+exp(-(v-18.4099)/29.3814)))+3.5/(1.0+exp((v+100.0)/29.3814)));
da=(ass-a)/ta;
iss=1.0/(1.0+exp((v+43.94)/5.711));
if celltype==1
    delta_epi=1.0-(0.95/(1.0+exp((v+70.0)/5.0)));
else
    delta_epi=1.0;
end
tiF=4.562+1/(0.3933*exp((-(v+100.0))/100.0)+0.08004*exp((v+50.0)/16.59));
tiS=23.62+1/(0.001416*exp((-(v+96.52))/59.05)+1.780e-8*exp((v+114.1)/8.079));
tiF=tiF*delta_epi;
tiS=tiS*delta_epi;
AiF=1.0/(1.0+exp((v-213.6)/151.2));
AiS=1.0-AiF;
diF=(iss-iF)/tiF;
diS=(iss-iS)/tiS;
i=AiF*iF+AiS*iS;
assp=1.0/(1.0+exp((-(v-24.34))/14.82));
dap=(assp-ap)/ta;
dti_develop=1.354+1.0e-4/(exp((v-167.4)/15.89)+exp(-(v-12.23)/0.2154));
dti_recover=1.0-0.5/(1.0+exp((v+70.0)/20.0));
tiFp=dti_develop*dti_recover*tiF;
tiSp=dti_develop*dti_recover*tiS;
diFp=(iss-iFp)/tiFp;
diSp=(iss-iSp)/tiSp;
ip=AiF*iFp+AiS*iSp;
Gto=0.16 * Ito_Multiplier;
if celltype==1
    Gto=Gto*2.0;
elseif celltype==2
    Gto=Gto*2.0;
end

Ito=Gto*(v-EK)*((1.0-fItop)*a*i+fItop*ap*ip);
end


% a variant updated by jakub, using a changed activation curve
% it computes both ICaL in subspace and myoplasm (_i)
function [ICaL_ss,ICaNa_ss,ICaK_ss,ICaL_i,ICaNa_i,ICaK_i,dd,dff,dfs,dfcaf,dfcas,...
    djca,dnca, dnca_i, dffp,dfcafp, PhiCaL_ss, PhiCaL_i, gammaCaoMyo, gammaCaiMyo] = getICaL_ORd2011_jt(v, d,ff,fs,fcaf,fcas,jca,nca, nca_i,ffp,fcafp,...
    fICaLp, cai, cass, cao, nai, nass, nao, ki,kss,ko, cli, clo, celltype, ICaL_fractionSS, ICaL_PCaMultiplier)

%physical constants
R=8314.0;
T=310.0;
F=96485.0;
vffrt=v*F*F/(R*T);
vfrt=v*F/(R*T);

%calculate ICaL, ICaNa, ICaK

dss=1.0763*exp(-1.0070*exp(-0.0829*(v)));  % magyar
if(v >31.4978) % activation cannot be greater than 1
    dss = 1;
end


td= 0.6+1.0/(exp(-0.05*(v+6.0))+exp(0.09*(v+14.0)));

dd=(dss-d)/td;
fss=1.0/(1.0+exp((v+19.58)/3.696));
tff=7.0+1.0/(0.0045*exp(-(v+20.0)/10.0)+0.0045*exp((v+20.0)/10.0));
tfs=1000.0+1.0/(0.000035*exp(-(v+5.0)/4.0)+0.000035*exp((v+5.0)/6.0));
Aff=0.6;
Afs=1.0-Aff;
dff=(fss-ff)/tff;
dfs=(fss-fs)/tfs;
f=Aff*ff+Afs*fs;
fcass=fss;
tfcaf=7.0+1.0/(0.04*exp(-(v-4.0)/7.0)+0.04*exp((v-4.0)/7.0));
tfcas=100.0+1.0/(0.00012*exp(-v/3.0)+0.00012*exp(v/7.0));

Afcaf=0.3+0.6/(1.0+exp((v-10.0)/10.0));

Afcas=1.0-Afcaf;
dfcaf=(fcass-fcaf)/tfcaf;
dfcas=(fcass-fcas)/tfcas;
fca=Afcaf*fcaf+Afcas*fcas;

tjca = 75;
jcass = 1.0/(1.0+exp((v+18.08)/(2.7916)));   
djca=(jcass-jca)/tjca;
tffp=2.5*tff;
dffp=(fss-ffp)/tffp;
fp=Aff*ffp+Afs*fs;
tfcafp=2.5*tfcaf;
dfcafp=(fcass-fcafp)/tfcafp;
fcap=Afcaf*fcafp+Afcas*fcas;

%% SS nca
Kmn=0.002;
k2n=500.0;
km2n=jca*1;
anca=1.0/(k2n/km2n+(1.0+Kmn/cass)^4.0);
dnca=anca*k2n-nca*km2n;

%% myoplasmic nca
anca_i = 1.0/(k2n/km2n+(1.0+Kmn/cai)^4.0);
dnca_i = anca_i*k2n-nca_i*km2n;

%% SS driving force
clo = 150; cli = 24;
Io = 0.5*(nao + ko + clo + 4*cao)/1000 ; % ionic strength outside. /1000 is for things being in micromolar
Ii = 0.5*(nass + kss + cli + 4*cass)/1000 ; % ionic strength outside. /1000 is for things being in micromolar
% The ionic strength is too high for basic DebHuc. We'll use Davies
dielConstant = 74; % water at 37�.
temp = 310; % body temp in kelvins.
constA = 1.82*10^6*(dielConstant*temp)^(-1.5);

gamma_cai = exp(-constA * 4 * (sqrt(Ii)/(1+sqrt(Ii))-0.3*Ii));
gamma_cao = exp(-constA * 4 * (sqrt(Io)/(1+sqrt(Io))-0.3*Io));
gamma_nai = exp(-constA * 1 * (sqrt(Ii)/(1+sqrt(Ii))-0.3*Ii));
gamma_nao = exp(-constA * 1 * (sqrt(Io)/(1+sqrt(Io))-0.3*Io));
gamma_ki = exp(-constA * 1 * (sqrt(Ii)/(1+sqrt(Ii))-0.3*Ii));
gamma_kao = exp(-constA * 1 * (sqrt(Io)/(1+sqrt(Io))-0.3*Io));


PhiCaL_ss =  4.0*vffrt*(gamma_cai*cass*exp(2.0*vfrt)-gamma_cao*cao)/(exp(2.0*vfrt)-1.0);
PhiCaNa_ss =  1.0*vffrt*(gamma_nai*nass*exp(1.0*vfrt)-gamma_nao*nao)/(exp(1.0*vfrt)-1.0);
PhiCaK_ss =  1.0*vffrt*(gamma_ki*kss*exp(1.0*vfrt)-gamma_kao*ko)/(exp(1.0*vfrt)-1.0);

%% Myo driving force
Io = 0.5*(nao + ko + clo + 4*cao)/1000 ; % ionic strength outside. /1000 is for things being in micromolar
Ii = 0.5*(nai + ki + cli + 4*cai)/1000 ; % ionic strength outside. /1000 is for things being in micromolar
% The ionic strength is too high for basic DebHuc. We'll use Davies
dielConstant = 74; % water at 37�.
temp = 310; % body temp in kelvins.
constA = 1.82*10^6*(dielConstant*temp)^(-1.5);

gamma_cai = exp(-constA * 4 * (sqrt(Ii)/(1+sqrt(Ii))-0.3*Ii));
gamma_cao = exp(-constA * 4 * (sqrt(Io)/(1+sqrt(Io))-0.3*Io));
gamma_nai = exp(-constA * 1 * (sqrt(Ii)/(1+sqrt(Ii))-0.3*Ii));
gamma_nao = exp(-constA * 1 * (sqrt(Io)/(1+sqrt(Io))-0.3*Io));
gamma_ki = exp(-constA * 1 * (sqrt(Ii)/(1+sqrt(Ii))-0.3*Ii));
gamma_kao = exp(-constA * 1 * (sqrt(Io)/(1+sqrt(Io))-0.3*Io));

gammaCaoMyo = gamma_cao;
gammaCaiMyo = gamma_cai;

PhiCaL_i =  4.0*vffrt*(gamma_cai*cai*exp(2.0*vfrt)-gamma_cao*cao)/(exp(2.0*vfrt)-1.0);
PhiCaNa_i =  1.0*vffrt*(gamma_nai*nai*exp(1.0*vfrt)-gamma_nao*nao)/(exp(1.0*vfrt)-1.0);
PhiCaK_i =  1.0*vffrt*(gamma_ki*ki*exp(1.0*vfrt)-gamma_kao*ko)/(exp(1.0*vfrt)-1.0);
%% The rest
PCa=8.3757e-05 * ICaL_PCaMultiplier;

if celltype==1
    PCa=PCa*1.2;
elseif celltype==2
    PCa=PCa*2;
end

PCap=1.1*PCa;
PCaNa=0.00125*PCa;
PCaK=3.574e-4*PCa;
PCaNap=0.00125*PCap;
PCaKp=3.574e-4*PCap;

ICaL_ss=(1.0-fICaLp)*PCa*PhiCaL_ss*d*(f*(1.0-nca)+jca*fca*nca)+fICaLp*PCap*PhiCaL_ss*d*(fp*(1.0-nca)+jca*fcap*nca);
ICaNa_ss=(1.0-fICaLp)*PCaNa*PhiCaNa_ss*d*(f*(1.0-nca)+jca*fca*nca)+fICaLp*PCaNap*PhiCaNa_ss*d*(fp*(1.0-nca)+jca*fcap*nca);
ICaK_ss=(1.0-fICaLp)*PCaK*PhiCaK_ss*d*(f*(1.0-nca)+jca*fca*nca)+fICaLp*PCaKp*PhiCaK_ss*d*(fp*(1.0-nca)+jca*fcap*nca);

ICaL_i=(1.0-fICaLp)*PCa*PhiCaL_i*d*(f*(1.0-nca_i)+jca*fca*nca_i)+fICaLp*PCap*PhiCaL_i*d*(fp*(1.0-nca_i)+jca*fcap*nca_i);
ICaNa_i=(1.0-fICaLp)*PCaNa*PhiCaNa_i*d*(f*(1.0-nca_i)+jca*fca*nca_i)+fICaLp*PCaNap*PhiCaNa_i*d*(fp*(1.0-nca_i)+jca*fcap*nca_i);
ICaK_i=(1.0-fICaLp)*PCaK*PhiCaK_i*d*(f*(1.0-nca_i)+jca*fca*nca_i)+fICaLp*PCaKp*PhiCaK_i*d*(fp*(1.0-nca_i)+jca*fcap*nca_i);


% And we weight ICaL (in ss) and ICaL_i
ICaL_i = ICaL_i * (1-ICaL_fractionSS);
ICaNa_i = ICaNa_i * (1-ICaL_fractionSS);
ICaK_i = ICaK_i * (1-ICaL_fractionSS);
ICaL_ss = ICaL_ss * ICaL_fractionSS;
ICaNa_ss = ICaNa_ss * ICaL_fractionSS;
ICaK_ss = ICaK_ss * ICaL_fractionSS;

end

% Variant based on Lu-Vandenberg
function [IKr, dc0, dc1, dc2, do, di ] = getIKr_ORd2011_MM(V,c0,c1, c2, o, i,...
    ko, EK, celltype, IKr_Multiplier)

%physical constants
R=8314.0;
T=310.0;
F=96485.0;

% Extracting state vector
% c3 = y(1);
% c2 = y(2);
% c1 = y(3);
% o = y(4);
% i = y(5);
b = 0; % no channels blocked in via the mechanism of specific MM states
vfrt = V*F/(R*T);

% transition rates
% from c0 to c1 in l-v model,
alpha = 0.1161 * exp(0.2990 * vfrt);
% from c1 to c0 in l-v/
beta =  0.2442 * exp(-1.604 * vfrt);

% from c1 to c2 in l-v/
alpha1 = 1.25 * 0.1235 ;
% from c2 to c1 in l-v/
beta1 =  0.1911;

% from c2 to o/           c1 to o
alpha2 =0.0578 * exp(0.9710 * vfrt); %
% from o to c2/
beta2 = 0.349e-3* exp(-1.062 * vfrt); %

% from o to i
alphai = 0.2533 * exp(0.5953 * vfrt); %
% from i to o
betai = 1.25* 0.0522 * exp(-0.8209 * vfrt); %

% from c2 to i (from c1 in orig)
alphac2ToI = 0.52e-4 * exp(1.525 * vfrt); %
% from i to c2
% betaItoC2 = 0.85e-8 * exp(-1.842 * vfrt); %
betaItoC2 = (beta2 * betai * alphac2ToI)/(alpha2 * alphai); %
% transitions themselves
% for reason of backward compatibility of naming of an older version of a
% MM IKr, c3 in code is c0 in article diagram, c2 is c1, c1 is c2.

dc0 = c1 * beta - c0 * alpha; % delta for c0
dc1 = c0 * alpha + c2*beta1 - c1*(beta+alpha1); % c1
dc2 = c1 * alpha1 + o*beta2 + i*betaItoC2 - c2 * (beta1 + alpha2 + alphac2ToI); % subtraction is into c2, to o, to i. % c2
do = c2 * alpha2 + i*betai - o*(beta2+alphai);
di = c2*alphac2ToI + o*alphai - i*(betaItoC2 + betai);

GKr = 0.0321 * sqrt(ko/5) * IKr_Multiplier; % 1st element compensates for change to ko (sqrt(5/5.4)* 0.0362)
if celltype==1
    GKr=GKr*1.3;
elseif celltype==2
    GKr=GKr*0.8;
end

IKr = GKr * o  * (V-EK);
end

function [IKs,dxs1, dxs2] = getIKs_ORd2011(v,xs1, xs2, cai, EKs, celltype, IKs_Multiplier)
%calculate IKs
xs1ss=1.0/(1.0+exp((-(v+11.60))/8.932));
txs1=817.3+1.0/(2.326e-4*exp((v+48.28)/17.80)+0.001292*exp((-(v+210.0))/230.0));
dxs1=(xs1ss-xs1)/txs1;
xs2ss=xs1ss;
txs2=1.0/(0.01*exp((v-50.0)/20.0)+0.0193*exp((-(v+66.54))/31.0));
dxs2=(xs2ss-xs2)/txs2;
KsCa=1.0+0.6/(1.0+(3.8e-5/cai)^1.4);
GKs= 0.0011 * IKs_Multiplier;
if celltype==1
    GKs=GKs*1.4;
end
IKs=GKs*KsCa*xs1*xs2*(v-EKs);
end

function [IK1] = getIK1_CRLP(v,  ko , EK, celltype, IK1_Multiplier)
% IK1
aK1 = 4.094/(1+exp(0.1217*(v-EK-49.934)));
bK1 = (15.72*exp(0.0674*(v-EK-3.257))+exp(0.0618*(v-EK-594.31)))/(1+exp(-0.1629*(v-EK+14.207)));
K1ss = aK1/(aK1+bK1);

GK1=IK1_Multiplier  * 0.6992; %0.7266; %* sqrt(5/5.4))
if celltype==1
    GK1=GK1*1.2;
elseif celltype==2
    GK1=GK1*1.3;
end
IK1=GK1*sqrt(ko/5)*K1ss*(v-EK);
end

function [ INaCa_i, INaCa_ss] = getINaCa_ORd2011(v,F,R,T, nass, nai, nao, cass, cai, cao, celltype, INaCa_Multiplier, INaCa_fractionSS)
zca = 2.0;
kna1=15.0;
kna2=5.0;
kna3=88.12;
kasymm=12.5;
wna=6.0e4;
wca=6.0e4;
wnaca=5.0e3;
kcaon=1.5e6;
kcaoff=5.0e3;
qna=0.5224;
qca=0.1670;
hca=exp((qca*v*F)/(R*T));
hna=exp((qna*v*F)/(R*T));
h1=1+nai/kna3*(1+hna);
h2=(nai*hna)/(kna3*h1);
h3=1.0/h1;
h4=1.0+nai/kna1*(1+nai/kna2);
h5=nai*nai/(h4*kna1*kna2);
h6=1.0/h4;
h7=1.0+nao/kna3*(1.0+1.0/hna);
h8=nao/(kna3*hna*h7);
h9=1.0/h7;
h10=kasymm+1.0+nao/kna1*(1.0+nao/kna2);
h11=nao*nao/(h10*kna1*kna2);
h12=1.0/h10;
k1=h12*cao*kcaon;
k2=kcaoff;
k3p=h9*wca;
k3pp=h8*wnaca;
k3=k3p+k3pp;
k4p=h3*wca/hca;
k4pp=h2*wnaca;
k4=k4p+k4pp;
k5=kcaoff;
k6=h6*cai*kcaon;
k7=h5*h2*wna;
k8=h8*h11*wna;
x1=k2*k4*(k7+k6)+k5*k7*(k2+k3);
x2=k1*k7*(k4+k5)+k4*k6*(k1+k8);
x3=k1*k3*(k7+k6)+k8*k6*(k2+k3);
x4=k2*k8*(k4+k5)+k3*k5*(k1+k8);
E1=x1/(x1+x2+x3+x4);
E2=x2/(x1+x2+x3+x4);
E3=x3/(x1+x2+x3+x4);
E4=x4/(x1+x2+x3+x4);
KmCaAct=150.0e-6;
allo=1.0/(1.0+(KmCaAct/cai)^2.0);
zna=1.0;
JncxNa=3.0*(E4*k7-E1*k8)+E3*k4pp-E2*k3pp;
JncxCa=E2*k2-E1*k1;
Gncx= 0.0034* INaCa_Multiplier;
if celltype==1
    Gncx=Gncx*1.1;
elseif celltype==2
    Gncx=Gncx*1.4;
end
INaCa_i=(1-INaCa_fractionSS)*Gncx*allo*(zna*JncxNa+zca*JncxCa);

%calculate INaCa_ss
h1=1+nass/kna3*(1+hna);
h2=(nass*hna)/(kna3*h1);
h3=1.0/h1;
h4=1.0+nass/kna1*(1+nass/kna2);
h5=nass*nass/(h4*kna1*kna2);
h6=1.0/h4;
h7=1.0+nao/kna3*(1.0+1.0/hna);
h8=nao/(kna3*hna*h7);
h9=1.0/h7;
h10=kasymm+1.0+nao/kna1*(1+nao/kna2);
h11=nao*nao/(h10*kna1*kna2);
h12=1.0/h10;
k1=h12*cao*kcaon;
k2=kcaoff;
k3p=h9*wca;
k3pp=h8*wnaca;
k3=k3p+k3pp;
k4p=h3*wca/hca;
k4pp=h2*wnaca;
k4=k4p+k4pp;
k5=kcaoff;
k6=h6*cass*kcaon;
k7=h5*h2*wna;
k8=h8*h11*wna;
x1=k2*k4*(k7+k6)+k5*k7*(k2+k3);
x2=k1*k7*(k4+k5)+k4*k6*(k1+k8);
x3=k1*k3*(k7+k6)+k8*k6*(k2+k3);
x4=k2*k8*(k4+k5)+k3*k5*(k1+k8);
E1=x1/(x1+x2+x3+x4);
E2=x2/(x1+x2+x3+x4);
E3=x3/(x1+x2+x3+x4);
E4=x4/(x1+x2+x3+x4);
KmCaAct=150.0e-6 ;
allo=1.0/(1.0+(KmCaAct/cass)^2.0);
JncxNa=3.0*(E4*k7-E1*k8)+E3*k4pp-E2*k3pp;
JncxCa=E2*k2-E1*k1;
INaCa_ss=INaCa_fractionSS*Gncx*allo*(zna*JncxNa+zca*JncxCa);
end


function INaK = getINaK_ORd2011(v, F, R, T, nai, nao, ki, ko, celltype, INaK_Multiplier)
%calculate INaK
zna=1.0;
k1p=949.5;
k1m=182.4;
k2p=687.2;
k2m=39.4;
k3p=1899.0;
k3m=79300.0;
k4p=639.0;
k4m=40.0;
Knai0=9.073;
Knao0=27.78;
delta=-0.1550;
Knai=Knai0*exp((delta*v*F)/(3.0*R*T));
Knao=Knao0*exp(((1.0-delta)*v*F)/(3.0*R*T));
Kki=0.5;
Kko=0.3582;
MgADP=0.05;
MgATP=9.8;
Kmgatp=1.698e-7;
H=1.0e-7;
eP=4.2;
Khp=1.698e-7;
Knap=224.0;
Kxkur=292.0;
P=eP/(1.0+H/Khp+nai/Knap+ki/Kxkur);
a1=(k1p*(nai/Knai)^3.0)/((1.0+nai/Knai)^3.0+(1.0+ki/Kki)^2.0-1.0);
b1=k1m*MgADP;
a2=k2p;
b2=(k2m*(nao/Knao)^3.0)/((1.0+nao/Knao)^3.0+(1.0+ko/Kko)^2.0-1.0);
a3=(k3p*(ko/Kko)^2.0)/((1.0+nao/Knao)^3.0+(1.0+ko/Kko)^2.0-1.0);
b3=(k3m*P*H)/(1.0+MgATP/Kmgatp);
a4=(k4p*MgATP/Kmgatp)/(1.0+MgATP/Kmgatp);
b4=(k4m*(ki/Kki)^2.0)/((1.0+nai/Knai)^3.0+(1.0+ki/Kki)^2.0-1.0);
x1=a4*a1*a2+b2*b4*b3+a2*b4*b3+b3*a1*a2;
x2=b2*b1*b4+a1*a2*a3+a3*b1*b4+a2*a3*b4;
x3=a2*a3*a4+b3*b2*b1+b2*b1*a4+a3*a4*b1;
x4=b4*b3*b2+a3*a4*a1+b2*a4*a1+b3*b2*a1;
E1=x1/(x1+x2+x3+x4);
E2=x2/(x1+x2+x3+x4);
E3=x3/(x1+x2+x3+x4);
E4=x4/(x1+x2+x3+x4);
zk=1.0;
JnakNa=3.0*(E1*a3-E2*b3);
JnakK=2.0*(E4*b1-E3*a1);
Pnak= 15.4509 * INaK_Multiplier;
if celltype==1
    Pnak=Pnak*0.9;
elseif celltype==2
    Pnak=Pnak*0.7;
end


INaK=Pnak*(zna*JnakNa+zk*JnakK);
end

%% Jrel
function [Jrel, dJrelnp, dJrelp] = getJrel_ORd2011(Jrelnp, Jrelp, ICaL, cass, cajsr, fJrelp, celltype, Jrel_Multiplier)
jsrMidpoint = 1.7;

bt=4.75;
a_rel=0.5*bt;
Jrel_inf=a_rel*(-ICaL)/(1.0+(jsrMidpoint/cajsr)^8.0);
if celltype==2
    Jrel_inf=Jrel_inf*1.7;
end
tau_rel=bt/(1.0+0.0123/cajsr);

if tau_rel<0.001
    tau_rel=0.001;
end

dJrelnp=(Jrel_inf-Jrelnp)/tau_rel;
btp=1.25*bt;
a_relp=0.5*btp;
Jrel_infp=a_relp*(-ICaL)/(1.0+(jsrMidpoint/cajsr)^8.0);
if celltype==2
    Jrel_infp=Jrel_infp*1.7;
end
tau_relp=btp/(1.0+0.0123/cajsr);

if tau_relp<0.001
    tau_relp=0.001;
end

dJrelp=(Jrel_infp-Jrelp)/tau_relp;

Jrel=Jrel_Multiplier * 1.5378 * ((1.0-fJrelp)*Jrelnp+fJrelp*Jrelp);
end

%% Jup
function [Jup, Jleak] = getJup_ORd2011(cai, cansr, fJupp, celltype, Jup_Multiplier)
%calculate serca pump, ca uptake flux
% camkFactor = 2.4;
% gjup = 0.00696;
% Jupnp=Jup_Multiplier * gjup*cai/(cai+0.001);
% Jupp=Jup_Multiplier * camkFactor*gjup*cai/(cai + 8.2500e-04);
% if celltype==1
%     Jupnp=Jupnp*1.3;
%     Jupp=Jupp*1.3;
% end
% 
% 
% Jleak=Jup_Multiplier * 0.00629 * cansr/15.0;
% Jup=(1.0-fJupp)*Jupnp+fJupp*Jupp-Jleak;

%calculate serca pump, ca uptake flux
Jupnp=Jup_Multiplier * 0.005425*cai/(cai+0.00092);
Jupp=Jup_Multiplier * 2.75*0.005425*cai/(cai+0.00092-0.00017);
if celltype==1
    Jupnp=Jupnp*1.3;
    Jupp=Jupp*1.3;
end

Jleak=Jup_Multiplier* 0.0048825*cansr/15.0;
Jup=(1.0-fJupp)*Jupnp+fJupp*Jupp-Jleak;

end