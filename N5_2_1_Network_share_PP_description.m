

clear;clc
addpath('/share/inspurStorage/home1/xic_fdu/project/IAMGEN_Develop_diagnostic_0814/Trans_diagnostic_p_facotr');

% load('A5_1_1_2_Network_FC_V2.mat');

%% old file 
% load('A2_2_1_3_make_mask_specific.mat')


shen = load('/home1/xic_fdu/project/IAMGEN_Develop_diagnostic_0814/Trans_diagnostic_p_facotr/Shen_net_index.mat');
output = '/share/inspurStorage/home1/xic_fdu/project/IAMGEN_Develop_diagnostic_0814/Trans_diagnostic_p_facotr/NII_brain_results_V2';

load('A2_2_1_2_make_mask_across_single_v2.mat')

share_pp = oppo_pp_dimen{1} + oppo_pp_dimen{2}  + oppo_pp_dimen{3} +oppo_pp_dimen{4};


sum(reshape(share_pp,[],1)>0)

share_pp_net = share_pp + share_pp';

degree = sum(share_pp_net,2);


xic_shen_template(table2array(NodeDegree(:,i)),name{i},output);

%% individual roi

roi = zeros(268,1);
roi(127) = 1;
xic_shen_template(roi,'ROI_Share_pp_127.nii',output);
