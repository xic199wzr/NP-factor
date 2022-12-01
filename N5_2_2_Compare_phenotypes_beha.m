

clear;clc

load('A5_1_1_2_Network_FC.mat');
load('A5_1_2_Prepare_phnotype_data');


Value = table;  
Value.name = TableS10.cova_name;

% without gender

sub_fc   = TableS9_2.BL_FC_tale.subject;
fc_types = table2array(TableS9_2.BL_FC_tale(:,[2 3 5 6 7]));

load('/home1/xic_fdu/project/IAMGEN/Match_control_subject_All things scale/Cova_subject_jia.mat')
[sub_cova,ind1,ind2] = intersect(cova_subject,sub_fc);

for j=1:5;[~,~,fc_Nogender(:,j)] = regress(fc_types(ind2,j),cova_data(ind1,1:9)); end
      
Value_Nogender = table;  
Value_Nogender.name = TableS10.cova_name;

for i=1:52
        sub = TableS10.cova_subject{i,1}; dat = TableS10.cova_data{i,1};  
                
        [~,ind1,ind2] = intersect(sub_cova,sub);
         Value_Nogender.Sample_N(i,1) = length(ind1);
        [Value_Nogender.exter_pp_R(i,1), Value_Nogender.exter_pp_P(i,1),Value_Nogender.exter_pp_T(i,1)] = xic_corr(dat(ind2),fc_Nogender(ind1,1));
        [Value_Nogender.exter_nn_R(i,1), Value_Nogender.exter_nn_P(i,1),Value_Nogender.exter_nn_T(i,1)] = xic_corr(dat(ind2),fc_Nogender(ind1,2));
        [Value_Nogender.inter_nn_R(i,1), Value_Nogender.inter_nn_P(i,1),Value_Nogender.inter_nn_T(i,1)] = xic_corr(dat(ind2),fc_Nogender(ind1,3));
        [Value_Nogender.share_pp_R(i,1), Value_Nogender.share_pp_P(i,1),Value_Nogender.share_pp_T(i,1)] = xic_corr(dat(ind2),fc_Nogender(ind1,4));
        [Value_Nogender.share_pn_R(i,1), Value_Nogender.share_pn_P(i,1),Value_Nogender.share_pn_T(i,1)] = xic_corr(dat(ind2),fc_Nogender(ind1,5));
           
end 
% Value_Nogender([20 23],:)=[];

Value_Nogender.SharePP_exterPP_Ind = abs(Value_Nogender.share_pp_T) - abs(Value_Nogender.exter_pp_T) >0;
Value_Nogender.SharePP_Internn_Ind = abs(Value_Nogender.share_pp_T) - abs(Value_Nogender.inter_nn_T) >0;

% save A5_2_0_1_Compare_phenotypes_beha.mat  Value_Nogender


%% Regress Psychairc behavior


[BL_Exter_beha,BL_Inter_beha,BL_all_beha,BL_Pheno_sub] = xic_CPM_beha;


[sub_cova_2,ind1,ind2] = intersect(BL_Pheno_sub,sub_cova);

for j=1:5;[~,~,fc_residual(:,j)] = regress(fc_Nogender(ind2,j),[ones(length(sub_cova_2),1),BL_all_beha(ind1,:)]); end
      
Value_NoPheno = table;  
Value_NoPheno.name = TableS10.cova_name;

for i=1:52
        sub = TableS10.cova_subject{i,1}; dat = TableS10.cova_data{i,1};  
                
        [~,ind1,ind2] = intersect(sub_cova_2,sub);
         Value_NoPheno.Sample_N(i,1) = length(ind1);
        [Value_NoPheno.exter_pp_R(i,1), Value_NoPheno.exter_pp_P(i,1),Value_NoPheno.exter_pp_T(i,1)] = xic_corr(dat(ind2),fc_residual(ind1,1));
        [Value_NoPheno.exter_nn_R(i,1), Value_NoPheno.exter_nn_P(i,1),Value_NoPheno.exter_nn_T(i,1)] = xic_corr(dat(ind2),fc_residual(ind1,2));
        [Value_NoPheno.inter_nn_R(i,1), Value_NoPheno.inter_nn_P(i,1),Value_NoPheno.inter_nn_T(i,1)] = xic_corr(dat(ind2),fc_residual(ind1,3));
        [Value_NoPheno.share_pp_R(i,1), Value_NoPheno.share_pp_P(i,1),Value_NoPheno.share_pp_T(i,1)] = xic_corr(dat(ind2),fc_residual(ind1,4));
        [Value_NoPheno.share_pn_R(i,1), Value_NoPheno.share_pn_P(i,1),Value_NoPheno.share_pn_T(i,1)] = xic_corr(dat(ind2),fc_residual(ind1,5));
           
