% Script to plot zoomed action potentials from Tomek-O'Hara-Rudy (TorORd) simulations.

% Output files are saved to the subdirectories './Outputs/TorORd/TorORd_summary.xlsx' (summary spreadsheet) and './Outputs/TorORd/Zoom APs' (figures)
%% Note: TorORd_summary_headers.xlsx provides the headers for all sheets in TorORd_summary.xlsx

clear
close all
clc

restoredefaultpath
home = pwd;
% Add that folder plus all subfolders to the path.
addpath(genpath(home))

infolder = strcat(home,filesep,'Outputs',filesep,'TorORd'); 
outfolder = strcat(home,filesep,'Outputs',filesep,'TorORd',filesep,'Zoom APs');

if ~isfolder(outfolder)
    mkdir(outfolder)
end

print.WT_WT = load([infolder,filesep,'homozygous',filesep,'WT_WT.mat']);
print.delKPQ_delKPQ = load([infolder,filesep,'homozygous',filesep,'delKPQ_delKPQ.mat']);
print.delK1500_delK1500 = load([infolder,filesep,'homozygous',filesep,'delK1500_delK1500.mat']);
print.R225Q_R225Q = load([infolder,filesep,'homozygous',filesep,'R225Q_R225Q.mat']);
print.WT_empa_WT_empa = load([infolder,filesep,'homozygous',filesep,'WT_empa_WT_empa.mat']);
print.delKPQ_empa_delKPQ_empa = load([infolder,filesep,'homozygous',filesep,'delKPQ_empa_delKPQ_empa.mat']);
print.delK1500_empa_delK1500_empa = load([infolder,filesep,'homozygous',filesep,'delK1500_empa_delK1500_empa.mat']);
print.R225Q_empa_R225Q_empa = load([infolder,filesep,'homozygous',filesep,'R225Q_empa_R225Q_empa.mat']);
print.WT_delKPQ = load([infolder,filesep,'heterozygous',filesep,'WT_delKPQ.mat']);
print.WT_delK1500 = load([infolder,filesep,'heterozygous',filesep,'WT_delK1500.mat']);
print.WT_R225Q = load([infolder,filesep,'heterozygous',filesep,'WT_R225Q.mat']);
print.WT_empa_delKPQ_empa = load([infolder,filesep,'heterozygous',filesep,'WT_empa_delKPQ_empa.mat']);
print.WT_empa_delK1500_empa = load([infolder,filesep,'heterozygous',filesep,'WT_empa_delK1500_empa.mat']);
print.WT_empa_R225Q_empa = load([infolder,filesep,'heterozygous',filesep,'WT_empa_R225Q_empa.mat']);

