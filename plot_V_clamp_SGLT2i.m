% Script to plot comparative results from voltage clamp simulations for all optimized models.
% Output files are saved to the subdirectories './Outputs/V_clamp/V_clamp_summary.xlsx' (summary matrices in spreadsheet form) and './Outputs/V_clamp/Figs' (figures)

%% Note: V_clamp_summary_headers.xlsx provides the headers for all sheets in the output V_clamp_summary.xlsx

% Andy Edwards (October 2024)

clear
close all
clc

restoredefaultpath
home = pwd;
% Add that folder plus all subfolders to the path.
addpath(genpath(home))

infolder = strcat(home,filesep,'Outputs',filesep,'V_clamp'); 
summaryfolder = infolder;
outfolder = strcat(infolder,filesep,'Figs');
expfolder = strcat(home,filesep,'Data');
if ~isfolder(outfolder)
    mkdir(outfolder)
end

% Define colors
control_color = [0, 0, 1];  % Blue for control
empa_color = [1, 0, 0];     % Red for +Empa

% Load data
WT = load([infolder,filesep,'WT_Control.mat']);
KPQ = load([infolder,filesep,'delKPQ_Control.mat']);
R225Q = load([infolder,filesep,'R225Q_Control.mat']);
K1500 = load([infolder,filesep,'delK1500_Control.mat']);
WT_empa = load([infolder,filesep,'WT_Empa.mat']);
KPQ_empa = load([infolder,filesep,'delKPQ_Empa.mat']);
R225Q_empa = load([infolder,filesep,'R225Q_Empa.mat']);
K1500_empa = load([infolder,filesep,'delK1500_Empa.mat']);

% Plot steady-state activation and inactivation
% Create figure with 4 subplots
h1 = figure('Position', [100, 100, 1400, 800]);

% Voltage ranges
V = -130:10:0;
V_pl = -130:1:0;

% Plot WT (Control and +Empa)
subplot(2, 2, 1);
hold on;
% Control series (blue)
plot(V_pl, WT.f_inact(V_pl), 'Color', control_color, 'LineWidth', 2);
plot(V, WT.inact, 'o', 'Color', control_color, 'MarkerSize', 10, 'LineWidth', 1.5, 'MarkerFaceColor', control_color); % Circles for inactivation
plot(V_pl, WT.f_act(V_pl), 'Color', control_color, 'LineWidth', 2);
plot(V, WT.act, '*', 'Color', control_color, 'MarkerSize', 10, 'LineWidth', 1.5, 'MarkerFaceColor', control_color); % Asterisks for activation
% +Empa series (red)
plot(V_pl, WT_empa.f_inact(V_pl), 'Color', empa_color, 'LineWidth', 2);
plot(V, WT_empa.inact, 'o', 'Color', empa_color, 'MarkerSize', 10, 'LineWidth', 1.5, 'MarkerFaceColor', empa_color); % Circles for inactivation
plot(V_pl, WT_empa.f_act(V_pl), 'Color', empa_color, 'LineWidth', 2);
plot(V, WT_empa.act, '*', 'Color', empa_color, 'MarkerSize', 10, 'LineWidth', 1.5, 'MarkerFaceColor', empa_color); % Asterisks for activation
title('WT: Control vs Empa');
xlabel('V_m (mV)');
ylabel('I/I_{max}, G/G_{max}');
set(gca, 'FontSize', 14);

