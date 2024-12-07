% Script to execute voltage clamp protocols for all optimized models.
% Input experimental data for reference are contained in the subdirectory './Data'
% Output files are saved to the subdirectory './Outputs/V_clamp'
% Plotting functionality is included to assess fit quality, but for final
% plots use plot_V_clamp_SGLT2i.m

% Andy Edwards October 2024.

clear
close all
clc

%% Choose the model
type = 'WT'; 
% type = 'delKPQ'; % Class I representative 
% type = 'delK1500'; % Class I representative including recovery
% type = 'R225Q'; % Class II

%% Choose the drug condition
Empa = 0; % Control
% Empa = 1; % Empa

% Set the accessible paths
restoredefaultpath
% Determine where your m-file's folder is.
home = pwd; 
% Add that folder plus all subfolders to the path.
addpath(genpath(pwd))

% Set the output folder
outfolder = strcat(home,filesep,'Outputs',filesep,'V_clamp')
if ~isfolder(outfolder)
    mkdir(outfolder)
end

% Define rhs model  
version = '_SGLT2i';
rhs_model = str2func(strcat('ClancyINa_rhs', version));
p_handle = str2func(strcat('ClancyINa_init_parameters',version));
s_handle = str2func(strcat('ClancyINa_init_states',version));

% Get the reference data
switch type
    case 'WT' 
        if Empa == 0
            [act,text,raw] = xlsread('Empa data','SS','C4:C17');
            [inact,text,raw] = xlsread('Empa data','SS','D4:D17');
            [recovery,text,raw] = xlsread('Empa data','recovery','B3:B24');
            [late.percent,text,raw] = xlsread('Fractions_Late_INa','WT','C30:C30');
            late.auc = [];
            late.peak = [];
        else
            [act,text,raw] = xlsread('Empa data','SS','E4:E17');
            [inact,text,raw] = xlsread('Empa data','SS','F4:F17');
            [recovery,text,raw] = xlsread('Empa data','recovery','C3:C24');
            [late.percent,text,raw] = xlsread('Fractions_Late_INa','WT','J32:J32');
            late.auc = [];
            late.peak = [];
        end
    case 'delKPQ'
        if Empa == 0
            [act,text,raw] = xlsread('Empa data','SS','O4:O17');
            [inact,text,raw] = xlsread('Empa data','SS','P4:P17');
            [recovery,text,raw] = xlsread('Empa data','recovery','B28:B49'); % Note: delKPQ recovery  is not different to WT, so applying WT data here. 
            [late.percent,text,raw] = xlsread('Fractions_Late_INa','delKPQ','C30:C30');
            late.auc = [];
            late.peak = [];
        else
            [act,text,raw] = xlsread('Empa data','SS','Q4:Q17');
            [inact,text,raw] = xlsread('Empa data','SS','R4:R17');
            [recovery,text,raw] = xlsread('Empa data','recovery','C28:C49'); % Note: delKPQ recovery is not different to WT, so applying WT data here. 
            [late.percent,text,raw] = xlsread('Fractions_Late_INa','delKPQ','J30:J30');
            late.auc_norm = [];
            [late.peak,text,raw] = xlsread('Empa data','Late','N4:N4');
        end
    case 'R225Q'
        if Empa == 0
            [act,text,raw] = xlsread('Empa data','SS','I4:I17');
            [inact,text,raw] = xlsread('Empa data','SS','J4:J17');
            [recovery,text,raw] = xlsread('Empa data','recovery','B53:B74'); 
            [late.percent,text,raw] = xlsread('Fractions_Late_INa','R225Q','C30:C30');
            late.peak = [];
            late.auc = []; 
        else
            [act,text,raw] = xlsread('Empa data','SS','K4:K17');
            [inact,text,raw] = xlsread('Empa data','SS','L4:L17');
            [recovery,text,raw] = xlsread('Empa data','recovery','C53:C74'); 
            [late.percent,tex,raw] = xlsread('Fractions_Late_INa','R225Q','J30:J30');
            [late.peak,text,raw] = xlsread('Empa data','Late','H4:H4');
            late.auc_norm = [];
        end
    case 'delK1500'
        if Empa == 0
            [act,text,raw] = xlsread('Empa data','SS','U4:U17');
            [inact,text,raw] = xlsread('Empa data','SS','V4:V17');
            [recovery,text,raw] = xlsread('Empa data','recovery','B78:B99'); 
            [late.percent,text,raw] = xlsread('Fractions_Late_INa','delK1500','C30:C30');
            late.peak = [];
            late.auc = []; 
        else
            [act,text,raw] = xlsread('Empa data','SS','W4:W17');
            [inact,text,raw] = xlsread('Empa data','SS','X4:X17');
            [recovery,text,raw] = xlsread('Empa data','recovery','C78:C99'); 
            [late.percent,text,raw] = xlsread('Fractions_Late_INa','delK1500','J30:J30');
            late.peak = [];
            late.auc_norm = [];
        end
