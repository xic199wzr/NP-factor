

clear;clc
load('/share/inspurStorage/home1/xic_fdu/project/IAMGEN_Develop_diagnostic_0814/Trans_diagnostic_p_facotr/A2_2_1_3_make_mask_specific.mat')
LR1 = load('/share/inspurStorage/home1/ISTBI_data/HCP/HCP_3T_Rest_Denoised/HCP_FC_Map_268_Rest1_LR.mat');
RL1 = load('/share/inspurStorage/home1/ISTBI_data/HCP/HCP_3T_Rest_Denoised/HCP_FC_Map_268_Rest1_RL.mat');

across = TableS7.TableS7_1_Across;
name = {'SST_stopsucc';'SST_stopfail';'MID_feedhit';'MID_anticihit'};

hcp_Data{1}  = reshape(LR1.fc_rest1_LR,[],size(LR1.fc_rest1_LR,3));
hcp_Data{2} = reshape(RL1.fc_rest1_RL,[],size(RL1.fc_rest1_RL,3));


Control_FC{1,2} = LR1.fc_sub_name;
Control_FC{2,2} = RL1.fc_sub_name;

for j=1:2
      
      Control_data =    hcp_Data{j}';
      
       Across_FC = table;
       Across_FC.name = name;

      for i=1:4
       eval(['oppo_ind = unique([across.',[name{i},'_ind'],'{8,1}','; across.',[name{i},'_ind'],'{9,1};', ...
                                'across.',[name{i},'_ind'],'{10,1}','; across.',[name{i},'_ind'],'{11,1}]);']);
   
       eval( ['Across_FC.ex_pp_only_ind{i,1}        = setdiff(across.',[name{i},'_ind'],'{2,1},oppo_ind);'] );
       eval( ['Across_FC.ex_nn_only_ind{i,1}        = setdiff(across.',[name{i},'_ind'],'{3,1},oppo_ind);'] );
       eval( ['Across_FC.in_pp_only_ind{i,1}         = setdiff(across.',[name{i},'_ind'],'{5,1},oppo_ind);'] );
       eval( ['Across_FC.in_nn_only_ind{i,1}         = setdiff(across.',[name{i},'_ind'],'{6,1},oppo_ind);'] );
       
       eval( ['Across_FC.oppo_pn_ind{i,1}            = across.',[name{i},'_ind'],'{8,1};'] );
       eval( ['Across_FC.oppo_np_ind{i,1}            = across.',[name{i},'_ind'],'{9,1};'] );
       eval( ['Across_FC.oppo_pp_ind{i,1}            = across.',[name{i},'_ind'],'{10,1};'] );
       eval( ['Across_FC.oppo_nn_ind{i,1}            = across.',[name{i},'_ind'],'{11,1};'] );
       
        % Cotrol
       eval('Across_FC.ex_pp_only_FC_sum{i}     = sum(Control_data(:,Across_FC.ex_pp_only_ind{i,1}),2);');
       eval('Across_FC.ex_nn_only_FC_sum{i}     = sum(Control_data(:,Across_FC.ex_nn_only_ind{i,1}),2);');
       eval('Across_FC.in_pp_only_FC_sum{i}      = sum(Control_data(:,Across_FC.in_pp_only_ind{i,1}),2);');
       eval('Across_FC.in_nn_only_FC_sum{i}      = sum(Control_data(:,Across_FC.in_nn_only_ind{i,1}),2);');
       
       eval('Across_FC.oppo_pn_FC_sum{i}         = sum(Control_data(:,Across_FC.oppo_pn_ind{i,1}),2);');
       eval('Across_FC.oppo_pp_FC_sum{i}         = sum(Control_data(:,Across_FC.oppo_pp_ind{i,1}),2);');
       eval('Across_FC.oppo_np_FC_sum{i}         = sum(Control_data(:,Across_FC.oppo_np_ind{i,1}),2);');
       eval('Across_FC.oppo_nn_FC_sum{i}         = sum(Control_data(:,Across_FC.oppo_nn_ind{i,1}),2);');
       
       eval('Across_FC.ex_pp_only_FC_sum{i}     = sum(Control_data(:,Across_FC.ex_pp_only_ind{i,1}),2);');
       eval('Across_FC.ex_nn_only_FC_sum{i}     = sum(Control_data(:,Across_FC.ex_nn_only_ind{i,1}),2);');
       eval('Across_FC.in_pp_only_FC_sum{i}      = sum(Control_data(:,Across_FC.in_pp_only_ind{i,1}),2);');
       eval('Across_FC.in_nn_only_FC_sum{i}      = sum(Control_data(:,Across_FC.in_nn_only_ind{i,1}),2);');
       
       eval('Across_FC.oppo_pn_FC_sum{i}         = sum(Control_data(:,Across_FC.oppo_pn_ind{i,1}),2);');
       eval('Across_FC.oppo_pp_FC_sum{i}         = sum(Control_data(:,Across_FC.oppo_pp_ind{i,1}),2);');
       eval('Across_FC.oppo_np_FC_sum{i}         = sum(Control_data(:,Across_FC.oppo_np_ind{i,1}),2);');
       eval('Across_FC.oppo_nn_FC_sum{i}         = sum(Control_data(:,Across_FC.oppo_nn_ind{i,1}),2);');
      
      end
    
       Control_FC_tale = table;
 
        Control_FC_tale.ex_pp      = sum(cell2mat(Across_FC.ex_pp_only_FC_sum'),2);
        Control_FC_tale.ex_nn      = sum(cell2mat(Across_FC.ex_nn_only_FC_sum'),2);
        Control_FC_tale.in_pp       = sum(cell2mat(Across_FC.in_pp_only_FC_sum'),2);
        Control_FC_tale.in_nn       = sum(cell2mat(Across_FC.in_nn_only_FC_sum'),2);
        Control_FC_tale.oppo_pp  = sum(cell2mat(Across_FC.oppo_pp_FC_sum'),2);
        Control_FC_tale.oppo_pn  = sum(cell2mat(Across_FC.oppo_pn_FC_sum'),2);
        Control_FC_tale.oppo_np  = sum(cell2mat(Across_FC.oppo_np_FC_sum'),2);
        Control_FC_tale.oppo_nn  = sum(cell2mat(Across_FC.oppo_nn_FC_sum'),2);

       Control_FC{j,1} = Control_FC_tale;
    
    
end

save N5_4_1_HCP_FC.mat Control_FC
  
  
  
  


