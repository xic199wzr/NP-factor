

clear;clc;close all

model_path  = '/home1/xic_fdu/project/IAMGEN_Develop_diagnostic_0814/CPM_permute';
model_name = {'_SST_stopsuc.mat','_SST_stopfai.mat','feed_hit.mat','antici_hit.mat'};


load('/home1/xic_fdu/project/IAMGEN_Develop_diagnostic_0814/Trans_diagnostic_p_facotr/A2_0_Mean_brain_behavior.mat')

model_id = {'SST_stop_sucess_CPM_Result_permute','SST_stop_failure_CPM_Result_permute', ...               
            'MID_feed_hit_CPM_Result_permute','MID_antici_hit_CPM_Result_permute'};

dis_names  = {'asd','adhd','cd' ,'od','anxiety','dep','eat','speph'};
number=[3 1 4 7 2 5 6 8];
 
exter_pp_net_all = zeros(55,1000);exter_pn_net_all = zeros(55,1000);
exter_np_net_all = zeros(55,1000);exter_nn_net_all = zeros(55,1000);

inter_pp_net_all = zeros(55,1000);inter_pn_net_all = zeros(55,1000);
inter_np_net_all = zeros(55,1000);inter_nn_net_all = zeros(55,1000);

oppo_pp_net_all = zeros(55,1000);oppo_pn_net_all = zeros(55,1000);
oppo_np_net_all = zeros(55,1000);oppo_nn_net_all = zeros(55,1000);

for k = 1:4  
    
    models = dir(fullfile(model_path,['*',model_name{k}]));
    for i=1:8
        
        net_pos_all = {};
        net_neg_all = {};
        for j=1:6
        
           disp(['CogDimension',num2str(k),'---','Symptom',num2str(i),'--','Permute_component',num2str(j)])
            model = load(fullfile(model_path,models(number(i)+ (j-1)*8).name));
            eval(['model_result = model.',model_id{k},';']);
            
            net_pos = model_result.pos_mask;
            net_neg = model_result.neg_mask;
            net_pos_all = [net_pos_all,net_pos];
            net_neg_all = [net_neg_all,net_neg];
        end
    
        net_pos_permu{i} = net_pos_all;
        net_neg_permu{i} = net_neg_all;
  
    end
    
    
    % external permute subset
    
    [exter_pp_net{k},exter_pn_net{k},exter_nn_net{k},exter_np_net{k}] = xic_perm_net(1:4,1:4,net_pos_permu,net_neg_permu);
    [inter_pp_net{k},inter_pn_net{k},inter_nn_net{k},inter_np_net{k}] = xic_perm_net(5:8,5:8,net_pos_permu,net_neg_permu);
    [oppo_pp_net{k},oppo_pn_net{k},oppo_nn_net{k},oppo_np_net{k}]     = xic_perm_net(1:4,5:8,net_pos_permu,net_neg_permu);
    
    exter_pp_net_all = exter_pp_net_all+exter_pp_net{k};exter_pn_net_all = exter_pn_net_all+exter_pn_net{k};
    exter_nn_net_all = exter_nn_net_all+exter_nn_net{k};exter_np_net_all = exter_np_net_all+exter_np_net{k};

    inter_pp_net_all = inter_pp_net_all+inter_pp_net{k};inter_pn_net_all = inter_pn_net_all+inter_pn_net{k};
    inter_nn_net_all = inter_nn_net_all+inter_nn_net{k};inter_np_net_all = inter_np_net_all+inter_np_net{k};
    
    oppo_pp_net_all = oppo_pp_net_all+oppo_pp_net{k};oppo_pn_net_all = oppo_pn_net_all+oppo_pn_net{k};
    oppo_nn_net_all = oppo_nn_net_all+oppo_nn_net{k};oppo_np_net_all = oppo_np_net_all+oppo_np_net{k};
end

Permute_All.oppo_pp_net_all = oppo_pp_net_all;Permute_All.oppo_nn_net_all = oppo_nn_net_all;
Permute_All.oppo_pn_net_all = oppo_pn_net_all;Permute_All.oppo_np_net_all = oppo_np_net_all;

Permute_All.exter_pp_net_all = exter_pp_net_all;Permute_All.exter_nn_net_all = exter_nn_net_all;
Permute_All.exter_pn_net_all = exter_pn_net_all;Permute_All.exter_np_net_all = exter_np_net_all;

Permute_All.inter_pp_net_all = inter_pp_net_all;Permute_All.inter_nn_net_all = inter_nn_net_all;
Permute_All.inter_pn_net_all = inter_pn_net_all;Permute_All.inter_np_net_all = inter_np_net_all;

Permute_All.exter_pp_net= exter_pp_net;Permute_All.exter_pn_net= exter_pn_net;
Permute_All.exter_nn_net= exter_nn_net;Permute_All.exter_np_net= exter_np_net;

Permute_All.inter_pp_net= inter_pp_net;Permute_All.inter_pn_net= inter_pn_net;
Permute_All.inter_nn_net= inter_nn_net;Permute_All.inter_np_net= inter_np_net;

Permute_All.oppo_pp_net= oppo_pp_net;Permute_All.oppo_pn_net= oppo_pn_net;
Permute_All.oppo_nn_net= oppo_nn_net;Permute_All.oppo_np_net= oppo_np_net;


save N3_1_1_Network_overlap_subnets_permute.mat Permute_All


