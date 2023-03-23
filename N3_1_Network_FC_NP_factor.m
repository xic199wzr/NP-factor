
clear;clc
load('A2_2_1_3_make_mask_specific.mat')
tableS = load('A2_2_1_2_make_mask_across_single_v2.mat');
TableS7.TableS7_1_Across.SST_stopsucc_ind(10) = tableS.oppo_pp_dimen_ind(1);
TableS7.TableS7_1_Across.SST_stopfail_ind(10) = tableS.oppo_pp_dimen_ind(2);
TableS7.TableS7_1_Across.MID_feedhit_ind(10) = tableS.oppo_pp_dimen_ind(3);
TableS7.TableS7_1_Across.MID_anticihit_ind(10) = tableS.oppo_pp_dimen_ind(4);

across = TableS7.TableS7_1_Across;

[Matrix_name,BL_matrix_all,BL_subject,BL_subject_all,FU2_matrix_all,FU2_subject,FU2_subject_all]= read_BL_FC;
BL_subject_match = BL_subject{1}(BL_subject_all(:,1));
FU2_subject_match = FU2_subject{1}(FU2_subject_all(:,1));


name = {'SST_stopsucc';'SST_stopfail';'MID_feedhit';'MID_anticihit'};

Across_FC = table;
Across_FC.name = name;

Across_FC_mat = table;
Across_FC_mat.name = name;

load('/share/inspurStorage/home1/xic_fdu/project/IAMGEN_Develop_diagnostic_0814/Trans_diagnostic_p_facotr/FU2_shen_rest/Shen_Rest_matrix.mat');
fc_fu2_rest = reshape(FU2_matrix_rest,[],size(FU2_matrix_rest,3))';

