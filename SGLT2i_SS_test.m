clear all
close all

restoredefaultpath
% Determine where your m-file's folder is.
folder = fileparts(which(mfilename)); 
% Add that folder plus all subfolders to the path.
addpath(genpath(folder))

% Define rhs model  

version = '_SGLT2i';
rhs_model = str2func(strcat('ClancyINa_rhs', version));
p_handle = str2func(strcat('ClancyINa_init_parameters',version));
s_handle = str2func(strcat('ClancyINa_init_states',version));

% Choose the model
% type = 'WT'; % Note that WT model is only defined for Control drug condition below
% type = 'delKPQ'; % Class I representative (delKPQ or delK1500 for recovery)
type = 'R225Q'; % Class II

% Choose the drug condition
% Empa = 0; % Control
Empa = 1; % Empa

% Get the reference data
switch type
    case 'WT' 
        [act,text,raw] = xlsread('Empa data','SS','C4:C17');
        [inact,text,raw] = xlsread('Empa data','SS','D4:D17');
        [recovery,text,raw] = xlsread('Empa data','recovery','B3:B24');
        [late.percent,text,raw] = xlsread('Empa data','Late','C4:C4');
        late.auc = [];
        late.peak = [];
    case 'delKPQ'
        if Empa == 0
            [act,text,raw] = xlsread('Empa data','SS','O4:O17');
            [inact,text,raw] = xlsread('Empa data','SS','P4:P17');
            [recovery,text,raw] = xlsread('Empa data','recovery','B3:B24'); % Note: class II (delta1500 as proxy for delKPQ) recovery  is not different to WT, so applying WT data here. 
            [late.percent,text,raw] = xlsread('Empa data','Late','L4:L4');
            late.auc = [];
            late.peak = [];
        else
            [act,text,raw] = xlsread('Empa data','SS','Q4:Q17');
            [inact,text,raw] = xlsread('Empa data','SS','R4:R17');
            [recovery,text,raw] = xlsread('Empa data','recovery','B3:B24'); % Note: class II (delta1500 as proxy for delKPQ) recovery is not different to WT, so applying WT data here. 
            [late.percent,text,raw] = xlsread('Empa data','Late','O4:O4');
            [late.auc_norm,text,raw] = xlsread('Empa data','Late','P4:P4');
            [late.peak,text,raw] = xlsread('Empa data','Late','N4:N4');
        end
    case 'R225Q'
        if Empa == 0
            [act,text,raw] = xlsread('Empa data','SS','I4:I17');
            [inact,text,raw] = xlsread('Empa data','SS','J4:J17');
            [recovery,text,raw] = xlsread('Empa data','recovery','B53:B74'); 
            [late.percent,text,raw] = xlsread('Empa data','Late','G4:G4');
            late.peak = [];
            late.auc = []; 
        else
            [act,text,raw] = xlsread('Empa data','SS','K4:K17');
            [inact,text,raw] = xlsread('Empa data','SS','L4:L17');
            [recovery,text,raw] = xlsread('Empa data','recovery','C53:C74'); 
            [late.auc_norm,text,raw] = xlsread('Empa data','Late','J4:J4');
            [late.peak,text,raw] = xlsread('Empa data','Late','H4:H4');
            late.percent = [];
        end
end

% Fitting the data

% Fit V
V = -130:10:0;

% activation fit model
boltzmann_act = '1/(1+exp((a-x)/b))';
start_act = [-20,5];

% inactivation fit model
boltzmann_inact = '1/(1+exp((x-a)/b))';
start_inact = [-40,9];

% Sigmoid recovery fit
times = [2:2:30,40:10:100];