% Plot KPQ (Control and +Empa)
subplot(2, 2, 2);
hold on;
% Control series (blue)
plot(V_pl, KPQ.f_inact(V_pl), 'Color', control_color, 'LineWidth', 2);
plot(V, KPQ.inact, 'o', 'Color', control_color, 'MarkerSize', 10, 'LineWidth', 1.5, 'MarkerFaceColor', control_color); % Circles for inactivation
plot(V_pl, KPQ.f_act(V_pl), 'Color', control_color, 'LineWidth', 2);
plot(V, KPQ.act, '*', 'Color', control_color, 'MarkerSize', 10, 'LineWidth', 1.5, 'MarkerFaceColor', control_color); % Asterisks for activation
% +Empa series (red)
plot(V_pl, KPQ_empa.f_inact(V_pl), 'Color', empa_color, 'LineWidth', 2);
plot(V, KPQ_empa.inact, 'o', 'Color', empa_color, 'MarkerSize', 10, 'LineWidth', 1.5, 'MarkerFaceColor', empa_color); % Circles for inactivation
plot(V_pl, KPQ_empa.f_act(V_pl), 'Color', empa_color, 'LineWidth', 2);
plot(V, KPQ_empa.act, '*', 'Color', empa_color, 'MarkerSize', 10, 'LineWidth', 1.5, 'MarkerFaceColor', empa_color); % Asterisks for activation
title('\Delta{}KPQ: Control vs Empa');
xlabel('V_m (mV)');
ylabel('I/I_{max}, G/G_{max}');
set(gca, 'FontSize', 14);

% Plot R225Q (Control and +Empa)
subplot(2, 2, 3);
hold on;
% Control series (blue)
plot(V_pl, R225Q.f_inact(V_pl), 'Color', control_color, 'LineWidth', 2);
plot(V, R225Q.inact, 'o', 'Color', control_color, 'MarkerSize', 10, 'LineWidth', 1.5, 'MarkerFaceColor', control_color); % Circles for inactivation
plot(V_pl, R225Q.f_act(V_pl), 'Color', control_color, 'LineWidth', 2);
plot(V, R225Q.act, '*', 'Color', control_color, 'MarkerSize', 10, 'LineWidth', 1.5, 'MarkerFaceColor', control_color); % Asterisks for activation
% +Empa series (red)
plot(V_pl, R225Q_empa.f_inact(V_pl), 'Color', empa_color, 'LineWidth', 2);
plot(V, R225Q_empa.inact, 'o', 'Color', empa_color, 'MarkerSize', 10, 'LineWidth', 1.5, 'MarkerFaceColor', empa_color); % Circles for inactivation
plot(V_pl, R225Q_empa.f_act(V_pl), 'Color', empa_color, 'LineWidth', 2);
plot(V, R225Q_empa.act, '*', 'Color', empa_color, 'MarkerSize', 10, 'LineWidth', 1.5, 'MarkerFaceColor', empa_color); % Asterisks for activation
title('R225Q: Control vs Empa');
xlabel('V_m (mV)');
ylabel('I/I_{max}, G/G_{max}');
set(gca, 'FontSize', 14);

% Plot K1500 (Control and +Empa)
subplot(2, 2, 4);
hold on;
% Control series (blue)
plot(V_pl, K1500.f_inact(V_pl), 'Color', control_color, 'LineWidth', 2);
plot(V, K1500.inact, 'o', 'Color', control_color, 'MarkerSize', 10, 'LineWidth', 1.5, 'MarkerFaceColor', control_color); % Circles for inactivation
plot(V_pl, K1500.f_act(V_pl), 'Color', control_color, 'LineWidth', 2);
plot(V, K1500.act, '*', 'Color', control_color, 'MarkerSize', 10, 'LineWidth', 1.5, 'MarkerFaceColor', control_color); % Asterisks for activation
% +Empa series (red)
plot(V_pl, K1500_empa.f_inact(V_pl), 'Color', empa_color, 'LineWidth', 2);
plot(V, K1500_empa.inact, 'o', 'Color', empa_color, 'MarkerSize', 10, 'LineWidth', 1.5, 'MarkerFaceColor', empa_color); % Circles for inactivation
plot(V_pl, K1500_empa.f_act(V_pl), 'Color', empa_color, 'LineWidth', 2);
plot(V, K1500_empa.act, '*', 'Color', empa_color, 'MarkerSize', 10, 'LineWidth', 1.5, 'MarkerFaceColor', empa_color); % Asterisks for activation
title('\Delta{}1500: Control vs Empa');
xlabel('V_m (mV)');
ylabel('I/I_{max}, G/G_{max}');
set(gca, 'FontSize', 14);

% Adjust layout
sgtitle('Control vs Empa: Steady state activation and inactivation', 'FontSize', 16, 'FontWeight', 'bold');

