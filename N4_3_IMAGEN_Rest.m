

clear;clc
 load('/home1/xic_fdu/project/IAMGEN_Develop_diagnostic_0814/Trans_diagnostic_p_facotr/A5_1_1_2_Network_FC_V2.mat');

FU2_Rest_tale = TableS9_2.FU2_Rest_tale;
FU2_rest_sub      = table2array(TableS9_2.FU2_Rest_tale(:,1));
 
[BL_Exter_beha,BL_Inter_beha,BL_all_beha,BL_Pheno_residual_match_sub] = xic_CPM_beha;

load('/home1/xic_fdu/project/IAMGEN/Match_control_subject_All things scale/Cova_subject_jia.mat')


load('Self_FU2_inter_exter.mat');
[FU2_subject_residual,ind1,ind2] = intersect(cova_subject,FU2_self.FU2_psy_match_sub);
[~,~,FU2_exter_residual] = regress(FU2_self.FU2_psy_exter(ind2),cova_data(ind1,1:9));
[~,~,FU2_inter_residual] = regress(FU2_self.FU2_psy_inter(ind2),cova_data(ind1,1:9));
[~,~,FU2_anxiety_residual] = regress(FU2_self.FU2_psy_match(ind2,5),cova_data(ind1,1:9));


Result_FC_FU2_Rest_sum = xic_FC_behavior_sum(FU2_rest_sub,FU2_subject_residual,FU2_Rest_tale,FU2_exter_residual,FU2_inter_residual,'FU2_Rest');
Result_FC_FU2_Rest = xic_FC_behavior(FU2_rest_sub,FU2_subject_residual,FU2_Rest_tale,FU2_exter_residual,FU2_inter_residual,'FU2_Rest');
Result_FC_FU2_Rest_sum_anxiety = xic_FC_behavior_sum(FU2_rest_sub,FU2_subject_residual,FU2_Rest_tale,FU2_exter_residual,FU2_anxiety_residual,'FU2_Rest');


%% save brain data
[~,ind1,ind2] = intersect(FU2_rest_sub,FU2_subject_residual);
IMAGEN_FU2_Rest  = FU2_Rest_tale.oppo_pp(ind1);
IMAGEN_FU2_Exter = FU2_exter_residual(ind2);

IMAGEN_FU2_Exter(isnan(IMAGEN_FU2_Rest)) =[];
IMAGEN_FU2_Rest(isnan(IMAGEN_FU2_Rest)) =[];

save N4_3_IMAGEN_Rest.mat IMAGEN_FU2_Exter IMAGEN_FU2_Rest -v6