for i=1:4
       fc_bl = BL_matrix_all{i}; 
       fc_fu2 = FU2_matrix_all{i};
       eval(['oppo_ind = unique([across.',[name{i},'_ind'],'{8,1}','; across.',[name{i},'_ind'],'{9,1};', ...
                                'across.',[name{i},'_ind'],'{10,1}','; across.',[name{i},'_ind'],'{11,1}]);']);
       
       eval( ['Across_FC.ex_pp_only_ind{i,1} = setdiff(across.',[name{i},'_ind'],'{2,1},oppo_ind);'] );
       eval( ['Across_FC.ex_nn_only_ind{i,1} = setdiff(across.',[name{i},'_ind'],'{3,1},oppo_ind);'] );
       eval( ['Across_FC.in_pp_only_ind{i,1} = setdiff(across.',[name{i},'_ind'],'{5,1},oppo_ind);'] );
       eval( ['Across_FC.in_nn_only_ind{i,1} = setdiff(across.',[name{i},'_ind'],'{6,1},oppo_ind);'] );
       
       eval( ['Across_FC.oppo_pn_ind{i,1}    = across.',[name{i},'_ind'],'{8,1};'] );
       eval( ['Across_FC.oppo_np_ind{i,1}    = across.',[name{i},'_ind'],'{9,1};'] );
       eval( ['Across_FC.oppo_pp_ind{i,1}    = across.',[name{i},'_ind'],'{10,1};'] );
       eval( ['Across_FC.oppo_nn_ind{i,1}    = across.',[name{i},'_ind'],'{11,1};'] );
      
       % BL
       eval('Across_FC.BL_ex_pp_only_FC_sum{i} = sum(fc_bl(BL_subject_all(:,i),Across_FC.ex_pp_only_ind{i,1}),2);')
       eval('Across_FC.BL_ex_nn_only_FC_sum{i} = sum(fc_bl(BL_subject_all(:,i),Across_FC.ex_nn_only_ind{i,1}),2);')
       eval('Across_FC.BL_in_pp_only_FC_sum{i} = sum(fc_bl(BL_subject_all(:,i),Across_FC.in_pp_only_ind{i,1}),2);')
       eval('Across_FC.BL_in_nn_only_FC_sum{i} = sum(fc_bl(BL_subject_all(:,i),Across_FC.in_nn_only_ind{i,1}),2);')
       
       eval('Across_FC.BL_oppo_pn_FC_sum{i}    = sum(fc_bl(BL_subject_all(:,i),Across_FC.oppo_pn_ind{i,1}),2);')
       eval('Across_FC.BL_oppo_pp_FC_sum{i}    = sum(fc_bl(BL_subject_all(:,i),Across_FC.oppo_pp_ind{i,1}),2);')
       eval('Across_FC.BL_oppo_np_FC_sum{i}    = sum(fc_bl(BL_subject_all(:,i),Across_FC.oppo_np_ind{i,1}),2);')
       eval('Across_FC.BL_oppo_nn_FC_sum{i}    = sum(fc_bl(BL_subject_all(:,i),Across_FC.oppo_nn_ind{i,1}),2);')
       
       
       % BL Single FC
       eval('Across_FC_mat.BL_ex_pp_only_FC{i} = fc_bl(BL_subject_all(:,i),Across_FC.ex_pp_only_ind{i,1});')
       eval('Across_FC_mat.BL_ex_nn_only_FC{i} = fc_bl(BL_subject_all(:,i),Across_FC.ex_nn_only_ind{i,1});')
       eval('Across_FC_mat.BL_in_pp_only_FC{i} = fc_bl(BL_subject_all(:,i),Across_FC.in_pp_only_ind{i,1});')
       eval('Across_FC_mat.BL_in_nn_only_FC{i} = fc_bl(BL_subject_all(:,i),Across_FC.in_nn_only_ind{i,1});')
       
       eval('Across_FC_mat.BL_oppo_pn_FC{i}    = fc_bl(BL_subject_all(:,i),Across_FC.oppo_pn_ind{i,1});')
       eval('Across_FC_mat.BL_oppo_pp_FC{i}    = fc_bl(BL_subject_all(:,i),Across_FC.oppo_pp_ind{i,1});')
       eval('Across_FC_mat.BL_oppo_np_FC{i}    = fc_bl(BL_subject_all(:,i),Across_FC.oppo_np_ind{i,1});')
       eval('Across_FC_mat.BL_oppo_nn_FC{i}    = fc_bl(BL_subject_all(:,i),Across_FC.oppo_nn_ind{i,1});')
       
       % FU2
       
       eval('Across_FC.FU2_ex_pp_only_FC_sum{i} = sum(fc_fu2(FU2_subject_all(:,i),Across_FC.ex_pp_only_ind{i,1}),2);')
       eval('Across_FC.FU2_ex_nn_only_FC_sum{i} = sum(fc_fu2(FU2_subject_all(:,i),Across_FC.ex_nn_only_ind{i,1}),2);')
       eval('Across_FC.FU2_in_pp_only_FC_sum{i} = sum(fc_fu2(FU2_subject_all(:,i),Across_FC.in_pp_only_ind{i,1}),2);') 
       eval('Across_FC.FU2_in_nn_only_FC_sum{i} = sum(fc_fu2(FU2_subject_all(:,i),Across_FC.in_nn_only_ind{i,1}),2);')
       
       eval('Across_FC.FU2_oppo_pn_FC_sum{i}    = sum(fc_fu2(FU2_subject_all(:,i),Across_FC.oppo_pn_ind{i,1}),2);')
       eval('Across_FC.FU2_oppo_pp_FC_sum{i}    = sum(fc_fu2(FU2_subject_all(:,i),Across_FC.oppo_pp_ind{i,1}),2);')
       eval('Across_FC.FU2_oppo_np_FC_sum{i}    = sum(fc_fu2(FU2_subject_all(:,i),Across_FC.oppo_np_ind{i,1}),2);')
       eval('Across_FC.FU2_oppo_nn_FC_sum{i}    = sum(fc_fu2(FU2_subject_all(:,i),Across_FC.oppo_nn_ind{i,1}),2);')
       
       
        % FU2 Task Single FC
       eval('Across_FC_mat.FU2_ex_pp_only_FC{i} = fc_fu2(FU2_subject_all(:,i),Across_FC.ex_pp_only_ind{i,1});')
       eval('Across_FC_mat.FU2_ex_nn_only_FC{i} = fc_fu2(FU2_subject_all(:,i),Across_FC.ex_nn_only_ind{i,1});')
       eval('Across_FC_mat.FU2_in_pp_only_FC{i} = fc_fu2(FU2_subject_all(:,i),Across_FC.in_pp_only_ind{i,1});')
       eval('Across_FC_mat.FU2_in_nn_only_FC{i} = fc_fu2(FU2_subject_all(:,i),Across_FC.in_nn_only_ind{i,1});')
       
       eval('Across_FC_mat.FU2_oppo_pn_FC{i}    = fc_fu2(FU2_subject_all(:,i),Across_FC.oppo_pn_ind{i,1});')
       eval('Across_FC_mat.FU2_oppo_pp_FC{i}    = fc_fu2(FU2_subject_all(:,i),Across_FC.oppo_pp_ind{i,1});')
       eval('Across_FC_mat.FU2_oppo_np_FC{i}    = fc_fu2(FU2_subject_all(:,i),Across_FC.oppo_np_ind{i,1});')
       eval('Across_FC_mat.FU2_oppo_nn_FC{i}    = fc_fu2(FU2_subject_all(:,i),Across_FC.oppo_nn_ind{i,1});')
       
       
        % FU2_Rest
       
       eval('Across_FC.FU2_Rest_ex_pp_only_FC_sum{i} = sum(fc_fu2_rest(:,Across_FC.ex_pp_only_ind{i,1}),2);')
       eval('Across_FC.FU2_Rest_ex_nn_only_FC_sum{i} = sum(fc_fu2_rest(:,Across_FC.ex_nn_only_ind{i,1}),2);')
       eval('Across_FC.FU2_Rest_in_pp_only_FC_sum{i} = sum(fc_fu2_rest(:,Across_FC.in_pp_only_ind{i,1}),2);')
       eval('Across_FC.FU2_Rest_in_nn_only_FC_sum{i} = sum(fc_fu2_rest(:,Across_FC.in_nn_only_ind{i,1}),2);')
       
       eval('Across_FC.FU2_Rest_oppo_pn_FC_sum{i}    = sum(fc_fu2_rest(:,Across_FC.oppo_pn_ind{i,1}),2);')
       eval('Across_FC.FU2_Rest_oppo_pp_FC_sum{i}    = sum(fc_fu2_rest(:,Across_FC.oppo_pp_ind{i,1}),2);')
       eval('Across_FC.FU2_Rest_oppo_np_FC_sum{i}    = sum(fc_fu2_rest(:,Across_FC.oppo_np_ind{i,1}),2);')
       eval('Across_FC.FU2_Rest_oppo_nn_FC_sum{i}    = sum(fc_fu2_rest(:,Across_FC.oppo_nn_ind{i,1}),2);')
       
              % FU2 Rest Single FC
       eval('Across_FC_mat.FU2_Rest_ex_pp_only_FC_sum{i} = fc_fu2_rest(:,Across_FC.ex_pp_only_ind{i,1});')
       eval('Across_FC_mat.FU2_Rest_ex_nn_only_FC_sum{i} =fc_fu2_rest(:,Across_FC.ex_nn_only_ind{i,1});')
       eval('Across_FC_mat.FU2_Rest_in_pp_only_FC_sum{i} = fc_fu2_rest(:,Across_FC.in_pp_only_ind{i,1});')
       eval('Across_FC_mat.FU2_Rest_in_nn_only_FC_sum{i} = fc_fu2_rest(:,Across_FC.in_nn_only_ind{i,1});')
       
       eval('Across_FC_mat.FU2_Rest_oppo_pn_FC_sum{i}    = fc_fu2_rest(:,Across_FC.oppo_pn_ind{i,1});')
       eval('Across_FC_mat.FU2_Rest_oppo_pp_FC_sum{i}    = fc_fu2_rest(:,Across_FC.oppo_pp_ind{i,1});')
       eval('Across_FC_mat.FU2_Rest_oppo_np_FC_sum{i}    = fc_fu2_rest(:,Across_FC.oppo_np_ind{i,1});')
       eval('Across_FC_mat.FU2_Rest_oppo_nn_FC_sum{i}    = fc_fu2_rest(:,Across_FC.oppo_nn_ind{i,1});')
       
