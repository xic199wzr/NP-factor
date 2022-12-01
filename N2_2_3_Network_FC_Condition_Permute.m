

clear;clc;close all


addpath(genpath('/home1/xic_fdu/xic_analysis/xic_cpm'))

model_path  = '/home1/xic_fdu/project/IAMGEN_Develop_diagnostic_0814/CPM_permute';

model_name = {'_SST_stopsuc.mat','_SST_stopfai.mat' ...
        'SST_gowrong.mat','feed_miss.mat','feed_hit.mat' ...
        'antici_hit.mat','EFT_neutral.mat','EFT_angry.mat'};
 
name = {'SST:stop success','SST:stop failure','SST:go wrong',...
       'MID:feedmiss','MID:feedhit','MID: antici hit', ...
       'EFT:neutral','EFT:angry'};

load('/home1/xic_fdu/project/IAMGEN_Develop_diagnostic_0814/MyColormaps.mat')

number=[3 1 4 7 2 5 6 8];
dis_names  = {'asd','adhd','cd' ,'od','anxiety','dep','eat','speph'};
  
load('/home1/xic_fdu/project/IAMGEN_Develop_diagnostic_0814/Trans_diagnostic_p_facotr/A2_0_Mean_brain_behavior.mat')



model_id = {'SST_stop_sucess_CPM_Result_permute','SST_stop_failure_CPM_Result_permute','SST_gowrong_CPM_Result_permute', ...               
            'BL_MID_feed_miss_CPM_Result_permute','MID_feed_hit_CPM_Result_permute','MID_antici_hit_CPM_Result_permute', ...
            'EFT_neutral_CPM_Result_permute','EFT_angry_CPM_Result_permute' };

exter_mask = [1 2 3 9 10 17];
inter_mask = [33 34 35 41 42 49];
across_mask = [4:7 11:14 18:21 25:28]; % Internal > External

% permute edges

for k = 1:8  
    
    models = dir(fullfile(model_path,['*',model_name{k}]));

    for i=1:8
    
        net_pos_all = {}; R_pos = []; Predict_pos=[];
        net_neg_all = {}; R_neg = []; Predict_neg=[];
        clear model
        for j=1:6
        
           disp(['CogDimension',num2str(k),'---','Symptom',num2str(i),'--','Permute_component',num2str(j)])
           disp(models(number(i)+ (j-1)*8).name);
            model = load(fullfile(model_path,models(number(i)+ (j-1)*8).name));
           
            eval(['model_result = model.',model_id{k},';']);
            
            net_pos = model_result.pos_mask;
            net_neg = model_result.neg_mask;
            net_pos_all = [net_pos_all,net_pos];
            net_neg_all = [net_neg_all,net_neg];
            R_pos   = [R_pos;mean(model_result.permute_r_pos,2)];
            R_neg   = [R_neg;mean(model_result.permute_r_neg,2)];
            R_both  = [R_neg;mean(model_result.permute_r_both,2)];
            
            Predict_pos   = [Predict_pos,model_result.permute_predict_pos];
            Predict_neg   = [Predict_neg,model_result.permute_predict_neg];
            Predict_both  = [Predict_neg,model_result.permute_predict_both];
            
            model_name_id{j,i} = models(number(i)+ (j-1)*8).name;
        end 
        
        net_pos_permu{i} = net_pos_all;
        net_neg_permu{i} = net_neg_all;
        
        Perm_R_pos{i}  = R_pos;  Perm_Prdict_pos{i}  = Predict_pos; 
        Perm_R_neg{i}  = R_neg;  Perm_Prdict_neg{i}  = Predict_neg; 
        Perm_R_both{i} = R_both; Perm_Prdict_both{i} = Predict_both;
        
    end
    
    
   % overlap 
    p =0;
    for m = 1:8
         for n =1:8
             if m~=n
             p = p+1;
            disp([m,n])
            
            net_1_pos = net_pos_permu{m};net_1_neg = net_neg_permu{m};
            net_2_pos = net_pos_permu{n};net_2_neg = net_neg_permu{n};
            
            pos_pos = cellfun(@(x,y) (intersect(x,y)),net_1_pos,net_2_pos,'un',0)';
            pos_neg = cellfun(@(x,y) (intersect(x,y)),net_1_pos,net_2_neg,'un',0)';
            neg_neg = cellfun(@(x,y) (intersect(x,y)),net_1_neg,net_2_neg,'un',0)';
            neg_pos = cellfun(@(x,y) (intersect(x,y)),net_1_neg,net_2_pos,'un',0)';
            
            pos_pos_all(:,p)= pos_pos';
            pos_neg_all(:,p)= pos_neg';
            neg_neg_all(:,p)= neg_neg';
            neg_pos_all(:,p)= neg_pos';
            
            end
        end
    end
    
    % condition 
    
        Perm_R_pos_task{k}  = Perm_R_pos;  Perm_Prdict_pos_task{k}  = Perm_Prdict_pos; 
        Perm_R_neg_task{k}  = Perm_R_neg;  Perm_Prdict_neg_task{k}  = Perm_Prdict_neg; 
        Perm_R_both_task{k} = Perm_R_both; Perm_Prdict_both_task{k} = Perm_Prdict_both;
        Perm_Pos_edge{k}  = net_pos_permu;
        Perm_Neg_edge{k}  = net_neg_permu;
            
    for j = 1:1000
        disp([k,j])
        Exter_pospos{j,k} = unique(cell2mat(pos_pos_all(j,exter_mask)));
        Exter_NegNeg{j,k} = unique(cell2mat(neg_neg_all(j,exter_mask)));
        Inter_NegNeg{j,k} = unique(cell2mat(neg_neg_all(j,inter_mask)));
        
        Share_PosPos{j,k} = unique(cell2mat(pos_pos_all(j,across_mask)));
        Share_PosNeg{j,k} = unique(cell2mat(pos_neg_all(j,across_mask)));
        Share_NegPos{j,k} = unique(cell2mat(neg_pos_all(j,across_mask)));
              
    end
    
