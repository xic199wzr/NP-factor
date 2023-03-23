
%% First, Estimate the task-based connectome for eight task conditions with the CONN v16 batch with the shen-268 template
% code for task-based connectome estimation: .\functions\xic_conn_batch.m

%% Second, we used the CPM-master function to predict each of the eight psychiatric symptoms with task-based connectomes
% code for brain-behavior prediction:.\functions\CPM-master
% using the default threshold p = 0.01, linear regression 
% the significance level was set as 0.05/8/8 with Bonferroni correction

%% Thrid, we conducted the cross-disorder network for each task condition 
% the edge was both predictive to externalising and internalising symptoms

