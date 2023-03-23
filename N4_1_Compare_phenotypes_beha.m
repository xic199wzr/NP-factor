

clear;clc


Value = table;  
Value.name = TableS10.cova_name;

% without gender
sub_fc   = TableS9_2.BL_FC_tale.subject;
fc_types = table2array(TableS9_2.BL_FC_tale(:,[2 3 5 6 7]));

load('Cova_subject_jia.mat')
[sub_cova,ind1,ind2] = intersect(cova_subject,sub_fc);

for j=1:5;[~,~,fc_Nogender(:,j)] = regress(fc_types(ind2,j),cova_data(ind1,1:9)); end
      
Value_Nogender = table;  
Value_Nogender.name = TableS10.cova_name;

for i=1:52
        sub = TableS10.cova_subject{i,1}; dat = TableS10.cova_data{i,1};  
                
        [~,ind1,ind2] = intersect(sub_cova,sub);
         Value_Nogender.Sample_N(i,1) = length(ind1);
        [Value_Nogender.share_pp_R(i,1), Value_Nogender.share_pp_P(i,1),Value_Nogender.share_pp_T(i,1)] = xic_corr(dat(ind2),fc_Nogender(ind1,4));  
end 

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
           [Value_NoPheno.share_pp_R(i,1), Value_NoPheno.share_pp_P(i,1),Value_NoPheno.share_pp_T(i,1)] = xic_corr(dat(ind2),fc_residual(ind1,4));
           
end 
% Value_Nogender([20 23],:)=[];




