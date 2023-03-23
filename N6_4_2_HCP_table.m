
clear; clc

load('N5_4_1_HCP_FC.mat')
hcp = load('/share/inspurStorage/home1/ISTBI_data/HCP/HCP_3T_Rest_Denoised/Phenotyp_HCP.mat');

sub = cellfun(@(x) str2double(x),Control_FC{1,2},'un',1);

[all,ind1,ind2] = intersect(sub,hcp.suject_pheotype);

fc_mat = table2array(Control_FC{1,1});
fc_mat_m = fc_mat(ind1,:);
pheno  = hcp.Disorder(ind2,:);

FC_type = Control_FC{1,1}.Properties.VariableNames';
Pheno_ids = {'Adh','Antis','Anxiety','Avod','Depress','Som','Hyper','Inattetion'};
%% regress covariates
for i=1:size(pheno,2)
    [a,b,pheno_residual(:,i)] = regress(pheno(:,i),[ones(length(pheno),1),hcp.covariate(ind2,2:end)]);
end

[r,p]  = corr(fc_mat_m,pheno_residual,'row','complete');
Pvalue = array2table(p);
Pvalue.Properties.VariableNames = Pheno_ids';
Pvalue.FCtype = FC_type;

[r,p]  = corr(fc_mat_m(:,5),mean(pheno_residual(:,[1 7 8]),2),'row','complete');

%% age information
load('/share/inspurStorage/home1/ISTBI_data/HCP/HCP_pheno_data.mat');

hcp_info.id = RESTRICTEDweicheng730201715151.Subject;
hcp_info.age = RESTRICTEDweicheng730201715151.Age_in_Yrs;

[~,ind1,ind2] = intersect(all,hcp_info.id);
hcp_age = hcp_info.age(ind2);

mean(hcp_age)
std(hcp_age)