fname = 'SS';
exportgraphics(h1, strcat(outfolder, filesep, fname, '.pdf'), 'ContentType', 'vector');

SS_inact_functions = [V_pl',WT.f_inact(V_pl),KPQ.f_inact(V_pl), K1500.f_inact(V_pl), R225Q.f_inact(V_pl),WT_empa.f_inact(V_pl),KPQ_empa.f_inact(V_pl),K1500_empa.f_inact(V_pl),R225Q_empa.f_inact(V_pl)];
SS_inact_data = [V',WT.inact,KPQ.inact,K1500.inact,R225Q.inact,WT_empa.inact,KPQ_empa.inact,K1500_empa.inact,R225Q_empa.inact];
SS_act_functions = [V_pl',WT.f_act(V_pl),KPQ.f_act(V_pl),K1500.f_act(V_pl),R225Q.f_act(V_pl),WT_empa.f_act(V_pl),KPQ_empa.f_act(V_pl),K1500_empa.f_act(V_pl),R225Q_empa.f_act(V_pl)];
SS_act_data = [V',WT.act,KPQ.act,R225Q.act,WT_empa.INa_act',KPQ_empa.INa_act',K1500_empa.INa_act',R225Q_empa.INa_act'];

SS_simulated = [SS_inact_functions,SS_act_functions];
SS_data = [SS_inact_data, SS_act_data];

% Plot late currents
h2 = figure('Position', [100, 100, 1400, 800]);  

Late_WT = [WT.late.percent; WT_empa.late.percent];
Late_KPQ = [KPQ.late.percent; KPQ_empa.late.percent];
Late_K1500 = [K1500.late.percent; K1500_empa.late.percent];
Late_R225Q = [R225Q.late.percent; R225Q_empa.late.percent];

% Load Experimental late current data
[WT_late_data, ~, ~] = xlsread([expfolder,filesep,'Fractions_Late_INa'],'WT','C3:C18');
[WT_empa_late_data, ~, ~] = xlsread([expfolder,filesep,'Fractions_Late_INa'],'WT','J3:J18');
[delKPQ_late_data, ~, ~] = xlsread([expfolder,filesep,'Fractions_Late_INa'],'delKPQ','C3:C18');
[delKPQ_empa_late_data, ~, ~] = xlsread([expfolder,filesep,'Fractions_Late_INa'],'delKPQ','J3:J18');
[R225Q_late_data, ~, ~] = xlsread([expfolder,filesep,'Fractions_Late_INa'],'R225Q','C3:C18');
[R225Q_empa_late_data, ~, ~] = xlsread([expfolder,filesep,'Fractions_Late_INa'],'R225Q','J3:J18');
[K1500_late_data, ~, ~] = xlsread([expfolder,filesep,'Fractions_Late_INa'],'delK1500','C3:C18');
[K1500_empa_late_data, ~, ~] = xlsread([expfolder,filesep,'Fractions_Late_INa'],'delK1500','J3:J18');

% Define colors for the two groups (e.g., blue for control and red for +Empa)
control_color = [0, 0, 1];  % Blue for control
empa_color = [1, 0, 0];     % Red for +Empa

% Calculate means and standard errors for each dataset
WT_late_mean = mean(WT_late_data); WT_late_sem = std(WT_late_data) / sqrt(length(WT_late_data));
WT_empa_late_mean = mean(WT_empa_late_data); WT_empa_late_sem = std(WT_empa_late_data) / sqrt(length(WT_empa_late_data));
delKPQ_late_mean = mean(delKPQ_late_data); delKPQ_late_sem = std(delKPQ_late_data) / sqrt(length(delKPQ_late_data));
delKPQ_empa_late_mean = mean(delKPQ_empa_late_data); delKPQ_empa_late_sem = std(delKPQ_empa_late_data) / sqrt(length(delKPQ_empa_late_data));
K1500_late_mean = mean(K1500_late_data); K1500_late_sem = std(K1500_late_data) / sqrt(length(K1500_late_data));
K1500_empa_late_mean = mean(K1500_empa_late_data); K1500_empa_late_sem = std(K1500_empa_late_data) / sqrt(length(K1500_empa_late_data));
R225Q_late_mean = mean(R225Q_late_data); R225Q_late_sem = std(R225Q_late_data) / sqrt(length(R225Q_late_data));
R225Q_empa_late_mean = mean(R225Q_empa_late_data); R225Q_empa_late_sem = std(R225Q_empa_late_data) / sqrt(length(R225Q_empa_late_data));

% Plot for Late_WT
subplot(2, 4, 1);
title('WT', 'FontSize', 16); 
ylabel('Late I_{Na} (% of peak)', 'FontSize', 14);
ylim([0,5]);
hold on;
% Experimental data as empty circles with colored borders
plot(ones(size(WT_late_data)), WT_late_data, 'o', 'MarkerFaceColor', 'none', 'MarkerEdgeColor', control_color);
plot(2*ones(size(WT_empa_late_data)), WT_empa_late_data, 'o', 'MarkerFaceColor', 'none', 'MarkerEdgeColor', empa_color);
% Model values as bold filled circles
plot(1, Late_WT(1), 'o', 'MarkerSize', 10, 'MarkerFaceColor', control_color, 'MarkerEdgeColor', control_color, 'LineWidth', 1.5);
plot(2, Late_WT(2), 'o', 'MarkerSize', 10, 'MarkerFaceColor', empa_color, 'MarkerEdgeColor', empa_color, 'LineWidth', 1.5);
% Horizontal lines and error bars for means
plot([0.8, 1.2], [WT_late_mean, WT_late_mean], 'Color', control_color, 'LineWidth', 1);  % Mean line for Control
plot([1.8, 2.2], [WT_empa_late_mean, WT_empa_late_mean], 'Color', empa_color, 'LineWidth', 1);  % Mean line for Empa
errorbar(1, WT_late_mean, WT_late_sem, 'vertical', 'Color', control_color, 'LineWidth', 0.8);
errorbar(2, WT_empa_late_mean, WT_empa_late_sem, 'vertical', 'Color', empa_color, 'LineWidth', 0.8);

% Plot for Late_KPQ
subplot(2, 4, 2);
title('\Delta{}KPQ', 'FontSize', 16);
ylim([0,5]);
hold on;
plot(ones(size(delKPQ_late_data)), delKPQ_late_data, 'o', 'MarkerFaceColor', 'none', 'MarkerEdgeColor', control_color);
plot(2*ones(size(delKPQ_empa_late_data)), delKPQ_empa_late_data, 'o', 'MarkerFaceColor', 'none', 'MarkerEdgeColor', empa_color);
plot(1, Late_KPQ(1), 'o', 'MarkerSize', 10, 'MarkerFaceColor', control_color, 'MarkerEdgeColor', control_color, 'LineWidth', 1.5);
plot(2, Late_KPQ(2), 'o', 'MarkerSize', 10, 'MarkerFaceColor', empa_color, 'MarkerEdgeColor', empa_color, 'LineWidth', 1.5);
plot([0.8, 1.2], [delKPQ_late_mean, delKPQ_late_mean], 'Color', control_color, 'LineWidth', 1);  % Mean line for Control
plot([1.8, 2.2], [delKPQ_empa_late_mean, delKPQ_empa_late_mean], 'Color', empa_color, 'LineWidth', 1);  % Mean line for Empa
errorbar(1, delKPQ_late_mean, delKPQ_late_sem, 'vertical', 'Color', control_color, 'LineWidth', 0.8);
errorbar(2, delKPQ_empa_late_mean, delKPQ_empa_late_sem, 'vertical', 'Color', empa_color, 'LineWidth', 0.8);

% Plot for Late_K1500
subplot(2, 4, 3);
title('\Delta{}1500', 'FontSize', 16);
ylim([0,5]);
hold on;
plot(ones(size(K1500_late_data)), K1500_late_data, 'o', 'MarkerFaceColor', 'none', 'MarkerEdgeColor', control_color);
plot(2*ones(size(K1500_empa_late_data)), K1500_empa_late_data, 'o', 'MarkerFaceColor', 'none', 'MarkerEdgeColor', empa_color);
plot(1, Late_K1500(1), 'o', 'MarkerSize', 10, 'MarkerFaceColor', control_color, 'MarkerEdgeColor', control_color, 'LineWidth', 1.5);
plot(2, Late_K1500(2), 'o', 'MarkerSize', 10, 'MarkerFaceColor', empa_color, 'MarkerEdgeColor', empa_color, 'LineWidth', 1.5);
plot([0.8, 1.2], [K1500_late_mean, K1500_late_mean], 'Color', control_color, 'LineWidth', 1);  % Mean line for Control
plot([1.8, 2.2], [K1500_empa_late_mean, K1500_empa_late_mean], 'Color', empa_color, 'LineWidth', 1);  % Mean line for Empa
errorbar(1, K1500_late_mean, K1500_late_sem, 'vertical', 'Color', control_color, 'LineWidth', 0.8);
errorbar(2, K1500_empa_late_mean, K1500_empa_late_sem, 'vertical', 'Color', empa_color, 'LineWidth', 0.8);

% Plot for Late_R225Q
subplot(2, 4, 4);
title('R225Q', 'FontSize', 16);
ylim([0,5]);
hold on;
plot(ones(size(R225Q_late_data)), R225Q_late_data, 'o', 'MarkerFaceColor', 'none', 'MarkerEdgeColor', control_color);
plot(2*ones(size(R225Q_empa_late_data)), R225Q_empa_late_data, 'o', 'MarkerFaceColor', 'none', 'MarkerEdgeColor', empa_color);
plot(1, Late_R225Q(1), 'o', 'MarkerSize', 10, 'MarkerFaceColor', control_color, 'MarkerEdgeColor', control_color, 'LineWidth', 1.5);
plot(2, Late_R225Q(2), 'o', 'MarkerSize', 10, 'MarkerFaceColor', empa_color, 'MarkerEdgeColor', empa_color, 'LineWidth', 1.5);
plot([0.8, 1.2], [R225Q_late_mean, R225Q_late_mean], 'Color', control_color, 'LineWidth', 1);  % Mean line for Control
plot([1.8, 2.2], [R225Q_empa_late_mean, R225Q_empa_late_mean], 'Color', empa_color, 'LineWidth', 1);  % Mean line for Empa
errorbar(1, R225Q_late_mean, R225Q_late_sem, 'vertical', 'Color', control_color, 'LineWidth', 0.8);
errorbar(2, R225Q_empa_late_mean, R225Q_empa_late_sem, 'vertical', 'Color', empa_color, 'LineWidth', 0.8);

hold off;

Late_WT = [WT.late.percent; WT_empa.late.percent; WT_empa.late.peak_norm];
Late_KPQ = [KPQ.late.percent; KPQ_empa.late.percent; KPQ_empa.late.peak_norm];
Late_K1500 = [K1500.late.percent; K1500_empa.late.percent; K1500_empa.late.peak_norm];
Late_R225Q = [R225Q.late.percent; R225Q_empa.late.percent; R225Q_empa.late.peak_norm];
Late = [Late_WT, Late_KPQ, Late_K1500, Late_R225Q];

subplot(2, 4, 5);
B0 = bar(Late_WT(3), 'FaceColor', 'flat','FaceAlpha', 0.4);
title('WT', 'FontSize', 16); 
ylim([0,1]);
ylabel('Peak I_{Na} (% of Control)', 'FontSize', 14);
% Set different colors for the two bars
B0.CData(1,:) = empa_color;     % First bar (+Empa) in red

% Plot for Late_KPQ with two different colors
subplot(2, 4, 6);
B1 = bar(Late_KPQ(3), 'FaceColor', 'flat','FaceAlpha', 0.4);
title('\Delta{}KPQ', 'FontSize', 16); 
ylim([0,1]);
% Set different colors for the two bars
B1.CData(1,:) = empa_color;     % First bar (+Empa) in red

% Plot for Late_K1500 with two different colors
subplot(2, 4, 7);
B2 = bar(Late_K1500(3), 'FaceColor', 'flat','FaceAlpha', 0.4);
title('\Delta{}1500', 'FontSize', 16);
ylim([0,1]);
% Set different colors for the two bars
B2.CData(1,:) = empa_color;     % First bar (+Empa) in red

% Plot for Late_R225Q with two different colors
subplot(2, 4, 8);
B3 = bar(Late_R225Q(3), 'FaceColor', 'flat','FaceAlpha', 0.4);
title('R225Q', 'FontSize', 16);
ylim([0,1]);
% Set different colors for the two bars
B3.CData(1,:) = empa_color;     % First bar (+Empa) in red

fname = 'Late_peak';
exportgraphics(h2, strcat(outfolder, filesep, fname, '.pdf'), 'ContentType', 'vector');

% Plot recovery
h3 = figure('Position', [100, 100, 1400, 800]);  
t = [2:2:30,40:10:100];
t_pl = 0:1:100;
subplot(2,2,1), semilogx(t,WT_empa.recovery,'*r',t,WT.recovery,'*b','LineWidth',2), hold on, semilogx(t,WT_empa.P2_over_P1,'-r',t,WT.P2_over_P1,'-b')
ylabel('I/I_{max}','FontSize',16), legend('Empa Measured','Control Measured','Empa Simulated','Control Simulated','Location','northwest','FontSize',14)
xlabel('time P1 to P2 (ms)','FontSize',16)
title('WT Recovery from Inactivation','FontSize',16, 'FontWeight','bold')
subplot(2,2,2), semilogx(t,R225Q_empa.recovery,'*r',t,R225Q.recovery,'*b','LineWidth',2), hold on, semilogx(t,R225Q_empa.P2_over_P1,'-r',t,R225Q.P2_over_P1,'-b')
ylabel('I/I_{max}','FontSize',16), legend('Empa Measured','Control Measured','Empa Simulated','Control Simulated','Location','northwest','FontSize',14)
xlabel('time P1 to P2 (ms)','FontSize',16)
title('R225Q Recovery from Inactivation','FontSize',16, 'FontWeight','bold')
subplot(2,2,3), semilogx(t,KPQ_empa.recovery,'*r',t,KPQ.recovery,'*b','LineWidth',2), hold on, semilogx(t,KPQ_empa.P2_over_P1,'-r',t,KPQ.P2_over_P1,'-b')
ylabel('I/I_{max}','FontSize',16), legend('Empa Measured','Control Measured','Empa Simulated','Control Simulated','Location','northwest','FontSize',14)
xlabel('time P1 to P2 (ms)','FontSize',16)
title('\Delta{}KPQ Recovery from Inactivation','FontSize',16, 'FontWeight','bold')
subplot(2,2,4), semilogx(t,K1500_empa.recovery,'*r',t,K1500.recovery,'*b','LineWidth',2), hold on, semilogx(t,K1500_empa.P2_over_P1,'-r',t,K1500.P2_over_P1,'-b')
ylabel('I/I_{max}','FontSize',16), legend('Empa Measured','Control Measured','Empa Simulated','Control Simulated','Location','northwest','FontSize',14)
xlabel('time P1 to P2 (ms)','FontSize',16)
title('\Delta{}K1500 Recovery from Inactivation','FontSize',16, 'FontWeight','bold')

fname = 'Recovery';
exportgraphics(h3, strcat(outfolder, '/', fname, '.pdf'), 'ContentType', 'vector');

Recovery = [t',WT.recovery,WT_empa.recovery,WT.P2_over_P1',WT_empa.P2_over_P1',R225Q.recovery,R225Q_empa.recovery,R225Q.P2_over_P1',R225Q_empa.P2_over_P1',KPQ.recovery,KPQ_empa.recovery,KPQ.P2_over_P1',KPQ_empa.P2_over_P1',K1500.recovery,K1500_empa.recovery,K1500.P2_over_P1',K1500_empa.P2_over_P1'];

fname = [summaryfolder,filesep,'V_clamp_summary.xlsx'];
fid = fopen(fname);

writematrix(SS_data,fname,"Sheet",'SS_data');
writematrix(SS_simulated,fname,"Sheet",'SS_simulated');
writematrix(Late,fname,"Sheet",'Late simulated');
writematrix(Recovery,fname,"Sheet",'Recovery');