print.WT_WT.currents.INa = print.WT_WT.currents.A_INaf + print.WT_WT.currents.A_INaL + print.WT_WT.currents.B_INaf + print.WT_WT.currents.A_INaL;
print.delKPQ_delKPQ.currents.INa = print.delKPQ_delKPQ.currents.A_INaf + print.delKPQ_delKPQ.currents.A_INaL + print.delKPQ_delKPQ.currents.B_INaf + print.delKPQ_delKPQ.currents.A_INaL;
print.delK1500_delK1500.currents.INa = print.delK1500_delK1500.currents.A_INaf + print.delK1500_delK1500.currents.A_INaL + print.delK1500_delK1500.currents.B_INaf + print.delK1500_delK1500.currents.A_INaL;
print.R225Q_R225Q.currents.INa = print.R225Q_R225Q.currents.A_INaf + print.R225Q_R225Q.currents.A_INaL + print.R225Q_R225Q.currents.B_INaf + print.R225Q_R225Q.currents.A_INaL;
print.WT_empa_WT_empa.currents.INa = print.WT_empa_WT_empa.currents.A_INaf + print.WT_empa_WT_empa.currents.A_INaL + print.WT_empa_WT_empa.currents.B_INaf + print.WT_empa_WT_empa.currents.A_INaL;
print.delKPQ_empa_delKPQ_empa.currents.INa = print.delKPQ_empa_delKPQ_empa.currents.A_INaf + print.delKPQ_empa_delKPQ_empa.currents.A_INaL + print.delKPQ_empa_delKPQ_empa.currents.B_INaf + print.delKPQ_empa_delKPQ_empa.currents.A_INaL;
print.delK1500_empa_delK1500_empa.currents.INa = print.delK1500_empa_delK1500_empa.currents.A_INaf + print.delK1500_empa_delK1500_empa.currents.A_INaL + print.delK1500_empa_delK1500_empa.currents.B_INaf + print.delK1500_empa_delK1500_empa.currents.A_INaL;
print.R225Q_empa_R225Q_empa.currents.INa = print.R225Q_empa_R225Q_empa.currents.A_INaf + print.R225Q_empa_R225Q_empa.currents.A_INaL + print.R225Q_empa_R225Q_empa.currents.B_INaf + print.R225Q_empa_R225Q_empa.currents.A_INaL;
print.WT_delKPQ.currents.INa = print.WT_delKPQ.currents.A_INaf + print.WT_delKPQ.currents.A_INaL + print.WT_delKPQ.currents.B_INaf + print.WT_delKPQ.currents.A_INaL;
print.WT_delK1500.currents.INa = print.WT_delK1500.currents.A_INaf + print.WT_delK1500.currents.A_INaL + print.WT_delK1500.currents.B_INaf + print.WT_delK1500.currents.A_INaL;
print.WT_R225Q.currents.INa = print.WT_R225Q.currents.A_INaf + print.WT_R225Q.currents.A_INaL + print.WT_R225Q.currents.B_INaf + print.WT_R225Q.currents.A_INaL;
print.WT_empa_WT_empa.currents.INa = print.WT_empa_WT_empa.currents.A_INaf + print.WT_empa_WT_empa.currents.A_INaL + print.WT_empa_WT_empa.currents.B_INaf + print.WT_empa_WT_empa.currents.A_INaL;
print.WT_empa_delKPQ_empa.currents.INa = print.WT_empa_delKPQ_empa.currents.A_INaf + print.WT_empa_delKPQ_empa.currents.A_INaL + print.WT_empa_delKPQ_empa.currents.B_INaf + print.WT_empa_delKPQ_empa.currents.A_INaL;
print.WT_empa_delK1500_empa.currents.INa = print.WT_empa_delK1500_empa.currents.A_INaf + print.WT_empa_delK1500_empa.currents.A_INaL + print.WT_empa_delK1500_empa.currents.B_INaf + print.WT_empa_delK1500_empa.currents.A_INaL;
print.WT_empa_R225Q_empa.currents.INa = print.WT_empa_R225Q_empa.currents.A_INaf + print.WT_empa_R225Q_empa.currents.A_INaL + print.WT_empa_R225Q_empa.currents.B_INaf + print.WT_empa_R225Q_empa.currents.A_INaL;

% plot zoomed APs
% Homozygous
f1 = figure;
set(gcf, 'Color', 'w'); % Set the figure background to white
subplot(2,2,1), plot(print.WT_WT.currents.time,print.WT_WT.currents.V,'k',print.delKPQ_delKPQ.currents.time,print.delKPQ_delKPQ.currents.V,'r',print.delK1500_delK1500.currents.time,print.delK1500_delK1500.currents.V,'g',print.R225Q_R225Q.currents.time,print.R225Q_R225Q.currents.V,'b')
xlim([8045,8060])
ylabel('V_m (mV)')
subplot(2,2,3), plot(print.WT_WT.currents.time,print.WT_WT.currents.INa,'k',print.delKPQ_delKPQ.currents.time,print.delKPQ_delKPQ.currents.INa,'r',print.delK1500_delK1500.currents.time,print.delK1500_delK1500.currents.INa,'g',print.R225Q_R225Q.currents.time,print.R225Q_R225Q.currents.INa,'b')
xlim([8045,8060])
ylabel('I_{Na} (A/F)')
subplot(2,2,2), plot(print.WT_WT.currents.time,print.WT_WT.currents.V,'k',print.delKPQ_delKPQ.currents.time,print.delKPQ_delKPQ.currents.V,'r',print.delK1500_delK1500.currents.time,print.delK1500_delK1500.currents.V,'g',print.R225Q_R225Q.currents.time,print.R225Q_R225Q.currents.V,'b')
xlim([8000,10000])
ylabel('V_m (mV)')
subplot(2,2,4), plot(print.WT_WT.currents.time,print.WT_WT.currents.INa,'k',print.delKPQ_delKPQ.currents.time,print.delKPQ_delKPQ.currents.INa,'r',print.delK1500_delK1500.currents.time,print.delK1500_delK1500.currents.INa,'g',print.R225Q_R225Q.currents.time,print.R225Q_R225Q.currents.INa,'b')
xlim([8000,10000])
ylim([-2,0])
ylabel('I_{Na} (A/F)')
legend({'WT','\Delta{}KPQ','\Delta{}K1500','R225Q'}, 'Position', [0.80 0.15 0.06 0.1],'Box', 'off');
ax = findall(gcf, 'Type', 'axes');
set(ax, 'Box', 'off');
fname = 'homozygous';
exportgraphics(f1, strcat(outfolder, filesep, fname, '.pdf'), 'ContentType', 'vector');

