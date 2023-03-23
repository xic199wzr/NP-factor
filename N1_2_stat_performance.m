

clear;clc

load('A1_1_Predict_performance.mat','TableS1')

Both_filt = table2array(TableS1.R_predict_both(:,2:7))>0.07;

Predict_pos = table2cell(TableS1.Predict_pos(:,2:7));  
Predict_neg = table2cell(TableS1.Predict_neg(:,2:7)); 
Predict_sub = table2cell(TableS1.Predict_sub(:,2:7)); 

[cog_sub_all,ind1,ind2] = intersect(Predict_sub{1,1},Predict_sub{1,4});
sub_all = [ind1,ind1,ind1,ind2,ind2,ind2];

[BL_Exter_beha,BL_Inter_beha,BL_all_beha,BL_Pheno_residual_match_sub] = xic_CPM_beha;
BL_beha_all = BL_Exter_beha+BL_Inter_beha;

[~,ind4,ind5] = intersect(cog_sub_all,BL_Pheno_residual_match_sub);

for i=1:8
   symp_predict_pos = [Predict_pos{i,1}(ind1),Predict_pos{i,2}(ind1),Predict_pos{i,3}(ind1), ...
                       Predict_pos{i,4}(ind2),Predict_pos{i,5}(ind2),Predict_pos{i,6}(ind2)];
 
   symp_predict_neg = [Predict_neg{i,1}(ind1),Predict_neg{i,2}(ind1),Predict_neg{i,3}(ind1), ...
                       Predict_neg{i,4}(ind2),Predict_neg{i,5}(ind2),Predict_neg{i,6}(ind2)];
                   
   symp_predict_both = symp_predict_pos+symp_predict_neg;   
   
   symp_predict_all(:,i) = sum(symp_predict_both(:,Both_filt(i,:)),2);
   
   symp_predict{i} = symp_predict_both;
end

Result = table;
Result.name = {'Exteranl','Internal','All'}';
[Result.Rvalue(1), Result.Pvalue(1), Result.Tvalue(1),Result.N(1)] = xic_corr(sum(symp_predict_all(ind4,1:4),2),BL_Exter_beha(ind5));
[Result.Rvalue(2), Result.Pvalue(2), Result.Tvalue(2),Result.N(2)] = xic_corr(sum(symp_predict_all(ind4,5:8),2),BL_Inter_beha(ind5));
[Result.Rvalue(3), Result.Pvalue(3), Result.Tvalue(3),Result.N(3)] = xic_corr(sum(symp_predict_all(ind4,1:8),2),BL_beha_all(ind5));


% ADHD, CD, OD, SP, Anxiety, eating disorder after multiple correction
behav_adhd = BL_all_beha(ind5,2);
predict_adhd = symp_predict{2};
model = fitlm(predict_adhd,behav_adhd);

behav_asd = BL_all_beha(ind5,3);
predict_asd = symp_predict{3};  predict_asd = predict_asd(:,Both_filt(1,:)>0);
asd_cog = TableS1.Predict_neg.Properties.VariableNames([0,Both_filt(1,:)]>0)';
model = fitlm(predict_asd,behav_asd);


behav_cd = BL_all_beha(ind5,3);
predict_cd = symp_predict{3};  predict_cd = predict_cd(:,Both_filt(3,:)>0);
cd_cog = TableS1.Predict_neg.Properties.VariableNames([0,Both_filt(3,:)]>0)';

behav_od = BL_all_beha(ind5,4);
predict_od = symp_predict{4};  predict_od = predict_od(:,Both_filt(4,:)>0);
od_cog = TableS1.Predict_neg.Properties.VariableNames([0,Both_filt(4,:)]>0)';

behav_sp =  BL_all_beha(ind5,8);
predict_sp = symp_predict{8};  predict_sp = predict_sp(:,Both_filt(8,:)>0);
sp_cog = TableS1.Predict_neg.Properties.VariableNames([0,Both_filt(8,:)]>0)';
model = fitlm(predict_sp,behav_sp);

behav_anxiety =  BL_all_beha(ind5,5);
predict_anxiety = symp_predict{5};  predict_anxiety = predict_anxiety(:,Both_filt(5,:)>0);
anxiety_cog = TableS1.Predict_neg.Properties.VariableNames([0,Both_filt(5,:)]>0)';
model = fitlm(predict_anxiety,behav_anxiety);


behav_ed =  BL_all_beha(ind5,7);
predict_ed = symp_predict{7};  predict_ed = predict_ed(:,Both_filt(7,:)>0);
ed_cog = TableS1.Predict_neg.Properties.VariableNames([0,Both_filt(7,:)]>0)';
model = fitlm(predict_ed,behav_ed);

behav_dep =  BL_all_beha(ind5,6);
predict_dep = symp_predict{6};  predict_dep = predict_dep(:,Both_filt(6,:)>0);
dep_cog = TableS1.Predict_neg.Properties.VariableNames([0,Both_filt(6,:)]>0)';
model = fitlm(predict_dep,behav_dep);