end

 BL_FC_tale = table;
 BL_FC_tale.subject = BL_subject_match';
 
 BL_FC_tale.ex_pp  = sum(cell2mat(Across_FC.BL_ex_pp_only_FC_sum'),2);
 BL_FC_tale.ex_nn  = sum(cell2mat(Across_FC.BL_ex_nn_only_FC_sum'),2);
 BL_FC_tale.in_pp  = sum(cell2mat(Across_FC.BL_in_pp_only_FC_sum'),2);
 BL_FC_tale.in_nn  = sum(cell2mat(Across_FC.BL_in_nn_only_FC_sum'),2);
 BL_FC_tale.oppo_pp  = sum(cell2mat(Across_FC.BL_oppo_pp_FC_sum'),2);
 BL_FC_tale.oppo_pn  = sum(cell2mat(Across_FC.BL_oppo_pn_FC_sum'),2);
 BL_FC_tale.oppo_np  = sum(cell2mat(Across_FC.BL_oppo_np_FC_sum'),2);
 BL_FC_tale.oppo_nn  = sum(cell2mat(Across_FC.BL_oppo_nn_FC_sum'),2);
 
 FU2_Task_tale = table;
 FU2_Task_tale.subject = FU2_subject_match';
 
 FU2_Task_tale.ex_pp = sum(cell2mat(Across_FC.FU2_ex_pp_only_FC_sum'),2);
 FU2_Task_tale.ex_nn = sum(cell2mat(Across_FC.FU2_ex_nn_only_FC_sum'),2);
 FU2_Task_tale.in_pp = sum(cell2mat(Across_FC.FU2_in_pp_only_FC_sum'),2);
 FU2_Task_tale.in_nn = sum(cell2mat(Across_FC.FU2_in_nn_only_FC_sum'),2);
 FU2_Task_tale.oppo_pp = sum(cell2mat(Across_FC.FU2_oppo_pp_FC_sum'),2);
 FU2_Task_tale.oppo_pn = sum(cell2mat(Across_FC.FU2_oppo_pn_FC_sum'),2);
 FU2_Task_tale.oppo_np = sum(cell2mat(Across_FC.FU2_oppo_np_FC_sum'),2);
 FU2_Task_tale.oppo_nn = sum(cell2mat(Across_FC.FU2_oppo_nn_FC_sum'),2);

 FU2_Rest_tale = table;
 FU2_Rest_tale.subject = FU2_rest_sub;
 
 FU2_Rest_tale.ex_pp = sum(cell2mat(Across_FC.FU2_Rest_ex_pp_only_FC_sum'),2);
 FU2_Rest_tale.ex_nn = sum(cell2mat(Across_FC.FU2_Rest_ex_nn_only_FC_sum'),2);
 FU2_Rest_tale.in_pp = sum(cell2mat(Across_FC.FU2_Rest_in_pp_only_FC_sum'),2);
 FU2_Rest_tale.in_nn = sum(cell2mat(Across_FC.FU2_Rest_in_nn_only_FC_sum'),2);
 FU2_Rest_tale.oppo_pp = sum(cell2mat(Across_FC.FU2_Rest_oppo_pp_FC_sum'),2);
 FU2_Rest_tale.oppo_pn = sum(cell2mat(Across_FC.FU2_Rest_oppo_pn_FC_sum'),2);
 FU2_Rest_tale.oppo_np = sum(cell2mat(Across_FC.FU2_Rest_oppo_np_FC_sum'),2);
 FU2_Rest_tale.oppo_nn = sum(cell2mat(Across_FC.FU2_Rest_oppo_nn_FC_sum'),2);




