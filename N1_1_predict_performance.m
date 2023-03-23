

%% performance

clear;clc;close all
addpath('/share/inspurStorage/home1/xic_fdu/project/IAMGEN_Develop_diagnostic_0814/Trans_diagnostic_p_facotr')

cd('/share/inspurStorage/home1/xic_fdu/project/IAMGEN_Develop_diagnostic_0814/CPM_Models')
%% RDOC: 1 whether the predict results is specific

name = {'SST:stop success','SST:stop failure','SST:go wrong',...
       'MID:feedmiss','MID:feedhit','MID: antici hit', ...
       'EFT:neutral','EFT:angry'};

model_name = {'_SST_stopsuc.mat','_SST_stopfai.mat' ...
        'SST_gowrong.mat','feed_miss.mat','feed_hit.mat' ...
        'antici_hit.mat','EFT_neutral.mat','EFT_angry.mat'};
  
number=[4 2 5 7 3 1 6 8];

dis_names  = {'asd','adhd','cd' ,'od','anxiety','dep','eat','speph'};

[BL_Exter_beha,BL_Inter_beha,BL_Pheno_residual_match_sub] = xic_CPM_beha;

for  j = 1:8

    models = dir(fullfile('/CPM_Models/',['*',model_name{j}]));

    clear Pheno_predict

    for i = 1:length(models)

        disp([i,j])
  
        load(fullfile(models(i).folder,models(number(i)).name))

        R_pos_neg_both(1,i)= (CPM_Result.pos_r_mean);
        R_pos_neg_both(2,i)= (CPM_Result.neg_r_mean);
        R_pos_neg_both(3,i)= (CPM_Result.both_r_mean);
        R_subject(i,j) = length(CPM_Result.subject);
 
        R_predict_pos(j,i) = CPM_Result.pos_r_mean;
        R_predict_neg(j,i) = CPM_Result.neg_r_mean;
        R_predict_both(j,i) = CPM_Result.both_r_mean;
    end
end

