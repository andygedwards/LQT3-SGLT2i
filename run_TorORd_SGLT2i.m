% Script to execute Tomek-O'Hara-Rudy (TorORd) simulations for all optimized models.

% Output files are saved to the subdirectories
% './Outputs/TorORd/homozygous' and './Outputs/TorORd/heterozygous'

% Binaries are labelled by the two possible genotypes and drug states 
% example 1: WT_WT.mat for homozygous WT without drug
% example 2: WT_empa_R225Q_empa.mat for heterozygous R225Q with drug

% Accompanying plots of final 10s (of 500 total) are included in /figures subfolders in
% both .fig and vector .pdf formats.

% Andy Edwards October 2024.

clear
close all
clc

restoredefaultpath
% Determine where your m-file's folder is.
home = pwd;
% Add that folder plus all subfolders to the path.
addpath(genpath(home))

% Run simulations of the TorORd_SGLT2i model

% Define rhs model  
rhs_model = @TorORd_rhs_SGLT2i;
parameters.model = rhs_model;
parameters.cellType = 1; % epi
zygosity = 0.5; % fraction of channels that are type1
GNa = 0.45*11.7802;

out_folder = strcat(home,filesep,'Outputs',filesep,'TorORd');
if ~isfolder(out_folder)
    mkdir(out_folder)
end
if ~isfolder([out_folder,filesep,'homozygous'])
    mkdir([out_folder,filesep,'homozygous'])
    mkdir([out_folder,filesep,'homozygous',filesep,'figures'])
end
if ~isfolder([out_folder,filesep,'heterozygous'])
    mkdir([out_folder,filesep,'heterozygous'])
    mkdir([out_folder,filesep,'heterozygous',filesep,'figures'])
end

type = {'WT','R225Q','delKPQ','delK1500'};
drug = {'','_empa'};
figdir = [out_folder,filesep,'homozygous',filesep,'figures'];
for i = 1:length(drug)
    for h = 1:length(type)
        Title = [type{h},drug{i},'_',type{h},drug{i}]
        parameters.extraParams = {zygosity,[type{h},drug{i}],[type{h},drug{i}],GNa};
        [T,X,currents] = runTorORd([type{h},drug{i}], [type{h},drug{i}], parameters);
        save([out_folder,filesep,'homozygous',filesep,Title],'T','X','currents');
        figure
        subplot(2,1,1), plot(currents.time,currents.V), xlabel('time (ms)'), ylabel('Vm (mV)');
        subplot(2,1,2), plot(currents.time,currents.A_INaf + currents.B_INaf,'b',currents.time,currents.A_INaL + currents.B_INaL,'k',  'LineWidth', 2), xlabel('time (ms)'), ylabel('Total INa (pA/pF)');
        savefig(fullfile(figdir, [Title, '.fig']));
        exportgraphics(gcf, fullfile(figdir, [Title, '.pdf']), 'ContentType', 'vector');
        parameters.extraParams = {};
        clearvars Title T X currents
    end
end

type1 = 'WT';
type2 = {'WT','R225Q','delKPQ','delK1500'};
drug = {'','_empa'};
figdir = [out_folder,filesep,'heterozygous',filesep,'figures'];
for i = 1:length(drug)
    for h = 1:length(type2)
        Title = [type1,drug{i},'_',type2{h},drug{i}]
        parameters.extraParams = {zygosity,[type1,drug{i}],[type2{h},drug{i}],GNa};
        [T,X,currents] = runTorORd([type1,drug{i}], [type2{h},drug{i}], parameters);
        save([out_folder,filesep,'heterozygous',filesep,Title],'T','X','currents');
        figure
        subplot(2,1,1), plot(currents.time,currents.V), xlabel('time (ms)'), ylabel('Vm (mV)');
        subplot(2,1,2), plot(currents.time,currents.A_INaf + currents.B_INaf,'b',currents.time,currents.A_INaL + currents.B_INaL,'k',  'LineWidth', 2), xlabel('time (ms)'), ylabel('Total INa (pA/pF)');
        savefig(fullfile(figdir, [Title, '.fig']));
        exportgraphics(gcf, fullfile(figdir, [Title, '.pdf']), 'ContentType', 'vector');
        parameters.extraParams = {};
        clearvars Title T X currents
    end
end

function[T,X,currents] = runTorORd(type1, type2, parameters)
    [p1,p1_names] = ClancyINa_init_parameters_SGLT2i(type1);
    [p2,p2_names] = ClancyINa_init_parameters_SGLT2i(type2);
  
    % Set up initial conditions
    [states, state_names] = get_TorORd_states_SGLT2i(p1,p2);
   
    beats = 10; %500
    ignoreFirst = 0; %490
    options = odeset('MaxStep',1, 'RelTol',1e-5);
    [T,X,parameters] = modelRunner_SGLT2i(states,options,parameters,beats,ignoreFirst);
    ignoreAnalysisSpikes = 0;
    currents = getCurrentsStructure_SGLT2i(T, X, parameters, ignoreAnalysisSpikes);
end