end

% Fitting the data

% Fit V
V = (-130:10:0)';

% activation fit model
boltzmann_act = '1/(1+exp((a-x)/b))';
start_act = [-20,5];

% inactivation fit model
boltzmann_inact = '1/(1+exp((x-a)/b))';
start_inact = [-40,9];

% Sigmoid recovery fit
times = [2:2:30,40:10:100];

% Fit boltzmann models to data and assign reference variables
[fact_ref,gof] = fit(V,act,boltzmann_act,'Start',start_act);
[finact_ref,gof] = fit(V,inact,boltzmann_inact,'Start',start_inact);
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
    late_ref.peak_norm = late.peak; % The measured ratio of peak current in Empa over peak current in Control 
    late_ref.peak_raw = late.peak*peak_INa_late; % The expected peak INa value for the Empa model calculated from the measured ratio of peak INa in Empa vs. Control, and the Control model value
    [p, names] = p_handle(strcat(type,'_empa'));
else
    [p, names] = p_handle(type);
    late_ref.percent = late.percent; % late_INa as percent of peak_INa
    late_ref.auc_norm = []; % No data for auc relative to control, or in absolute terms
    late_ref.auc_raw = []; % No data for auc relative to control, or in absolute terms
    late_ref.peak = []; % No data for peak_INa relative to control, or in absolute terms
end

% Run the simulations
[f_act,INa_act,f_inact,available,f_recovery,P2_over_P1,late] = SGLT2i(p, names, fact_ref, act, finact_ref, inact, frecovery_ref, recovery, late_ref, rhs_model, s_handle, p_handle, type, Empa);

% Set the output filename
if Empa == 1
    drug = 'Empa';
else
    drug = 'Control';
end
fname = strcat(outfolder,filesep,type,'_',drug,'.mat');
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

    % figure
    % xFit = linspace(min(V), max(V), 100);  
    % yFit_sim = feval(f_inact, xFit);     
    % yFit = feval(finact_ref, xFit);    
    % plot(V,available, 'r.', 'DisplayName', 'Simulation'), hold on
    % plot(xFit,yFit_sim,'r-', 'DisplayName', 'Simulated fit'), hold on
    % plot(V,inact_ref,'k.', 'DisplayName', 'Experiment'), hold on
    % pause
    % plot(xFit,yFit,'k-', 'DisplayName', 'Experimental fit')
    % disp(strcat('v_half_inact',num2str(f_inact.a)))
    % xlabel('V_m (mV)')
    % ylabel('I/I_{max} (ratio)')
    % legend
    % 
    % figure
    % xFit = linspace(min(V), max(V), 100);  
    % yFit_sim = feval(f_act, xFit);     
    % yFit = feval(fact_ref, xFit);    
    % plot(V,INa_act, 'r.', 'DisplayName', 'Simulation'), hold on
    % plot(xFit,yFit_sim,'r-', 'DisplayName', 'Simulated fit')
    % plot(V,act_ref,'k.', 'DisplayName', 'Experiment')
    % plot(xFit,yFit,'k-', 'DisplayName', 'Experimental fit')
    % disp(strcat('v_half_inact',num2str(f_act.a)))
    % xlabel('V_m (mV)')
    % ylabel('I/I_{max} (ratio)')
    % legend
    % 
    % figure
    % times = [2:2:30,40:10:100];
    % times_smooth = 0:1:100;
    % plot(times,P2_over_P1,'ro'), hold on
    % plot(times,recovery_ref,'ko')
    % h1 = gca;
    % h1.XScale = 'log';
    % disp(strcat('t_half_recovery',num2str(f_recovery.params(3))))
    % xlabel('Interpulse interval (ms)')
    % ylabel('I/I_{max} (ratio)')
    % 
    % figure
    % % color = {'r','b'};
    % bar({'Simulation','Experiment'},[late.percent,late_ref.percent],0.5), hold on
    % ylabel('I_{Na,L}/I_{Na,peak} (%)')
end