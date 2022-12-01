

function [Matrix_name,BL_matrix_all,BL_subject,BL_subject_all,FU2_matrix_all,FU2_subject,Fu2_subject_all] = read_BL_FC
% load BL and FU2 FC data in four dimentions

Matrix_name = {'SST_stop_sucess','SST_stop_failure','MID_feedback_hit','MID_antici_hit'};

disp(['Read BL Match SST CONN'])
load('/home1/xic_fdu/project/IMAGEN_Estimate_XIC/BL_Match_SST_CONN.mat');
BL_matrix_all{1} = reshape(BL_SST_stop_sucess,[],size(BL_SST_stop_sucess,3))';
BL_matrix_all{2} = reshape(BL_SST_stop_failure,[],size(BL_SST_stop_failure,3))';
clear BL_SST_stop_failure BL_SST_stop_sucess

disp(['Read BL Match MID CONN'])
load('/home1/xic_fdu/project/IMAGEN_Estimate_XIC/BL_Match_MID_CONN.mat');
BL_matrix_all{3} = reshape(BL_MID_feed_hit,[],size(BL_MID_feed_hit,3))';
BL_matrix_all{4} = reshape(BL_MID_antici_hit,[],size(BL_MID_antici_hit,3))';
clear BL_MID_feed_hit BL_MID_antici_hit


BL_subject{1} = BL_SST_subject;
BL_subject{2} = BL_SST_subject;
BL_subject{3} = BL_MID_subject;
BL_subject{4} = BL_MID_subject;

[~, a,b] = intersect(BL_subject{1},BL_subject{3});
[BL_subject_all] =[a,a,b,b];

% fu2
disp(['Read FU2 Match SST CONN'])
load('/home1/ISTBI_data/Data_MID/FU2_Match_SST_CONN_0523.mat')
FU2_matrix_all{1} = reshape(FU2_SST_stop_suces,[],size(FU2_SST_stop_suces,3))';
FU2_matrix_all{2} = reshape(FU2_SST_stop_failure,[],size(FU2_SST_stop_failure,3))';
clear FU2_SST_stop_suces FU2_SST_stop_failure

disp(['Read FU2 Match MID CONN'])
load('/home1/ISTBI_data/Data_MID/FU2_Match_MID_CONN_0523.mat')
FU2_matrix_all{3} = reshape(FU2_MID_feedhit,[],size(FU2_MID_feedhit,3))';
FU2_matrix_all{4} = reshape(FU2_MID_antici_hit,[],size(FU2_MID_antici_hit,3))';
clear FU2_MID_feedhit FU2_MID_antici_hit

FU2_subject{1} = FU2_SST_subject;
FU2_subject{2} = FU2_SST_subject;
FU2_subject{3} = FU2_MID_subject;
FU2_subject{4} = FU2_MID_subject;

[~, a1,b1] = intersect(FU2_subject{1},FU2_subject{3});
[Fu2_subject_all] =[a1,a1,b1,b1];