
 
 clear;clc

[BL_Exter_beha,BL_Inter_beha,BL_all_beha,BL_Pheno_residual_match_sub] = xic_CPM_beha;

load('Cova_subject_jia.mat')
[BL_subject_residual,ind1,ind2] = intersect(cova_subject,BL_Pheno_residual_match_sub);
[~,~,BL_Exter_beha_residual] = regress(BL_Exter_beha(ind2),cova_data(ind1,[1 9]));
[~,~,BL_Inter_beha_residual] = regress(BL_Inter_beha(ind2),cova_data(ind1,[1 9]));

for i=1:8
    [~,~,BL_residual(:,i)] = regress(BL_all_beha(ind2,i),cova_data(ind1,[1 9]));
end

load('Self_FU2_inter_exter.mat');
[FU2_subject_residual,ind1,ind2] = intersect(cova_subject,FU2_self.FU2_psy_match_sub);
[~,~,FU2_exter_residual] = regress(FU2_self.FU2_psy_exter(ind2),cova_data(ind1,1:9));
[~,~,FU2_inter_residual] = regress(FU2_self.FU2_psy_inter(ind2),cova_data(ind1,1:9));
[~,~,FU2_anxiety_residual] = regress(FU2_self.FU2_psy_match(ind2,5),cova_data(ind1,1:9));


% BL brain and BL behavior

Result_FC_BL_Task_sum = xic_FC_behavior_sum(BL_subject_match,BL_subject_residual,BL_FC_table,BL_Exter_beha_residual,BL_Inter_beha_residual,'BL_Task');
Result_FC_BL_Task = xic_FC_behavior(BL_subject_match,BL_subject_residual,BL_FC_table,BL_Exter_beha_residual,BL_Inter_beha_residual,'BL_Task');

Result_FC_BL_Task_sum_nogender = xic_FC_behavior_sum(BL_subject_match,BL_subject_residual,BL_FC_table,BL_Exter_beha_residual,BL_Inter_beha_residual,'BL_Task');

% BL brain and FU2 behavior
[FU2_BL_subject_residual,ind1,ind2] = intersect(BL_subject_residual,FU2_subject_residual);
[~,~,FU2_BL_exter_residual] = regress(FU2_exter_residual(ind2),[ones(length(ind1),1),BL_Exter_beha_residual(ind1)]);
[~,~,FU2_BL_inter_residual] = regress(FU2_inter_residual(ind2),[ones(length(ind1),1),BL_Inter_beha_residual(ind1)]);

Result_BLFC_FU2Behav_regress_sum = xic_FC_behavior_sum(BL_subject_match,FU2_BL_subject_residual,BL_FC_table,FU2_BL_exter_residual,FU2_BL_inter_residual,'BLFC_FU2Behav');
Result_BLFC_FU2Behav_regress = xic_FC_behavior(BL_subject_match,FU2_BL_subject_residual,BL_FC_table,FU2_BL_exter_residual,FU2_BL_inter_residual,'BLFC_FU2Behav');

Result_BLFC_FU2Behav_sum = xic_FC_behavior_sum(BL_subject_match,FU2_subject_residual,BL_FC_table,FU2_exter_residual,FU2_inter_residual,'BLFC_FU2Behav');
Result_BLFC_FU2Behav = xic_FC_behavior(BL_subject_match,FU2_subject_residual,BL_FC_table,FU2_exter_residual,FU2_inter_residual,'BLFC_FU2Behav');

% FU2 brain and FU2 behavior

Result_FC_FU2_Task_sum = xic_FC_behavior_sum(FU2_match_sub,FU2_subject_residual,FU2_Task_tale,FU2_exter_residual,FU2_inter_residual,'FU2_Task');
Result_FC_FU2_Task = xic_FC_behavior(FU2_match_sub,FU2_subject_residual,FU2_Task_tale,FU2_exter_residual,FU2_inter_residual,'FU2_Task');

