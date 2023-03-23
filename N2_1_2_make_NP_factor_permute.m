

clear;clc;close all

model_path  = 'CPM_permute';
model_name = {'_SST_stopsuc.mat','_SST_stopfai.mat' ...
        'SST_gowrong.mat','feed_miss.mat','feed_hit.mat' ...
        'antici_hit.mat','EFT_neutral.mat','EFT_angry.mat'};
 
name = {'SST:stop success','SST:stop failure','SST:go wrong',...
       'MID:feedmiss','MID:feedhit','MID: antici hit', ...
       'EFT:neutral','EFT:angry'};

number=[3 1 4 7 2 5 6 8];
dis_names  = {'asd','adhd','cd' ,'od','anxiety','dep','eat','speph'};

model_id = {'SST_stop_sucess_CPM_Result_permute','SST_stop_failure_CPM_Result_permute','SST_gowrong_CPM_Result_permute', ...               
            'BL_MID_feed_miss_CPM_Result_permute','MID_feed_hit_CPM_Result_permute','MID_antici_hit_CPM_Result_permute', ...
            'EFT_neutral_CPM_Result_permute','EFT_angry_CPM_Result_permute' };
for k = 1:8  
    
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
    
    p =0;
    for m = 1:8
        for n =1:8
            if m~=n
            p = p+1;
            disp(p)
            net_1_pos = net_pos_permu{m};net_2_pos = net_pos_permu{n};
            net_1_neg = net_neg_permu{m};net_2_neg = net_neg_permu{n};
            
            pos_pos = cellfun(@(x,y) length(intersect(x,y)),net_1_pos,net_2_pos,'un',1);
            pos_neg = cellfun(@(x,y) length(intersect(x,y)),net_1_pos,net_2_neg,'un',1);
            neg_neg = cellfun(@(x,y) length(intersect(x,y)),net_1_neg,net_2_neg,'un',1);
            neg_pos = cellfun(@(x,y) length(intersect(x,y)),net_1_neg,net_2_pos,'un',1);
            
            all_perm(:,p)  = (pos_pos+pos_neg+neg_neg+neg_pos)';
            same_perm(:,p) = (pos_pos + neg_neg)';
            oppo_perm(:,p) = (pos_neg + neg_pos)';
            
            pos_pos_num(:,p) = pos_pos;
            pos_neg_num(:,p) = pos_neg;
            neg_neg_num(:,p) = neg_neg;
            neg_pos_num(:,p) = neg_pos;
            
            end
        end
    end
    
end
