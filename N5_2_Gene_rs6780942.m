%% data
clear;clc

snp = load('/home1/xic_fdu/prs_noclump/Gwas_Chao/Gwas_across_nature_neuro/SNP_dat_SNP3_IMAGEN.mat');

data_snp = struct2table(snp.snp_data_mat);
data_snp_mats = double(table2array(data_snp(:,8)));
data_snp_mats(data_snp_mats<0) = nan;
data_snp_label = data_snp.Properties.VariableNames(8)';
data_sub = double(snp.Sub);

data_sub(isnan(data_snp_mats)) =[];
data_snp_mats(isnan(data_snp_mats)) =[];

load('/home1/xic_fdu/project/IAMGEN_Develop_diagnostic_0814/Trans_diagnostic_p_facotr/A5_1_1_2_Network_FC_V2.mat');
BL_FC = TableS9_2.BL_FC_tale;
FC_mat = table2array(BL_FC(:,2:end));

load('/home1/xic_fdu/project/IAMGEN/Match_control_subject_All things scale/Cova_subject_jia.mat')
[sub_combine,ind1,ind2,ind3] = xic_intersect(cova_subject,BL_FC.subject,data_sub);

[~,~,FC_residual]= regress(FC_mat(ind2,5),cova_data(ind1,1:9));
[~,~,SNP_residual]= regress(data_snp_mats(ind3),cova_data(ind1,1:9));

[r p] = corr(data_snp_mats(ind3),FC_residual,'type','spearman')

figure(1)
snp = data_snp_mats(ind3);
fc = FC_mat(ind2,5);

plot(snp,FC_residual,'.'); lsline
xlim([-0.5,2.5])

save A5_4_gene.mat snp fc -v6



