

clear;clc
load('/share/inspurStorage/home1/xic_fdu/project/IAMGEN_Develop_diagnostic_0814/Trans_diagnostic_p_facotr/A2_2_1_3_make_mask_specific.mat')
load('/share/inspurStorage/home1/ISTBI_data/IMAGEN_Stratify/SPM/Striatify_Match_SST_CONN.mat');

across = TableS7.TableS7_1_Across;
name = {'SST_stopsucc';'SST_stopfail'};


% Striatify_SST_stop_suces   = cat(3,site1.Striatify_SST_stop_suces,site2.Striatify_SST_stop_suces);
% Striatify_SST_stop_failure = cat(3,site1.Striatify_SST_stop_failure,site2.Striatify_SST_stop_failure);
% Striatify_SST_subject = [site1.Striatify_SST_subject;site2.Striatify_SST_subject];

sst_Data{1}  = reshape(Striatify_SST_stop_suces,[],size(Striatify_SST_stop_suces,3));
sst_Data{2}  = reshape(Striatify_SST_stop_failure,[],size(Striatify_SST_stop_failure,3));

  Across_FC = table;
  Across_FC.name = name;
  
  Across_FC_mat = table;
  Across_FC_mat.name = name;
  

for j=1:2
     
        dat = sst_Data{j}';
        
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
  
 Striatify_FC_SST = table;
 Striatify_FC_SST.subID = Striatify_SST_subject;
 
  Striatify_FC_SST.ex_pp      = sum(cell2mat(Across_FC.ex_pp_only_FC_sum'),2);
  Striatify_FC_SST.ex_nn      = sum(cell2mat(Across_FC.ex_nn_only_FC_sum'),2);
  Striatify_FC_SST.in_pp       = sum(cell2mat(Across_FC.in_pp_only_FC_sum'),2);
  Striatify_FC_SST.in_nn       = sum(cell2mat(Across_FC.in_nn_only_FC_sum'),2);
  Striatify_FC_SST.oppo_pp  = sum(cell2mat(Across_FC.oppo_pp_FC_sum'),2);
  Striatify_FC_SST.oppo_pn  = sum(cell2mat(Across_FC.oppo_pn_FC_sum'),2);
  Striatify_FC_SST.oppo_np  = sum(cell2mat(Across_FC.oppo_np_FC_sum'),2);
  Striatify_FC_SST.oppo_nn  = sum(cell2mat(Across_FC.oppo_nn_FC_sum'),2);

save N5_3_2_2_Striatify_FC_SST_v3.mat Striatify_FC_SST Across_FC_mat
  
  
  
  


