

clear;clc;close all

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
    
    Overlapped_perm_all(:,k)  = sum(all_perm,2)/2;
    Overlapped_perm_same(:,k) = sum(same_perm,2)/2;
    Overlapped_perm_oppo(:,k) = sum(oppo_perm,2)/2;
    
    Exter_PosPos(:,k) = sum(pos_pos_num(:,exter_mask),2);
    Inter_PosPos(:,k) = sum(pos_pos_num(:,inter_mask),2);
    Exter_NegNeg(:,k) = sum(neg_neg_num(:,exter_mask),2);
    Inter_NegNeg(:,k) = sum(neg_neg_num(:,inter_mask),2);
    
    Trans_PosPos(:,k) = sum(pos_pos_num(:,across_mask),2);
    Trans_NegNeg(:,k) = sum(pos_pos_num(:,across_mask),2);
    Trans_PosNeg(:,k) = sum(pos_neg_num(:,across_mask),2);
    Trans_NegPos(:,k) = sum(neg_pos_num(:,across_mask),2);
    
end

Exter_samesite = Exter_PosPos + Exter_NegNeg;
Inter_samesite = Inter_PosPos + Inter_NegNeg;
Trans_samesite = Trans_PosPos + Trans_NegNeg;
Trans_opposite = Trans_PosNeg + Trans_NegPos;



load('A2_1_1_Network_P_factor.mat')

% correct Table S4 
TableS4_1.num_all_p = sum(TableS4_1.num_all' < Overlapped_perm_all)'/1000;
TableS4_1.num_same_p  = sum(TableS4_1.num_same' < Overlapped_perm_same)'/1000;
TableS4_1.num_oppo_p  = sum(TableS4_1.num_oppo' < Overlapped_perm_oppo)'/1000;

TableS4_1.num_all_ErichScore = (TableS4_1.num_all./mean(Overlapped_perm_all)');
TableS4_1.num_same_ErichScore = (TableS4_1.num_same./mean(Overlapped_perm_all)');
TableS4_1.num_oppo_ErichScore = (TableS4_1.num_oppo./mean(Overlapped_perm_all)');
TableS4_1 = TableS4_1(:,[1 2 5 8 3 6 9 4 7 10]);

num = [1 2 5 6];
Pmatrix = ones(4,4);
NumMatrix = zeros(4,4);
REscoreDiff = zeros(4,4);
for i=1:4
   for j=1:4
       if i>j
        num1 = TableS4_1.num_all(num(i)); num2 = TableS4_1.num_all(num(j));
        Pmatrix(i,j) = sum(abs((num1-num2))< abs((Overlapped_perm_all(:,num(i)) - Overlapped_perm_all(:,num(j)))))/1000;
        NumMatrix(i,j) = abs(num1-num2);
        REscoreDiff(i,j) = TableS4_1.num_all_ErichScore(num(i))-TableS4_1.num_all_ErichScore(num(j));
       end
   end
end

REscore_Diff = mean(TableS4_1.num_all_ErichScore(num([1 2]))) - mean(TableS4_1.num_all_ErichScore(num([3 4]))) ;
REedge_Diff =  abs(mean(TableS4_1.num_all(num([1 2])))- mean(TableS4_1.num_all(num([3 4]))));
REedge_Diff_P = sum(REedge_Diff< abs(mean(Overlapped_perm_all(:,num([1 2])),2) - mean(Overlapped_perm_all(:,num([3 4])),2)))/1000;


% correct Table S5
Net1 = {Exter_samesite,Inter_samesite,Trans_samesite,Trans_opposite};
TableS5.MeanValueREscore      = xic_EVscore_permute_net([1 2 5 6],[TableS5.Mean_value, Net1]);
TableS5.SST_StopSucessREscore = xic_EVscore_permute_net([1],[TableS5.SST_stop_sucess, Net1]);
TableS5.SST_StopFailureREscore= xic_EVscore_permute_net([2],[TableS5.SST_stop_failure, Net1]);
TableS5.MID_FeedhitREscore    = xic_EVscore_permute_net([5],[TableS5.MID_feedhit, Net1]);
TableS5.MID_AnticipREscore    = xic_EVscore_permute_net([6],[TableS5.MID_anticip, Net1]);

TableS5.Mean_P      = xic_P_permute_net([1 2 5 6],[TableS5.Mean_value, Net1]);
TableS5.SST_StopSucess_P = xic_P_permute_net([1],[TableS5.SST_stop_sucess, Net1]);
TableS5.SST_StopFailure_P= xic_P_permute_net([2],[TableS5.SST_stop_failure, Net1]);
TableS5.MID_Feedhit_P    = xic_P_permute_net([5],[TableS5.MID_feedhit, Net1]);
TableS5.MID_Anticip_P    = xic_P_permute_net([6],[TableS5.MID_anticip, Net1]);
                  
TableS5 = TableS5(:,[1 2 3 8 13 4 9 14 5 10 15 6 11 16 7 12 17]);

% correct Table S6
Net1 = {Exter_PosPos,Exter_NegNeg,Inter_PosPos,Inter_NegNeg,Trans_PosNeg,Trans_NegPos,Trans_PosPos,Trans_NegNeg};

TableS6_across = TableS6.TableS6_across;

TableS6.TableS6_across.Mean_EVscore = xic_EVscore_permute([1 2 5 6],[TableS6_across.Mean_value, Net1]);       
TableS6.TableS6_across.SST_stop_sucess_EVscore = xic_EVscore_permute([1],[TableS6_across.SST_stop_sucess_num, Net1]);       
TableS6.TableS6_across.SST_stop_failure_EVscore = xic_EVscore_permute([2],[TableS6_across.SST_stop_failure_num,  Net1]);   
TableS6.TableS6_across.MID_feedhit_EVscore = xic_EVscore_permute([5],[TableS6_across.MID_feedhit_num,Net1]);   
TableS6.TableS6_across.MID_anticip_EVscore = xic_EVscore_permute([6],[TableS6_across.MID_anticip_num, Net1]);   

TableS6.TableS6_across.Mean_P = xic_P_permute([1 2 5 6],[TableS6_across.Mean_value, Net1]);
TableS6.TableS6_across.SST_stop_sucess_P = xic_P_permute([1],[TableS6_across.SST_stop_sucess_num, Net1]);
TableS6.TableS6_across.SST_stop_failure_P = xic_P_permute([2],[TableS6_across.SST_stop_failure_num, Net1]);
TableS6.TableS6_across.MID_feedhit_P = xic_P_permute([5],[TableS6_across.MID_feedhit_num, Net1]);
TableS6.TableS6_across.MID_anticip_P = xic_P_permute([6],[TableS6_across.MID_anticip_num, Net1]);

TableS6.TableS6_across = TableS6.TableS6_across(:,[1 2 3 12 17 4 13 18 6 14 19 8 15 20 10 16 21 5 7 9 11]);

save A2_1_2_Network_P_factor_permute.mat same_way_all oppo_way_all neg_pos_all_dimension neg_neg_all_dimension ...
    pos_neg_all_dimension pos_pos_all_dimension  TableS4_1 TableS4_2 TableS5 TableS6 
 
