

clear;clc
load('/share/inspurStorage/home1/xic_fdu/project/IAMGEN_Develop_diagnostic_0814/Trans_diagnostic_p_facotr/A2_2_1_3_make_mask_specific.mat')
load('/share/inspurStorage/home1/ISTBI_data/ABCD_MID/Conn/ABCD_MID_CONN_v2.mat')

across = TableS7.TableS7_1_Across;
name = {'MID_feedhit';'MID_anticihit'};
nums= [3 4];

mid_Data{1}  = reshape(ABCD_MID_feed,[],size(ABCD_MID_feed,3));
mid_Data{2} = reshape(ABCD_MID_anti,[],size(ABCD_MID_anti,3));

  Across_FC = table;
  Across_FC.name = name;
  
  Across_FC_mat = table;
  Across_FC_mat.name = name;
  
  for j=1:2
     
        dat = mid_Data{j}';
        
         eval(['oppo_ind = unique([across.',[name{j},'_ind'],'{8,1}','; across.',[name{j},'_ind'],'{9,1};', ...
                                'across.',[name{j},'_ind'],'{10,1}','; across.',[name{j},'_ind'],'{11,1}]);']);
   
       eval( ['Across_FC.ex_pp_only_ind{j,1}        = setdiff(across.',[name{j},'_ind'],'{2,1},oppo_ind);'] );
       eval( ['Across_FC.ex_nn_only_ind{j,1}        = setdiff(across.',[name{j},'_ind'],'{3,1},oppo_ind);'] );
       eval( ['Across_FC.in_pp_only_ind{j,1}         = setdiff(across.',[name{j},'_ind'],'{5,1},oppo_ind);'] );
       eval( ['Across_FC.in_nn_only_ind{j,1}         = setdiff(across.',[name{j},'_ind'],'{6,1},oppo_ind);'] );
       
       eval( ['Across_FC.oppo_pn_ind{j,1}            = across.',[name{j},'_ind'],'{8,1};'] );
       eval( ['Across_FC.oppo_np_ind{j,1}            = across.',[name{j},'_ind'],'{9,1};'] );
       eval( ['Across_FC.oppo_pp_ind{j,1}            = across.',[name{j},'_ind'],'{10,1};'] );
       eval( ['Across_FC.oppo_nn_ind{j,1}            = across.',[name{j},'_ind'],'{11,1};'] );
       
       
        % Cotrol
       eval('Across_FC.ex_pp_only_FC_sum{j}     = sum(dat(:,Across_FC.ex_pp_only_ind{j,1}),2);');
       eval('Across_FC.ex_nn_only_FC_sum{j}     = sum(dat(:,Across_FC.ex_nn_only_ind{j,1}),2);');
       eval('Across_FC.in_pp_only_FC_sum{j}      = sum(dat(:,Across_FC.in_pp_only_ind{j,1}),2);');
       eval('Across_FC.in_nn_only_FC_sum{j}      = sum(dat(:,Across_FC.in_nn_only_ind{j,1}),2);');
       
       eval('Across_FC.oppo_pn_FC_sum{j}         = sum(dat(:,Across_FC.oppo_pn_ind{j,1}),2);');
       eval('Across_FC.oppo_pp_FC_sum{j}         = sum(dat(:,Across_FC.oppo_pp_ind{j,1}),2);');
       eval('Across_FC.oppo_np_FC_sum{j}         = sum(dat(:,Across_FC.oppo_np_ind{j,1}),2);');
       eval('Across_FC.oppo_nn_FC_sum{j}         = sum(dat(:,Across_FC.oppo_nn_ind{j,1}),2);');
       
       eval('Across_FC.ex_pp_only_FC_sum{j}     = sum(dat(:,Across_FC.ex_pp_only_ind{j,1}),2);');
       eval('Across_FC.ex_nn_only_FC_sum{j}     = sum(dat(:,Across_FC.ex_nn_only_ind{j,1}),2);');
       eval('Across_FC.in_pp_only_FC_sum{j}      = sum(dat(:,Across_FC.in_pp_only_ind{j,1}),2);');
       eval('Across_FC.in_nn_only_FC_sum{j}      = sum(dat(:,Across_FC.in_nn_only_ind{j,1}),2);');
       
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
  
  ABCD_FC_MID = table;
 ABCD_FC_MID.subID = Sub_MID;
 
  ABCD_FC_MID.ex_pp      = sum(cell2mat(Across_FC.ex_pp_only_FC_sum'),2);
  ABCD_FC_MID.ex_nn      = sum(cell2mat(Across_FC.ex_nn_only_FC_sum'),2);
  ABCD_FC_MID.in_pp       = sum(cell2mat(Across_FC.in_pp_only_FC_sum'),2);
  ABCD_FC_MID.in_nn       = sum(cell2mat(Across_FC.in_nn_only_FC_sum'),2);
  ABCD_FC_MID.oppo_pp  = sum(cell2mat(Across_FC.oppo_pp_FC_sum'),2);
  ABCD_FC_MID.oppo_pn  = sum(cell2mat(Across_FC.oppo_pn_FC_sum'),2);
  ABCD_FC_MID.oppo_np  = sum(cell2mat(Across_FC.oppo_np_FC_sum'),2);
  ABCD_FC_MID.oppo_nn  = sum(cell2mat(Across_FC.oppo_nn_FC_sum'),2);

save N5_3_2_ABCD_FC_v2.mat ABCD_FC_MID Across_FC_mat
  
  
  
  