end 
% Value_Nogender([20 23],:)=[];

Value_NoPheno.SharePP_exterPP_Ind = abs(Value_NoPheno.share_pp_T) - abs(Value_NoPheno.exter_pp_T) >0;
Value_NoPheno.SharePP_Internn_Ind = abs(Value_NoPheno.share_pp_T) - abs(Value_NoPheno.inter_nn_T) >0;


%% SES

ses = load('/home1/xic_fdu/project/IAMGEN/Match_control_subject_All things scale/BL_Enviroment.mat');

[~,ind1,ind2] = intersect(sub_cova,ses.BL_enviroment_ses_stress_sub);

fc = fc_Nogender(ind1,4);
ses_dat = ses.BL_enviroment_ses_stress_all(ind2,:);

SES_Nogender = table;  
SES_Nogender.name = ses.BL_enviroment_ses_stress_label';

for i=1:4
    
     [SES_Nogender.share_pp_R(i,1), SES_Nogender.share_pp_P(i,1),SES_Nogender.share_pp_T(i,1)] = ...
                                            xic_corr(ses_dat(:,i),fc);  
end

% no pheno

[~,ind1,ind2] = intersect(sub_cova_2,ses.BL_enviroment_ses_stress_sub);

fc = fc_residual(ind1,4); 
ses_dat =  ses.BL_enviroment_ses_stress_dat(ind2,:);

SES_NoPhno = table;  
SES_NoPhno.name = ses.BL_enviroment_ses_stress_label';

for i=1:4
        
    [SES_NoPhno.share_pp_R(i,1), SES_NoPhno.share_pp_P(i,1),SES_NoPhno.share_pp_T(i,1)] = ...
                                            xic_corr(ses_dat(:,i),fc);  
end

%% income


SES_label = ses.SES_Label';
SES_label = strrep(SES_label,' ','_');
SES_label = strrep(SES_label,'-','_');
SES_label = strrep(SES_label,'/','_');
ses_dat = ses.BL_enviroment_ses_stress_all(:,:);
ses_sub = ses.BL_enviroment_ses_stress_sub;

[sub_cova_2,ind1,ind2] = intersect(ses_sub,sub_cova);

[~,~,ses_residual] = regress(ses_dat(ind1,1),[ones(length(sub_cova_2),1),fc_Nogender(ind2,4)]);


SES_Behav = table;  
SES_Behav.name = TableS10.cova_name;


for i=1:52
        sub = TableS10.cova_subject{i,1}; dat = TableS10.cova_data{i,1};  
              
       [~,ind1,ind2] = intersect(ses_sub,sub); 
       SES_Behav.Sample_N(i,1) = length(ind1); 
   for j=1:18
     [r,p,t] = xic_corr(dat(ind2),ses_dat(ind1,j));
     eval(['SES_Behav.SES_T_sym_',SES_label{j},'(i,1)=t;']);
   end
end 

IQ_ses = table2array(SES_Behav(10:11,2:end))';
IQ_ses_T = table;
IQ_ses_T.Label = SES_Behav.Properties.VariableNames(2:end)';
IQ_ses_T.IQ_fluen_Tvalue = IQ_ses(:,1);
IQ_ses_T.IQ_verbal_Tvalue = IQ_ses(:,2);
% single item

SES_FC =  table;
SES_FC.Label = SES_label;


[sub_cova_2,ind1,ind2,ind3] = xic_intersect(ses_sub,sub_cova,BL_Pheno_sub);

for j=1:18
     [r,p,t] = xic_corr(fc_Nogender(ind2,4),ses_dat(ind1,j));
     SES_FC.Rvalue_Neural(j,1) = r;
     SES_FC.Pvalue_Neural(j,1) = p;
     SES_FC.Tvalue_Neural(j,1) = t;
     
     [r,p,t] = xic_corr(ses_dat(ind1,j),mean(BL_all_beha(ind3,:),2));
     SES_FC.Rvalue_Symptom(j,1) = r;
     SES_FC.Pvalue_Symptom(j,1) = p;
     SES_FC.Tvalue_Symptom(j,1) = t;
     
     [r,p,t] = xic_corr(ses_dat(ind1,j),mean(BL_all_beha(ind3,1:4),2));
     SES_FC.Rvalue_Exter(j,1) = r;
     SES_FC.Pvalue_Exter(j,1) = p;
     SES_FC.Tvalue_Exter(j,1) = t;
     
     [r,p,t] = xic_corr(ses_dat(ind1,j),mean(BL_all_beha(ind3,5:8),2));
     SES_FC.Rvalue_Inter(j,1) = r;
     SES_FC.Pvalue_Inter(j,1) = p;
     SES_FC.Tvalue_Inter(j,1) = t;
end