end

Dis_Perm.Perm_R_pos_task = Perm_R_pos_task;
Dis_Perm.Perm_R_neg_task = Perm_R_neg_task;
Dis_Perm.Perm_R_both_task = Perm_R_both_task;

Dis_Perm.Perm_Prdict_pos_task = Perm_Prdict_pos_task;
Dis_Perm.Perm_Prdict_neg_task = Perm_Prdict_neg_task;
Dis_Perm.Perm_Prdict_both_task = Perm_Prdict_both_task;
% permute FC

[Matrix_name,BL_matrix_all,BL_subject,BL_subject_all,FU2_matrix_all,FU2_subject,FU2_subject_all]= read_BL_FC;

condi = [1 2 5 6];

for k = 1:4
    fc_bl  = BL_matrix_all{k}; 
    fc_fu2 = FU2_matrix_all{k};
    
    conK = condi(k);
    pos_edg = Perm_Pos_edge{conK}; neg_edg = Perm_Neg_edge{conK};
    for z = 1:1000
    
    exter_pp_ind = Exter_pospos{k,conK};
    exter_nn_ind = Exter_NegNeg{k,conK};
    inter_nn_ind = Inter_NegNeg{k,conK};
    
    share_pp_ind = Share_PosPos{k,conK};
    share_pn_ind = Share_PosNeg{k,conK};
    share_np_ind = Share_NegPos{k,conK};
    
    exter_pp_ind = setdiff([share_pp_ind,share_pn_ind],exter_pp_ind);
    exter_nn_ind = setdiff([share_np_ind],exter_nn_ind);
    inter_nn_ind = setdiff([share_pn_ind],inter_nn_ind);
   
    exter_pp_fc_bl(:,z) = sum(fc_bl(BL_subject_all(:,k),exter_pp_ind),2);
    exter_nn_fc_bl(:,z) = sum(fc_bl(BL_subject_all(:,k),exter_nn_ind),2);
    inter_nn_fc_bl(:,z) = sum(fc_bl(BL_subject_all(:,k),inter_nn_ind),2);
    share_pp_fc_bl(:,z) = sum(fc_bl(BL_subject_all(:,k),share_pp_ind),2);
    share_pn_fc_bl(:,z) = sum(fc_bl(BL_subject_all(:,k),share_pn_ind),2);    
    share_np_fc_bl(:,z) = sum(fc_bl(BL_subject_all(:,k),share_np_ind),2);
    
    exter_pp_fc_fu2(:,z)= sum(fc_fu2(FU2_subject_all(:,k),exter_pp_ind),2);
    exter_nn_fc_fu2(:,z)= sum(fc_fu2(FU2_subject_all(:,k),exter_nn_ind),2);
    inter_nn_fc_fu2(:,z)= sum(fc_fu2(FU2_subject_all(:,k),inter_nn_ind),2);
    share_pp_fc_fu2(:,z)= sum(fc_fu2(FU2_subject_all(:,k),share_pp_ind),2);
    share_pn_fc_fu2(:,z)= sum(fc_fu2(FU2_subject_all(:,k),share_pn_ind),2);    
    share_np_fc_fu2(:,z)= sum(fc_fu2(FU2_subject_all(:,k),share_np_ind),2);
        
    end
    
    for i=1:8
        for z = 1:1000
            disp([i,z])
            pos_fc(:,z) = sum(fc_bl(BL_subject_all(:,k),pos_edg{1, i}{z}),2);
            neg_fc(:,z) = sum(fc_bl(BL_subject_all(:,k),neg_edg{1, i}{z}),2);
        end
        pos_fc_dis{k,i} =pos_fc;
        neg_fc_dis{k,i} =pos_fc;
    end
    
    BL_FC_Permute.exter_pp_fc_bl_all{k} = exter_pp_fc_bl;
    BL_FC_Permute.exter_nn_fc_bl_all{k} = exter_nn_fc_bl;
    BL_FC_Permute.inter_nn_fc_bl_all{k} = inter_nn_fc_bl;
    BL_FC_Permute.share_pp_fc_bl_all{k} = share_pp_fc_bl;
    BL_FC_Permute.share_pn_fc_bl_all{k} = share_pn_fc_bl;
    BL_FC_Permute.share_np_fc_bl_all{k} = share_np_fc_bl;

    FU2_FC_Permute.exter_pp_fc_fu2_all{k} = exter_pp_fc_fu2;
    FU2_FC_Permute.exter_nn_fc_fu2_all{k} = exter_nn_fc_fu2;
    FU2_FC_Permute.inter_nn_fc_fu2_all{k} = inter_nn_fc_fu2;
    FU2_FC_Permute.share_pp_fc_fu2_all{k} = share_pp_fc_fu2;
    FU2_FC_Permute.share_pn_fc_fu2_all{k} = share_pn_fc_fu2;
    FU2_FC_Permute.share_np_fc_fu2_all{k} = share_np_fc_fu2;
