clear all
close all

restoredefaultpath
% Determine where your m-file's folder is.
folder = fileparts(which(mfilename)); 
% Add that folder plus all subfolders to the path.
addpath(genpath(folder))

% Run simulations of the ORd model

% Define rhs model  
rhs_model = @ORd_rhs;
out_folder = strcat(folder,filesep,'Outputs',filesep,'ORd');
if ~isfolder(out_folder)
    mkdir(out_folder)
end

for h = 1:5
    % Run each INa model 
    if h==1
        type = 'WT';
        Title = type;
        g_Na = 3.0; 
        [t,y,currents,t_L,y_L,currents_L,Y_init] = runORd(type, g_Na, rhs_model);
        for i = 1:length(t_L)
            V_L{i} = y_L{i}(:,1); Cai_L{i} = y_L{i}(:,6); 
            INaf_L{i} = currents_L{i}(:,1); INaL_L{i} = currents_L{i}(:,2); Ito_L{i} = currents_L{i}(:,3); ICaL_L{i} = currents_L{i}(:,4); IKr_L{i} = currents_L{i}(:,5); IKs_L{i} = currents_L{i}(:,6); IK1_L{i} = currents_L{i}(:,7);
        end
        save(strcat(out_folder,'/',type),'t_L','V_L','Cai_L','ICaL_L','INaf_L','INaL_L','Ito_L','IKr_L','IKs_L','IK1_L','Y_init');
    elseif h==2
        type = 'delKPQ';
        Title = '\Delta{}KPQ';
        g_Na = 3.0;
        [t,y,currents,t_L,y_L,currents_L,Y_init] = runORd(type, g_Na, rhs_model);
        for i = 1:length(t_L)
            V_L{i} = y_L{i}(:,1); Cai_L{i} = y_L{i}(:,6); 
            INaf_L{i} = currents_L{i}(:,1); INaL_L{i} = currents_L{i}(:,2); Ito_L{i} = currents_L{i}(:,3); ICaL_L{i} = currents_L{i}(:,4); IKr_L{i} = currents_L{i}(:,5); IKs_L{i} = currents_L{i}(:,6); IK1_L{i} = currents_L{i}(:,7);
        end
        save(strcat(out_folder,'/',type),'t_L','V_L','Cai_L','ICaL_L','INaf_L','INaL_L','Ito_L','IKr_L','IKs_L','IK1_L','Y_init');
    elseif h==3
        type = 'R225Q';
        Title = type;
        g_Na = 3.0*2;
        [t,y,currents,t_L,y_L,currents_L,Y_init] = runORd(type, g_Na, rhs_model);
        for i = 1:length(t_L)
            V_L{i} = y_L{i}(:,1); Cai_L{i} = y_L{i}(:,6); 
            INaf_L{i} = currents_L{i}(:,1); INaL_L{i} = currents_L{i}(:,2); Ito_L{i} = currents_L{i}(:,3); ICaL_L{i} = currents_L{i}(:,4); IKr_L{i} = currents_L{i}(:,5); IKs_L{i} = currents_L{i}(:,6); IK1_L{i} = currents_L{i}(:,7);
        end
        save(strcat(out_folder,'/',type),'t_L','V_L','Cai_L','ICaL_L','INaf_L','INaL_L','Ito_L','IKr_L','IKs_L','IK1_L','Y_init');
    elseif h==4
        type = 'delKPQ_empa';
        Title = '\Delta{}KPQ + empa';
        g_Na = 3.0;
        [t,y,currents,t_L,y_L,currents_L,Y_init] = runORd(type, g_Na, rhs_model);
        for i = 1:length(t_L)
            V_L{i} = y_L{i}(:,1); Cai_L{i} = y_L{i}(:,6); 
            INaf_L{i} = currents_L{i}(:,1); INaL_L{i} = currents_L{i}(:,2); Ito_L{i} = currents_L{i}(:,3); ICaL_L{i} = currents_L{i}(:,4); IKr_L{i} = currents_L{i}(:,5); IKs_L{i} = currents_L{i}(:,6); IK1_L{i} = currents_L{i}(:,7);
        end
        save(strcat(out_folder,'/',type),'t_L','V_L','Cai_L','ICaL_L','INaf_L','INaL_L','Ito_L','IKr_L','IKs_L','IK1_L','Y_init');
    else
        type='R225Q_empa';
        Title = 'R225Q + empa';
        g_Na = 3.0*2;
        [t,y,currents,t_L,y_L,currents_L,Y_init] = runORd(type, g_Na, rhs_model);
        for i = 1:length(t_L)
            V_L{i} = y_L{i}(:,1); Cai_L{i} = y_L{i}(:,6); 
            INaf_L{i} = currents_L{i}(:,1); INaL_L{i} = currents_L{i}(:,2); Ito_L{i} = currents_L{i}(:,3); ICaL_L{i} = currents_L{i}(:,4); IKr_L{i} = currents_L{i}(:,5); IKs_L{i} = currents_L{i}(:,6); IK1_L{i} = currents_L{i}(:,7);
        end
        save(strcat(out_folder,'/',type),'t_L','V_L','Cai_L','ICaL_L','INaf_L','INaL_L','Ito_L','IKr_L','IKs_L','IK1_L','Y_init');
    end
    clearvars -except rhs_model out_folder
end

function[T,Y,currents,T_long,Y_long,currents_long,Y_init] = runORd(type, g_Na, rhs_model)
    [param, param_names] = get_ORd_parameters(type);
    param(strcmp(param_names,'g_Na')) = g_Na;
  
    % Set up initial conditions
    [states, state_names] = get_ORd_states(param);
    
    % Run to steady state without stimulation
    Tstop = 1000;  % simulation time
    options = [];
    [T_init, Y_init] = ode15s(rhs_model, [0, Tstop], states, options, param, param_names);
    
    % Run with stimulation
    Tstop = 1000;  % simulation time
    
    param(strcmp(param_names,'stim_amp')) = -80;
    param(strcmp(param_names,'stim_duration')) = 0.5;
    param(strcmp(param_names,'stim_start')) = 50;
    
    % Steady state simulation
%     for i = 1:500 
%         options = odeset(MaxStep=1,RelTol=1e-5);
%         [T{i}, Y{i}] = ode15s(rhs_model, [0, Tstop], Y_init(end,:), options, param, param_names);
%         Y_init = Y{i}(end,:);
%         for j = 1:length(T{i})
%             param(strcmp(param_names,'ODE')) = 0;
%             currents{i}(j,:) = rhs_model(T{i}(j),Y{i}(j,:),param,param_names);
%         end
%         param(strcmp(param_names,'ODE')) = 1;
%     end

    % High resolution simulation for plotting
    for i = 1:10 
        options = odeset(MaxStep=0.01,RelTol=1e-5);
        [T_long{i}, Y_long{i}] = ode15s(rhs_model, [0, Tstop], Y_init(end,:), options, param, param_names);
        Y_init = Y_long{i}(end,:);
        for j = 1:length(T_long{i})
            param(strcmp(param_names,'ODE')) = 0;
            currents_long{i}(j,:) = rhs_model(T_long{i}(j),Y_long{i}(j,:),param,param_names);
        end
        param(strcmp(param_names,'ODE')) = 1;
    end

    T = T_long{10};
    Y = Y_long{10};
    currents = currents_long{10};
end