% Homozygous + empa
f2 = figure;
set(gcf, 'Color', 'w'); % Set the figure background to white
subplot(2,2,1), plot(print.WT_empa_WT_empa.currents.time,print.WT_empa_WT_empa.currents.V,'k--',print.delKPQ_empa_delKPQ_empa.currents.time,print.delKPQ_empa_delKPQ_empa.currents.V,'r--',print.delK1500_empa_delK1500_empa.currents.time,print.delK1500_empa_delK1500_empa.currents.V,'g--',print.R225Q_empa_R225Q_empa.currents.time,print.R225Q_empa_R225Q_empa.currents.V,'b--')
xlim([8045,8060])
ylabel('V_m (mV)')
subplot(2,2,3), plot(print.WT_empa_WT_empa.currents.time,print.WT_empa_WT_empa.currents.INa,'k--',print.delKPQ_empa_delKPQ_empa.currents.time,print.delKPQ_empa_delKPQ_empa.currents.INa,'r--',print.delK1500_empa_delK1500_empa.currents.time,print.delK1500_empa_delK1500_empa.currents.INa,'g--',print.R225Q_empa_R225Q_empa.currents.time,print.R225Q_empa_R225Q_empa.currents.INa,'b--')
xlim([8045,8060])
ylabel('I_{Na} (A/F)')
subplot(2,2,2), plot(print.WT_empa_WT_empa.currents.time,print.WT_empa_WT_empa.currents.V,'k--',print.delKPQ_empa_delKPQ_empa.currents.time,print.delKPQ_empa_delKPQ_empa.currents.V,'r--',print.delK1500_empa_delK1500_empa.currents.time,print.delK1500_empa_delK1500_empa.currents.V,'g--',print.R225Q_empa_R225Q_empa.currents.time,print.R225Q_empa_R225Q_empa.currents.V,'b--')
xlim([8000,10000])
ylabel('V_m (mV)')
subplot(2,2,4), plot(print.WT_empa_WT_empa.currents.time,print.WT_empa_WT_empa.currents.INa,'k--',print.delKPQ_empa_delKPQ_empa.currents.time,print.delKPQ_empa_delKPQ_empa.currents.INa,'r--',print.delK1500_empa_delK1500_empa.currents.time,print.delK1500_empa_delK1500_empa.currents.INa,'g--',print.R225Q_empa_R225Q_empa.currents.time,print.R225Q_empa_R225Q_empa.currents.INa,'b--')
xlim([8000,10000])
ylim([-2,0])
ylabel('I_{Na} (A/F)')
legend({'WT + empa','\Delta{}KPQ + empa','\Delta{}K1500 + empa','R225Q + empa'}, 'Position', [0.85 0.13 0.06 0.1],'Box', 'off');
ax = findall(gcf, 'Type', 'axes');
set(ax, 'Box', 'off');
fname = 'homozygous_empa';
exportgraphics(f2, strcat(outfolder, filesep, fname, '.pdf'), 'ContentType', 'vector');

% plot zoomed APs
% Heterozygous
f3 = figure;
set(gcf, 'Color', 'w'); % Set the figure background to white
subplot(2,2,1), plot(print.WT_WT.currents.time,print.WT_WT.currents.V,'k',print.WT_delKPQ.currents.time,print.WT_delKPQ.currents.V,'r',print.WT_delK1500.currents.time,print.WT_delK1500.currents.V,'g',print.WT_R225Q.currents.time,print.WT_R225Q.currents.V,'b')
xlim([8045,8060])
ylabel('V_m (mV)')
subplot(2,2,3), plot(print.WT_WT.currents.time,print.WT_WT.currents.INa,'k',print.WT_delKPQ.currents.time,print.WT_delKPQ.currents.INa,'r',print.WT_delK1500.currents.time,print.WT_delK1500.currents.INa,'g',print.WT_R225Q.currents.time,print.WT_R225Q.currents.INa,'b')
xlim([8045,8060])
ylabel('I_{Na} (A/F)')
subplot(2,2,2), plot(print.WT_WT.currents.time,print.WT_WT.currents.V,'k',print.WT_delKPQ.currents.time,print.WT_delKPQ.currents.V,'r',print.WT_delK1500.currents.time,print.WT_delK1500.currents.V,'g',print.WT_R225Q.currents.time,print.WT_R225Q.currents.V,'b')
xlim([8000,10000])
ylabel('V_m (mV)')
subplot(2,2,4), plot(print.WT_WT.currents.time,print.WT_WT.currents.INa,'k',print.WT_delKPQ.currents.time,print.WT_delKPQ.currents.INa,'r',print.WT_delK1500.currents.time,print.WT_delK1500.currents.INa,'g',print.WT_R225Q.currents.time,print.WT_R225Q.currents.INa,'b')
xlim([8000,10000])
ylim([-2,0])
ylabel('I_{Na} (A/F)')
legend({'WT','\Delta{}KPQ','\Delta{}K1500','R225Q'}, 'Position', [0.80 0.15 0.06 0.1],'Box', 'off');
ax = findall(gcf, 'Type', 'axes');
set(ax, 'Box', 'off');
fname = 'heterozygous';
exportgraphics(f3, strcat(outfolder, filesep, fname, '.pdf'), 'ContentType', 'vector');


