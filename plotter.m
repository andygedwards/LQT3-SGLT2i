clear all
close all

restoredefaultpath
% Determine where your m-file's folder is.
folder = fileparts(which(mfilename)); 
% Add that folder plus all subfolders to the path.
addpath(genpath(folder))

infolder = strcat(folder,filesep,'Outputs',filesep,'V_clamp'); 
outfolder = strcat(folder,filesep,'Outputs',filesep,'V_clamp',filesep,'Figs');
cd(infolder)

WT = load('WT_Control.mat');
KPQ = load('delKPQ_Control.mat');
R225Q = load('R225Q_Control.mat');
KPQ_empa = load('delKPQ_Empa.mat');
R225Q_empa = load('R225Q_Empa.mat');

V = -130:10:0;
V_pl = -130:1:0;

h1 = figure;
plot(V_pl,WT.f_inact(V_pl),'k',V_pl,KPQ.f_inact(V_pl),'r',V_pl,R225Q.f_inact(V_pl),'b','LineWidth',2), hold on
plot(V,WT.inact,'k*',V,KPQ.inact,'r*',V,R225Q.inact,'b*','LineWidth',2)
plot(V_pl,WT.f_act(V_pl),'k',V_pl,KPQ.f_act(V_pl),'r',V_pl,R225Q.f_act(V_pl),'b','LineWidth',2),
plot(V,WT.act,'k*',V,KPQ.act,'r*',V,R225Q.act,'b*','LineWidth',2)
xlim([-140,0]); set(gca,'FontSize',14);xlabel('V_m (mV)');ylabel('I/I_{max}, G/G_{max}')
legend('WT','delKPQ','R225Q','Location','north','FontSize',14)
title('Control steady state activation and inactivation','FontSize',16, 'FontWeight','bold')
% fname = 'SS_Control';
% saveas(h1,strcat(outfolder,'/',fname),'pdf')


% 
h2 = figure;
plot(V_pl,KPQ.f_inact(V_pl),'r',V_pl,R225Q.f_inact(V_pl),'b','LineWidth',2), hold on
plot(V_pl,KPQ_empa.f_inact(V_pl),'r--',V_pl,R225Q_empa.f_inact(V_pl),'b--','LineWidth',2)
plot(V,KPQ_empa.inact,'r*',V,R225Q_empa.inact,'b*','LineWidth',2)
plot(V_pl,KPQ.f_act(V_pl),'r',V_pl,R225Q.f_act(V_pl),'b','LineWidth',2), hold on
plot(V_pl,KPQ_empa.f_act(V_pl),'r--',V_pl,R225Q_empa.f_act(V_pl),'b--','LineWidth',2)
plot(V,KPQ_empa.INa_act,'r*',V,R225Q_empa.INa_act,'b*','LineWidth',2)
xlim([-140,0]);set(gca,'FontSize',14); xlabel('V_m (mV)');ylabel('I/I_{max}, G/G_{max}')
legend('delKPQ','R225Q','delKPQ+empa','R225Q+empa','Location','north','FontSize',14)
title('Empa steady state activation and inactivation','FontSize',16, 'FontWeight','bold')
% fname = 'SS_Empa';
% saveas(h2,strcat(outfolder,'/',fname),'pdf')

SS_inact_functions = [V_pl',WT.f_inact(V_pl),KPQ.f_inact(V_pl),R225Q.f_inact(V_pl),KPQ_empa.f_inact(V_pl),R225Q_empa.f_inact(V_pl)];
SS_inact_data = [V',WT.inact,KPQ.inact,R225Q.inact,KPQ_empa.inact,R225Q_empa.inact];
SS_act_functions = [V_pl',WT.f_act(V_pl),KPQ.f_act(V_pl),R225Q.f_act(V_pl),KPQ_empa.f_act(V_pl),R225Q_empa.f_act(V_pl)];
SS_act_data = [V',WT.act,KPQ.act,R225Q.act,KPQ_empa.INa_act',R225Q_empa.INa_act'];

SS_simulated = [SS_inact_functions,SS_act_functions];
SS_data = [SS_inact_data, SS_act_data];

% 
h3 = figure;
late_aucs_1 = [KPQ_empa.late.auc_norm;KPQ_empa.late.peak_norm];
late_aucs_2 = [R225Q_empa.late.auc_norm;R225Q_empa.late.peak_norm];
X = categorical({'Late I_{Na} AUC','Peak I_{Na}'});
X = reordercats(X,{'Late I_{Na} AUC','Peak I_{Na}'});
subplot(1,2,1), B1 = bar(X,late_aucs_1,'FaceColor','flat'); title('delKPQ', FontSize=16); ylim([0,1]);  ylabel('ratio (Empa/Control)', FontSize=14);
subplot(1,2,2), B2 = bar(X,late_aucs_2,'FaceColor','flat'); title('R225Q', FontSize=16); ylim([0,1]);
% fname = 'Late_AUC';
% saveas(h3,strcat(outfolder,'/',fname),'pdf')

late_percents_1 = [KPQ.late.percent;KPQ_empa.late.percent];
late_percents_2 = [R225Q.late.percent;R225Q_empa.late.percent];
Late_KPQ = [late_percents_1,late_aucs_1];
Late_R225Q = [late_percents_2,late_aucs_2];

Late = [Late_KPQ,Late_R225Q];

% 
h4 = figure;
t = [2:2:30,40:10:100];
t_pl = 0:1:100;
subplot(1,2,1), semilogx(t,R225Q.recovery,'*k',t,R225Q_empa.recovery,'*r','LineWidth',2), hold on, semilogx(t,R225Q.P2_over_P1,'-k',t,R225Q_empa.P2_over_P1,'-r')
ylabel('I/I_{max}','FontSize',16), legend('Control Measured','Empa Measured','Control Simulated','Empa Simulated','Location','northwest','FontSize',14)
xlabel('time P1 to P2 (ms)','FontSize',16)
title('R225Q Recovery from Inactivation','FontSize',16, 'FontWeight','bold')
subplot(1,2,2), semilogx(t,KPQ.recovery,'*k',t,KPQ_empa.recovery,'*r','LineWidth',2), hold on, semilogx(t,KPQ.P2_over_P1,'-k',t,KPQ_empa.P2_over_P1,'-r')
ylabel('I/I_{max}','FontSize',16), legend('Control Measured','Empa Measured','Control Simulated','Empa Simulated','Location','northwest','FontSize',14)
xlabel('time P1 to P2 (ms)','FontSize',16)
title('\Delta{}K1500 Recovery from Inactivation','FontSize',16, 'FontWeight','bold')

% fname = 'Recovery';
% saveas(h4,strcat(outfolder,'/',fname),'pdf')

Recovery = [t',R225Q.recovery,R225Q_empa.recovery,R225Q.P2_over_P1',R225Q_empa.P2_over_P1',KPQ.recovery,KPQ_empa.recovery,KPQ.P2_over_P1',KPQ_empa.P2_over_P1'];

fname = 'LQT3_summary.xlsx';
fid = fopen(fname);

writematrix(SS_data,fname,"Sheet",'SS_data');
writematrix(SS_simulated,fname,"Sheet",'SS_simulated');
writematrix(Late,fname,"Sheet",'Late');
writematrix(Recovery,fname,"Sheet",'Recovery');