Result_FC_FU2_Rest_sum = xic_FC_behavior_sum(FU2_rest_sub,FU2_subject_residual,FU2_Rest_tale,FU2_exter_residual,FU2_inter_residual,'FU2_Rest');
Result_FC_FU2_Rest = xic_FC_behavior(FU2_rest_sub,FU2_subject_residual,FU2_Rest_tale,FU2_exter_residual,FU2_inter_residual,'FU2_Rest');
Result_FC_FU2_Rest_sum_anxiety = xic_FC_behavior_sum(FU2_rest_sub,FU2_subject_residual,FU2_Rest_tale,FU2_exter_residual,FU2_anxiety_residual,'FU2_Rest');

% toghther


[~,ind1,ind2,ind3] = xic_intersect(FU2_match_sub,FU2_rest_sub,FU2_subject_residual);

FU2_task = FU2_Task_tale.oppo_pp(ind1,:);
FU2_rest = FU2_Rest_tale.oppo_pp(ind2,:);
FU2_inter = FU2_inter_residual(ind3);
FU2_exter = FU2_exter_residual(ind3);
FU2_anxiety = FU2_anxiety_residual(ind3);

rest_nan = isnan(FU2_rest);
FU2_task = FU2_task(rest_nan==0);
FU2_rest = FU2_rest(rest_nan==0);
FU2_inter = FU2_inter(rest_nan==0);
FU2_exter = FU2_exter(rest_nan==0);
FU2_anxiety = FU2_anxiety(rest_nan==0);

% combine the BL, FU2, Rest matched results
Result_FC     = [Result_BLFC_FU2Behav_regress,Result_FC_FU2_Task(:,2:5),Result_FC_FU2_Rest(:,2:5)];
Result_FC_sum = [Result_BLFC_FU2Behav_regress_sum,Result_FC_FU2_Task_sum(:,2:5),Result_FC_FU2_Rest_sum(:,2:5)];

TableS9_4.Result_FC_matched     = Result_FC;
TableS9_4.Result_FC_sum_matched = Result_FC_sum;

TableS9_4.Result_BLFC_FU2Behav     = Result_BLFC_FU2Behav;
TableS9_4.Result_BLFC_FU2Behav_sum = Result_BLFC_FU2Behav_sum;

TableS9_4.Result_BLFC_FU2Behav_regress     = Result_BLFC_FU2Behav_regress;
TableS9_4.Result_BLFC_FU2Behav_regress_sum = Result_BLFC_FU2Behav_regress_sum;

%% compare the changes
[all,ind1,ind2] = intersect(BL_FC_table.subject,FU2_Task_tale.subject);
BL_FC = table2array(BL_FC_table(ind1,2:end));
FU2_FC = table2array(FU2_Task_tale(ind2,2:end));
[~,~,~,fctvalue] = ttest(BL_FC,FU2_FC);

[~,ind1,ind2,ind3] = xic_intersect(BL_Pheno_residual_match_sub,FU2_self.FU2_psy_match_sub,all);
Fu2_exter = FU2_self.FU2_psy_exter(ind2);
Fu2_inter = FU2_self.FU2_psy_inter(ind2);
BL_exter  = BL_Exter_beha(ind1);
BL_inter  = BL_Inter_beha(ind1);

[R_exter,P_exter] = corr(FU2_FC(ind3,:)-BL_FC(ind3,:),Fu2_exter-BL_exter);
[R_inter,P_inter] = corr(FU2_FC(ind3,:)-BL_FC(ind3,:),Fu2_inter-BL_inter);

FC_change = table;
FC_change.fc_name = BL_FC_table.Properties.VariableNames(2:end)';
FC_change.Tvalue  = fctvalue.tstat';
FC_change.R_exter = R_exter;
FC_change.P_exter = P_exter;
FC_change.R_inter = R_inter;
FC_change.P_inter = P_inter;