% Heterozygous + empa
f4 = figure;
set(gcf, 'Color', 'w'); % Set the figure background to white
subplot(2,2,1), plot(print.WT_empa_WT_empa.currents.time,print.WT_empa_WT_empa.currents.V,'k--',print.WT_empa_delKPQ_empa.currents.time,print.WT_empa_delKPQ_empa.currents.V,'r--',print.WT_empa_delK1500_empa.currents.time,print.WT_empa_delK1500_empa.currents.V,'g--',print.WT_empa_R225Q_empa.currents.time,print.WT_empa_R225Q_empa.currents.V,'b--')
xlim([8045,8060])
ylabel('V_m (mV)')
subplot(2,2,3), plot(print.WT_empa_WT_empa.currents.time,print.WT_empa_WT_empa.currents.INa,'k--',print.WT_empa_delKPQ_empa.currents.time,print.WT_empa_delKPQ_empa.currents.INa,'r--',print.WT_empa_delK1500_empa.currents.time,print.WT_empa_delK1500_empa.currents.INa,'g--',print.WT_empa_R225Q_empa.currents.time,print.WT_empa_R225Q_empa.currents.INa,'b--')
xlim([8045,8060])
ylabel('I_{Na} (A/F)')
subplot(2,2,2), plot(print.WT_empa_WT_empa.currents.time,print.WT_empa_WT_empa.currents.V,'k--',print.WT_empa_delKPQ_empa.currents.time,print.WT_empa_delKPQ_empa.currents.V,'r--',print.WT_empa_delK1500_empa.currents.time,print.WT_empa_delK1500_empa.currents.V,'g--',print.WT_empa_R225Q_empa.currents.time,print.WT_empa_R225Q_empa.currents.V,'b--')
xlim([8000,10000])
ylabel('V_m (mV)')
subplot(2,2,4), plot(print.WT_empa_WT_empa.currents.time,print.WT_empa_WT_empa.currents.INa,'k--',print.WT_empa_delKPQ_empa.currents.time,print.WT_empa_delKPQ_empa.currents.INa,'r--',print.WT_empa_delK1500_empa.currents.time,print.WT_empa_delK1500_empa.currents.INa,'g--',print.WT_empa_R225Q_empa.currents.time,print.WT_empa_R225Q_empa.currents.INa,'b--')
xlim([8000,10000])
ylim([-2,0])
ylabel('I_{Na} (A/F)')
legend({'WT + empa','\Delta{}KPQ^{(-/+)} + empa','\Delta{}K1500^{(-/+)} + empa','R225Q^{(-/+)} + empa'}, 'Position', [0.85 0.13 0.06 0.1],'Box', 'off');
ax = findall(gcf, 'Type', 'axes');
set(ax, 'Box', 'off');
fname = 'heterozygous_empa';
exportgraphics(f4, strcat(outfolder, filesep, fname, '.pdf'), 'ContentType', 'vector');

fname = [infolder,filesep,'TorORd_summary.xlsx'];
names = fields(print);

for g = 1:length(names) 
    sheet = names{g};
    for i = 1:length(print.(sheet).currents) 
        data = [print.(sheet).currents.time,print.(sheet).currents.V,print.(sheet).currents.A_INaf',print.(sheet).currents.A_INaL'...
            print.(sheet).currents.B_INaf', print.(sheet).currents.B_INaL',print.(sheet).currents.Cai,print.(sheet).currents.CaMKa];
        range_end = num2str(length(print.(sheet).currents.time));
        writematrix(data,fname,'Sheet',sheet,'Range',['A2:H',range_end]);
    end
end

