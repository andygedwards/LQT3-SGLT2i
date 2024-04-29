function [] = plotORd(infile)
    restoredefaultpath
    % Determine where your m-file's folder is.
    folder = fileparts(which(mfilename)); 
    % Add that folder plus all subfolders to the path.
    addpath(genpath(folder))

    infolder = strcat(folder,filesep,'Outputs',filesep,'ORd');
    load(strcat(infolder,filesep,infile))

    t_cat = t_L{1};
    V_cat = V_L{1};
    Cai_cat = Cai_L{1};
    INaf_cat = INaf_L{1};
    INaL_cat = INaL_L{1};
    ICaL_cat = ICaL_L{1};
    Ito_cat = Ito_L{1};
    IKr_cat = IKr_L{1};
    IKs_cat = IKs_L{1};
    IK1_cat = IK1_L{1};

    for i = 2:length(t_L)
        t_cat = [t_cat;t_L{i}+t_cat(end)];
        V_cat = [V_cat;V_L{i}];
        Cai_cat = [Cai_cat;Cai_L{i}];
        INaf_cat = [INaf_cat;INaf_L{i}];
        INaL_cat = [INaL_cat;INaL_L{i}];
        ICaL_cat = [ICaL_cat;ICaL_L{i}];
        Ito_cat = [Ito_cat;Ito_L{i}];
        IKr_cat = [IKr_cat;IKr_L{i}];
        IKs_cat = [IKs_cat;IKs_L{i}];
        IK1_cat = [IK1_cat;IK1_L{i}];
    end

    currents_cat = [INaf_cat,INaL_cat,Ito_cat,ICaL_cat,IKr_cat,IKs_cat,IK1_cat];

    if strcmp(infile,'delKPQ')
        Title = '\Delta{}KPQ';
    elseif strcmp(infile,'delKPQ_empa')
        Title = '\Delta{}KPQ + empa';
    elseif strcmp(infile,'R225Q_empa')
        Title = 'R225Q + empa';
    else
        Title = infile;
    end

    h1 = figure;
    subplot(4,1,1), plot(t_cat,V_cat, 'LineWidth', 2),xticklabels([]),ylabel('V_{m} (mV)','FontSize',10),title(Title,'FontSize',20)
    subplot(4,1,2), plot(t_cat,Cai_cat, 'LineWidth', 2),xticklabels([]),ylabel('Ca_{i}^{2+} (\mu{}M)','FontSize',10)
    subplot(4,1,3), plot(t_cat,currents_cat(:,1:4), 'LineWidth', 2), legend('INaf','INaL','Ito','ICaL'), xticklabels([]), ylabel('Current (pA/pF)','FontSize',10)
    subplot(4,1,4), plot(t_cat,currents_cat(:,5:7), 'LineWidth', 2), legend('IKr','IKs','IK1'), ylim([-1,1]), xlabel('time (ms)','FontSize',16), ylabel('Current (pA/pF)','FontSize',10)
%     saveas(h1,strcat(infolder,'/',infile),'pdf')
    h2 = figure;
    subplot(2,1,1),plot(t_L{9},INaf_L{9},t_L{9},INaL_L{9},t_L{9},Ito_L{9},t_L{9},ICaL_L{9},'LineWidth', 2),legend('INaf','INaL','Ito','ICaL'), xticklabels([]), ylim([-2,1]),ylabel('Current (pA/pF)','FontSize',16),title(Title,'FontSize',20)
    subplot(2,1,2),plot(t_L{9},IKr_L{9},t_L{9},IKs_L{9},t_L{9},IK1_L{9}, 'LineWidth', 2),legend('IKr','IKs','IK1'), ylim([-1,1]), xlabel('time (ms)'), ylabel('Current (pA/pF)','FontSize',16)
%     saveas(h2,strcat(infolder,'/',infile,'_zoom'),'pdf')
end