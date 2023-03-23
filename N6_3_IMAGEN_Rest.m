

 clear;clc
 load('A5_1_1_2_Network_FC.mat');
 
 BL_FC_table   = TableS9_2.BL_FC_tale;
 FU2_Task_tale = TableS9_2.FU2_Task_tale;
 FU2_Rest_tale = TableS9_2.FU2_Rest_tale;
 BL_subject_match  = table2array(TableS9_2.BL_FC_tale(:,1));
 FU2_match_sub = table2array(TableS9_2.FU2_Task_tale(:,1));
 FU2_rest_sub      = table2array(TableS9_2.FU2_Rest_tale(:,1));
  Label = FU2_Rest_tale.Properties.VariableNames;


 
  %% FU2 task and FU2 rest
  [~,ind1,ind2] = intersect(FU2_Rest_tale.subject,FU2_Task_tale.subject);
 
 FU2_rest = table2array(FU2_Rest_tale(ind1,2:end));
 FU2_Task = table2array(FU2_Task_tale(ind2,2:end));
  nan = sum(isnan(FU2_rest),2);
  
 [r,p] = corr(FU2_rest(nan==0,:),FU2_Task(nan==0,:));

 %% BL task and FU2 Task
  
   [~,ind1,ind2] = intersect(BL_FC_table.subject,FU2_Task_tale.subject);
 
 BL_Task  = table2array(BL_FC_table(ind1,2:end));
 FU2_Task = table2array(FU2_Task_tale(ind2,2:end));
  nan = sum(isnan(FU2_rest),2);
  
 [r,p] = corr(BL_Task(nan==0,:),FU2_Task(nan==0,:));

 %% 
 
 load('Self_FU2_inter_exter.mat');
 load('/home1/xic_fdu/project/IAMGEN/Match_control_subject_All things scale/Cova_subject_jia.mat')

[FU2_subject_residual,ind1,ind2] = intersect(cova_subject,FU2_self.FU2_psy_match_sub);
[~,~,FU2_exter_residual] = regress(FU2_self.FU2_psy_exter(ind2),cova_data(ind1,1:9));
[~,~,FU2_inter_residual] = regress(FU2_self.FU2_psy_inter(ind2),cova_data(ind1,1:9));

[~,ind1,ind2,ind3] = xic_intersect(FU2_subject_residual,FU2_Rest_tale.subject,FU2_Task_tale.subject);

FU2_in   = FU2_inter_residual(ind1,:);
FU2_Rest = table2array(FU2_Rest_tale(ind2,2:end));
FU2_Task = table2array(FU2_Task_tale(ind3,2:end));

nan = sum(isnan(FU2_Rest),2);
[R P] = partialcorr(FU2_in(nan==0),FU2_Rest(nan==0,5),FU2_Task(nan==0,5));
[R P] = corr(FU2_in(nan==0),FU2_Rest(nan==0,4));




