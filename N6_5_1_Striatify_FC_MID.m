

clear;clc
load('/share/inspurStorage/home1/xic_fdu/project/IAMGEN_Develop_diagnostic_0814/Trans_diagnostic_p_facotr/A2_2_1_3_make_mask_specific.mat')
load('/share/inspurStorage/home1/ISTBI_data/IMAGEN_Stratify/SPM/Striatify_Match_MID_CONN.mat');

across = TableS7.TableS7_1_Across;
name = {'MID_feedhit';'MID_anticihit'};


mid_Data{1} = reshape(Striatify_MID_feedhit,[],size(Striatify_MID_feedhit,3));
mid_Data{2} = reshape(Striatify_MID_antici_hit,[],size(Striatify_MID_antici_hit,3));

  Across_FC = table;
  Across_FC.name = name;
  
  Across_FC_mat = table;
  Across_FC_mat.name = name;
  
for j=1:2
     
        dat = mid_Data{j}';
        
         eval(['oppo_ind = unique([across.',[name{j},'_ind'],'{8,1}','; across.',[name{j},'_ind'],'{9,1};', ...
                                'across.',[name{j},'_ind'],'{10,1}','; across.',[name{j},'_ind'],'{11,1}]);']);
   
       
       eval( ['Across_FC.oppo_pn_ind{j,1}            = across.',[name{j},'_ind'],'{8,1};'] );
       eval( ['Across_FC.oppo_np_ind{j,1}            = across.',[name{j},'_ind'],'{9,1};'] );
       eval( ['Across_FC.oppo_pp_ind{j,1}            = across.',[name{j},'_ind'],'{10,1};'] );
       eval( ['Across_FC.oppo_nn_ind{j,1}            = across.',[name{j},'_ind'],'{11,1};'] );
   
       eval('Across_FC.oppo_pn_FC_sum{j}         = sum(dat(:,Across_FC.oppo_pn_ind{j,1}),2);');
       eval('Across_FC.oppo_pp_FC_sum{j}         = sum(dat(:,Across_FC.oppo_pp_ind{j,1}),2);');
       eval('Across_FC.oppo_np_FC_sum{j}         = sum(dat(:,Across_FC.oppo_np_ind{j,1}),2);');
       eval('Across_FC.oppo_nn_FC_sum{j}         = sum(dat(:,Across_FC.oppo_nn_ind{j,1}),2);');
       
       
       eval('Across_FC.oppo_pn_FC_sum{j}         = sum(dat(:,Across_FC.oppo_pn_ind{j,1}),2);');
       eval('Across_FC.oppo_pp_FC_sum{j}         = sum(dat(:,Across_FC.oppo_pp_ind{j,1}),2);');
       eval('Across_FC.oppo_np_FC_sum{j}         = sum(dat(:,Across_FC.oppo_np_ind{j,1}),2);');
       eval('Across_FC.oppo_nn_FC_sum{j}         = sum(dat(:,Across_FC.oppo_nn_ind{j,1}),2);');
       
       % Control Data
       
       eval('Across_FC_mat.ex_pp_only_FC{j}     = (dat(:,Across_FC.ex_pp_only_ind{j,1}));');
       eval('Across_FC_mat.ex_nn_only_FC{j}     = (dat(:,Across_FC.ex_nn_only_ind{j,1}));');
       eval('Across_FC_mat.in_pp_only_FC{j}      = (dat(:,Across_FC.in_pp_only_ind{j,1}));');
       eval('Across_FC_mat.in_nn_only_FC{j}      = (dat(:,Across_FC.in_nn_only_ind{j,1}));');
       
       eval('Across_FC_mat.oppo_pn_FC{j}         = (dat(:,Across_FC.oppo_pn_ind{j,1}));');
       eval('Across_FC_mat.oppo_pp_FC{j}         = (dat(:,Across_FC.oppo_pp_ind{j,1}));');
       eval('Across_FC_mat.oppo_np_FC{j}         = (dat(:,Across_FC.oppo_np_ind{j,1}));');
       eval('Across_FC_mat.oppo_nn_FC{j}         = (dat(:,Across_FC.oppo_nn_ind{j,1}));');
       
       eval('Across_FC_mat.ex_pp_only_FC{j}     = (dat(:,Across_FC.ex_pp_only_ind{j,1}));');
       eval('Across_FC_mat.ex_nn_only_FC{j}     = (dat(:,Across_FC.ex_nn_only_ind{j,1}));');
       eval('Across_FC_mat.in_pp_only_FC{j}      = (dat(:,Across_FC.in_pp_only_ind{j,1}));');
       eval('Across_FC_mat.in_nn_only_FC{j}      = (dat(:,Across_FC.in_nn_only_ind{j,1}));');
       
       eval('Across_FC_mat.oppo_pn_FC{j}         = (dat(:,Across_FC.oppo_pn_ind{j,1}));');
       eval('Across_FC_mat.oppo_pp_FC{j}         = (dat(:,Across_FC.oppo_pp_ind{j,1}));');
       eval('Across_FC_mat.oppo_np_FC{j}         = (dat(:,Across_FC.oppo_np_ind{j,1}));');
       eval('Across_FC_mat.oppo_nn_FC{j}         = (dat(:,Across_FC.oppo_nn_ind{j,1}));');
       
       
end
  
 Striatify_FC_MID = table;
 Striatify_FC_MID.subID = Striatify_MID_subject;
 
  Striatify_FC_MID.ex_pp      = sum(cell2mat(Across_FC.ex_pp_only_FC_sum'),2);
  Striatify_FC_MID.ex_nn      = sum(cell2mat(Across_FC.ex_nn_only_FC_sum'),2);
  Striatify_FC_MID.in_pp       = sum(cell2mat(Across_FC.in_pp_only_FC_sum'),2);
  Striatify_FC_MID.in_nn       = sum(cell2mat(Across_FC.in_nn_only_FC_sum'),2);
  Striatify_FC_MID.oppo_pp  = sum(cell2mat(Across_FC.oppo_pp_FC_sum'),2);
  Striatify_FC_MID.oppo_pn  = sum(cell2mat(Across_FC.oppo_pn_FC_sum'),2);
  Striatify_FC_MID.oppo_np  = sum(cell2mat(Across_FC.oppo_np_FC_sum'),2);
  Striatify_FC_MID.oppo_nn  = sum(cell2mat(Across_FC.oppo_nn_FC_sum'),2);


  
  


