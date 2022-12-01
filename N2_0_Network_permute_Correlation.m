

clear;clc;close all

path  = '/home1/xic_fdu/project/IAMGEN_Develop_diagnostic_0814/CPM_permute';
cd(path)

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


% only echk the SST_stop_sucess


model_id = {'SST_stop_sucess_CPM_Result_permute','SST_stop_failure_CPM_Result_permute','SST_gowrong_CPM_Result_permute', ...               
            'BL_MID_feed_miss_CPM_Result_permute','MID_feed_hit_CPM_Result_permute','MID_antici_hit_CPM_Result_permute', ...
            'EFT_neutral_CPM_Result_permute','EFT_angry_CPM_Result_permute' };

for k = 1:8  
    
    models = dir(fullfile(path,['*',model_name{k}]));

    for i=1:8
    
        model_neg_r_all =[];
        model_pos_r_all =[];
        model_both_r_all =[];
    
        model_neg_all =[];
        model_pos_all =[];
        model_both_all =[];
    
        for j=1:6
        
            disp(['Disorder',num2str(k),'---','Condition',num2str(i),'--','Permute_component',num2str(j)])
            model = load(fullfile(models(1).folder,models(number(i)+ (j-1)*8).name));
            
            eval(['model_result = model.',model_id{k},';']);
            
            model_neg = model_result.permute_predict_neg;
            model_pos = model_result.permute_predict_pos;
            model_both = model_result.permute_predict_both;
    
            model_neg_r = mean(model_result.permute_r_neg,2);
            model_pos_r = mean(model_result.permute_r_pos,2);
            model_both_r = mean(model_result.permute_r_both,2);
    
            model_neg_all = [model_neg_all,model_neg];
            model_pos_all = [model_pos_all,model_neg];
            model_both_all = [model_both_all,model_neg];
        
            model_neg_r_all =[model_neg_r_all;model_neg_r];
            model_pos_r_all =[model_pos_r_all;model_pos_r];
            model_both_r_all =[model_both_r_all;model_both_r];
        end
    
    
        model1_pos_permu{i} = model_neg_all;
        model1_neg_permu{i} = model_pos_all;
        model1_all_permu{i} = model_both_all;
    
        model1_pos_permu_r{i} = model_neg_r_all;
        model1_neg_permu_r{i} = model_pos_r_all;
        model1_all_permu_r{i} = model_both_r_all;
   
  
    end
    

        [corr_i_j] = behavior_permute(model1_pos_permu,model1_neg_permu,model1_all_permu,...
        model1_pos_permu_r,model1_neg_permu_r,model1_all_permu_r);

        permute_finnal_mean(:,:,k) = mean(corr_i_j,3);
        permute_finnal_matrix{k} = (corr_i_j);
end


save A2_0_Mean_permute_behavior.mat permute_finnal_matrix permute_finnal_mean 



