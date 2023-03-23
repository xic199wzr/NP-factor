
clear;clc
addpath('/share/inspurStorage/home1/xic_fdu/project/IAMGEN_Develop_diagnostic_0814/Trans_diagnostic_p_facotr')

load('/home1/xic_fdu/project/IAMGEN_Develop_diagnostic_0814/Trans_diagnostic_p_facotr/A5_1_1_2_Network_FC.mat');
load('/home1/xic_fdu/project/IAMGEN/Match_control_subject_All things scale/Cova_subject_jia.mat')
load('A5_1_2_Prepare_phnotype_data.mat')
IQ     = cell2mat(TableS10.cova_data(9:10)');
IQ_sub = TableS10.cova_subject(9:10);

folder  = dir('/home1/xic_fdu/prs_noclump/Gwas_Chao/PRS_Mats/*.mat');


fc_sub   = TableS9_2.BL_FC_tale.subject;
fc_mat   = table2array(TableS9_2.BL_FC_tale(:,[2 3 5 6 7]));
fc_names = {'EXpp','EXnn','INnn','SHpp','SHpn'};

[PRS_FC_Nogender,fc_ind]   = xic_PRS_data_gender(folder,fc_sub,fc_mat,fc_names);

[r p] = corr(PRS_FC_Nogender.PRS_meanRis{16},PRS_FC_Nogender.FC_match_PP{16})

IMAGEN_IQ_PRS = PRS_FC_Nogender.PRS_meanRis{16}; IMAGEN_IQ_FC = PRS_FC_Nogender.FC_match_PP{16};
IMAGEN_ADHD_PRS = PRS_FC_Nogender.PRS_meanRis{4}; IMAGEN_ADHD_FC = PRS_FC_Nogender.FC_match_PP{4};
IMAGEN_Dep_PRS = PRS_FC_Nogender.PRS_meanRis{13}; IMAGEN_Dep_FC = PRS_FC_Nogender.FC_match_PP{13};
fc_sub_gene = fc_sub(fc_ind);
[~,ind] =rmoutliers(IMAGEN_Dep_PRS); 
IMAGEN_Dep_PRS = IMAGEN_Dep_PRS(ind==0);IMAGEN_Dep_FC = IMAGEN_Dep_FC(ind==0);
IMAGEN_ADHD_PRS = IMAGEN_ADHD_PRS(ind==0);IMAGEN_ADHD_FC = IMAGEN_ADHD_FC(ind==0);
IMAGEN_IQ_PRS = IMAGEN_IQ_PRS(ind==0);IMAGEN_IQ_FC = IMAGEN_IQ_FC(ind==0);
fc_sub_gene = fc_sub_gene(ind==0);
plot(IMAGEN_IQ_PRS,IMAGEN_IQ_FC,'.');lsline

[r p] = corr(IMAGEN_IQ_PRS,IMAGEN_IQ_FC)

% save A5_3_1_PRS.mat IMAGEN_IQ_PRS IMAGEN_IQ_FC  IMAGEN_ADHD_PRS IMAGEN_ADHD_FC IMAGEN_Dep_PRS IMAGEN_Dep_FC fc_sub_gene -v6