% Fit models and assign reference variables
[fact_ref,gof] = fit(V',act,boltzmann_act,'Start',start_act);
[finact_ref,gof] = fit(V',inact,boltzmann_inact,'Start',start_inact);
sig_params = [0,max(recovery),NaN,NaN];
[recovery_params] = sigm_fit(times',recovery,sig_params);
frecovery_ref.f = @(recovery_params,times) recovery_params(1)+(recovery_params(2)-recovery_params(1))./(1+10.^((recovery_params(3)-times)*recovery_params(4)));
frecovery_ref.params = recovery_params;
frecovery_ref.times = times;

if Empa == 1
    [p, names] = p_handle(strcat(type));
    [states, state_names] = s_handle(-120,p);
    [peak_INa_late,late_amp,late_auc_raw] = SGLT2i_INa_late(p, names, states, state_names, rhs_model);
    late_ref.percent = late.percent; % 
    late_ref.auc_norm = late.auc_norm; % The measured ratio of late current in Empa over late current in Control
    late_ref.auc_raw = late_auc_raw*late.auc_norm; % Taking the absolute AUC from the  baseline model for comparing the effect of empa (imposed by the auc_norm value)
    late_ref.peak_norm = late.peak; % The measured ratio of peak current in Empa over peak current in Control 
    late_ref.peak_raw = late.peak*peak_INa_late; % The expected peak INa value for the Empa model calculated from the measured ratio of peak INa in Empa vs. Control, and the Control model value
    [p, names] = p_handle(strcat(type,'_empa'));
else
    [p, names] = p_handle(type);
    late_ref.percent = late.percent; % late_INa as percent of peak_INa in WT recordings
    late_ref.auc_norm = []; % No data for auc relative to control, or in absolute terms
    late_ref.auc_raw = []; % No data for auc relative to control, or in absolute terms
    late_ref.peak = []; % No data for peak_INa relative to control, or in absolute terms
end

[f_act,INa_act,f_inact,available,f_recovery,P2_over_P1,late] = SGLT2i(p, names, fact_ref, act, finact_ref, inact, frecovery_ref, recovery, late_ref, rhs_model, s_handle, p_handle, type, Empa);

if Empa == 1
    drug = 'Empa';
else
    drug = 'Control';
end
fname = strcat(folder,filesep,'Outputs',filesep,'V_clamp',filesep,type,'_',drug,'.mat');
save (fname,'act','inact','f_act', 'INa_act', 'f_inact', 'available', 'f_recovery', 'P2_over_P1', 'late', 'fact_ref','act', 'inact', 'finact_ref', 'act','recovery', 'frecovery_ref', 'late_ref','-mat');

function [f_act,INa_act,f_inact,available,f_recovery,P2_over_P1,late] = SGLT2i(p, p_names, fact_ref, act_ref, finact_ref, inact_ref, frecovery_ref, recovery_ref, late_ref, rhs_model, s_handle, p_handle, type, Empa)

    % Equilibrium inactivation based on new model
    V = -130:10:0;
    for i = 1: length(V)
        [states, state_names] = s_handle(V(i),p);
        available(i) = 1 - sum(states(1:5));
    end
    boltzmann = '1/(1+exp((x-a)/b))';
    start = [-40,9];
    [f_inact,gof] = fit(V',available',boltzmann,'Start',start);
   
    [states, state_names] = s_handle(-130,p);
    [INa_act, v_half_act, r2_act, f_act] = SGLT2i_INa_act(p, p_names, states, state_names, rhs_model);
    

    [states, state_names] = s_handle(-80,p);
    [P2_over_P1,f_recovery] = SGLT2i_INa_recovery(p, p_names, states, state_names, rhs_model);
    
    [states, state_names] = s_handle(-120,p);
    [peak_INa_late,late_amp,late_auc] = SGLT2i_INa_late(p, p_names, states, state_names, rhs_model);
    late.percent = (late_amp/peak_INa_late)*100;
    if Empa == 1 
        [control_p, control_p_names] = p_handle(strcat(type));
        [control_peak_INa_late,control_late_amp,control_late_auc] = SGLT2i_INa_late(control_p, control_p_names, states, state_names, rhs_model);
        late.auc_raw = late_auc;
        late.auc_norm = late_auc/control_late_auc;
        late.peak = peak_INa_late;
        late.peak_norm = peak_INa_late/control_peak_INa_late;
    else
        late.auc = late_auc;
    end

%     figure
%     plot(f_inact,V,available,'r*'), hold on
%     plot(finact_ref,V,inact_ref,'k*')
%     disp(strcat('v_half_inact',num2str(f_inact.a)))
% 
%     figure
%     plot(f_act,V,INa_act,'r*'), hold on
%     plot(fact_ref,V,act_ref,'k*')
%     disp(strcat('v_half_act',num2str(v_half_act)))
% 
%     figure
%     times = [2:2:30,40:10:100];
%     times_smooth = 0:1:100;
%     plot(times,P2_over_P1,'r*')
%     plot(times,recovery_ref,'k*')
%     h1 = gca;
%     h1.XScale = 'log';
%     disp(strcat('t_half_recovery',num2str(f_recovery.params(3))))
% 
%     figure
%     yyaxis left
%     bar(1,[late.percent,late_ref.percent]), hold on
%     ylabel('I_{Na,L}/I_{Na,peak (%)}')
%     if Empa == 1
%         yyaxis right
%         bar(2,[late.auc_raw,late_ref.auc_raw]);
%         ylabel('I_{Na,L} (AUC)')
%     else
%         yyaxis right
%         bar(2,[late.auc]);
%         ylabel('I_{Na,L} (AUC)')
%     end
end