end


Dis_FC.pos_fc_dis = pos_fc_dis;
Dis_FC.neg_fc_dis = neg_fc_dis;
% permute behavior

fc_psy_name = model_name_id(1,:)';

load('/home1/xic_fdu/project/IAMGEN_Develop_diagnostic_0814/BL_1Psycho_data_0912.mat')
load('/home1/xic_fdu/project/IAMGEN/Match_control_subject_All things scale/Cova_subject_jia.mat')
   
cova_data_all    = repmat({cova_data},9,1);
cova_subject_all = repmat({cova_subject},9,1);
subject = BL_psycho_subject{1};

for i=1:8;[subject] = intersect(BL_psycho_subject{i},subject); end

sub_permute = xic_permute_subIND;

psy_num = [3 1 4 7 2 5 6 8];
psy_nam = BL_psycho_name(psy_num)';


for k=1:1000
    for i=1:8
    disp([k i])
     [subject,ind1] = intersect(BL_psycho_subject{psy_num(i)},subject);
     phenotype_bl   = mean(BL_psycho_data{psy_num(i)},2); 
     phenotype_bl_match = phenotype_bl(ind1);
     [all_subject,ind1,ind2] = intersect(subject,cova_subject);
     phenotype_bl_residual   = zscore(xic_cpm_regress(phenotype_bl_match(ind1),cova_data(ind2,1:8)));
     phenotype_bl_permute(:,i) = phenotype_bl_residual(sub_permute(:,k));  
    end
    
     BL_Behav_Permute.exter_permute(:,k) = mean(phenotype_bl_permute(:,1:4),2);
     BL_Behav_Permute.inter_permute(:,k) = mean(phenotype_bl_permute(:,5:8),2);
     BL_Behav_Permute.dis_permute{k} = phenotype_bl_permute;
     
     for j =1:8
         eval(['BL_Behav_Permute.Dis_',psy_nam{j},'(:,k) = phenotype_bl_permute(:,j);']);
     end
end

BL_Behav_Permute.Subject = all_subject;

% check the effect of FC and behavior in permutation 
% the first  task dimentio, first disorder, first permutation
ind = Perm_Pos_edge{1, 1}{1, 1}{1, 1};
FC  = BL_matrix_all{1};
Sub = BL_subject{1};

[~,ind1,ind2] = intersect(all_subject,Sub);
FC_sum   = sum(FC(ind2,ind),2);
Phno_sum = BL_Behav_Permute.Dis_od(ind1);
[R,P] = corr(FC_sum,Phno_sum);

save A2_2_2_Network_FC_Condition_Permute.mat BL_FC_Permute FU2_FC_Permute BL_Behav_Permute Dis_Perm Dis_FC




































