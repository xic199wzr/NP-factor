

clear;clc

load('/share/inspurStorage/home1/xic_fdu/project/IAMGEN_Develop_diagnostic_0814/Trans_diagnostic_p_facotr/A2_2_1_3_make_mask_specific.mat')
ADHD = load('/share/inspurStorage/home1/ISTBI_data/ISTBI_data_ADHD200/ADHD_FC_Map_268_DPABI.mat');

across = TableS7.TableS7_1_Across;
name = {'SST_stopsucc';'SST_stopfail';'MID_feedhit';'MID_anticihit'};

ADHD_Data{1}  = reshape(ADHD.fc_rest,[],size(ADHD.fc_rest,3));
Control_FC{1,2} = ADHD.fc_sub_name;

for j=1
      
      Control_data =    ADHD_Data{j}';
      
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
       eval('Across_FC.ex_pp_only_FC_sum{i}     = nansum(Control_data(:,Across_FC.ex_pp_only_ind{i,1}),2);');
       eval('Across_FC.ex_nn_only_FC_sum{i}     = nansum(Control_data(:,Across_FC.ex_nn_only_ind{i,1}),2);');
       eval('Across_FC.in_pp_only_FC_sum{i}      = nansum(Control_data(:,Across_FC.in_pp_only_ind{i,1}),2);');
       eval('Across_FC.in_nn_only_FC_sum{i}      = nansum(Control_data(:,Across_FC.in_nn_only_ind{i,1}),2);');
       
       eval('Across_FC.oppo_pn_FC_sum{i}         = nansum(Control_data(:,Across_FC.oppo_pn_ind{i,1}),2);');
       eval('Across_FC.oppo_pp_FC_sum{i}         = nansum(Control_data(:,Across_FC.oppo_pp_ind{i,1}),2);');
       eval('Across_FC.oppo_np_FC_sum{i}         = nansum(Control_data(:,Across_FC.oppo_np_ind{i,1}),2);');
       eval('Across_FC.oppo_nn_FC_sum{i}         = nansum(Control_data(:,Across_FC.oppo_nn_ind{i,1}),2);');
       
       eval('Across_FC.ex_pp_only_FC_sum{i}     = nansum(Control_data(:,Across_FC.ex_pp_only_ind{i,1}),2);');
       eval('Across_FC.ex_nn_only_FC_sum{i}     = nansum(Control_data(:,Across_FC.ex_nn_only_ind{i,1}),2);');
       eval('Across_FC.in_pp_only_FC_sum{i}      = nansum(Control_data(:,Across_FC.in_pp_only_ind{i,1}),2);');
       eval('Across_FC.in_nn_only_FC_sum{i}      = nansum(Control_data(:,Across_FC.in_nn_only_ind{i,1}),2);');
       
       eval('Across_FC.oppo_pn_FC_sum{i}         = nansum(Control_data(:,Across_FC.oppo_pn_ind{i,1}),2);');
       eval('Across_FC.oppo_pp_FC_sum{i}         = nansum(Control_data(:,Across_FC.oppo_pp_ind{i,1}),2);');
       eval('Across_FC.oppo_np_FC_sum{i}         = nansum(Control_data(:,Across_FC.oppo_np_ind{i,1}),2);');
       eval('Across_FC.oppo_nn_FC_sum{i}         = nansum(Control_data(:,Across_FC.oppo_nn_ind{i,1}),2);');
      
      end
    
       Control_FC_tale = table;
 
        Control_FC_tale.ex_pp      = nansum(cell2mat(Across_FC.ex_pp_only_FC_sum'),2);
        Control_FC_tale.ex_nn      = nansum(cell2mat(Across_FC.ex_nn_only_FC_sum'),2);
        Control_FC_tale.in_pp       = nansum(cell2mat(Across_FC.in_pp_only_FC_sum'),2);
        Control_FC_tale.in_nn       = nansum(cell2mat(Across_FC.in_nn_only_FC_sum'),2);
        Control_FC_tale.oppo_pp  = nansum(cell2mat(Across_FC.oppo_pp_FC_sum'),2);
        Control_FC_tale.oppo_pn  = nansum(cell2mat(Across_FC.oppo_pn_FC_sum'),2);
        Control_FC_tale.oppo_np  = nansum(cell2mat(Across_FC.oppo_np_FC_sum'),2);
        Control_FC_tale.oppo_nn  = nansum(cell2mat(Across_FC.oppo_nn_FC_sum'),2);

       Control_FC{j,1} = Control_FC_tale;
    
    
end

save N5_5_4_ADHD_FC.mat Control_FC Across_FC

%% the symptom 
load('N5_5_4_ADHD_FC.mat')
addpath(' /share/inspurStorage/home1/xic_fdu/project/IAMGEN_Develop_diagnostic_0814/Trans_diagnostic_p_facotr')
pheno =  importdata('/share/inspurStorage/home1/ISTBI_data/ISTBI_data_ADHD200/adhd200_preprocessed_phenotypics.tsv.xlsx');

pheno_dat =pheno.data(:,6);
pheno_sec = pheno.textdata(2:end,7);
pheno_id   = pheno.data(:,1);
pheno_age =pheno.data(:,4);
pheno_site = pheno.data(:,2);
pheno_gender = pheno.data(:,3);
% 1 Peking University 2 Bradley Hospital/Brown University 
% 3 Kennedy Krieger Institute 4 NeuroIMAGE Sample
% 5 New York University Child Study Center 
% 6 Oregon Health & Science University % 7 University of Pittsburgh 8 Washington University in St. Louis

fc_sub = str2double(string(Control_FC{1,2}));
FC_mat = Control_FC{1,1};
% FC_mat = Across_FC.oppo_pp_FC_sum{4};

[all,ind1,ind2] = intersect(fc_sub,pheno_id); 

ph_mat     = pheno_dat(ind2,:);
ph_sec     = pheno_sec(ind2,:);
ph_age     = pheno_age(ind2,:);
confound = [dummyvar(pheno_site(ind2,:)),pheno_gender(ind2),pheno_age(ind2)];
confound = [ones(length(confound),1),confound(:,2:end)];
FC_mats     =  table2array(FC_mat(ind1,:));

for i=1:8
    [~,~,FC_mats(:,i)] = regress(FC_mats(:,i),confound);
end

ph_sec_types= ph_sec(~cellfun(@isempty,ph_sec));
inter = ph_mat~=0 & (contains(ph_sec,'depres') + contains(ph_sec,'anxiety')  + ...
                                    contains(ph_sec,'Depres')   + contains(ph_sec,'Anxie')  + ...
                                    contains(ph_sec,'phobia') + contains(ph_sec,'Phobia') ~=0);
                                
exter     = ph_mat~=0 & contains(ph_sec,'ODD');
exter(inter==1) =0;

control   = ph_mat==0;
ADHD     = ph_mat~=0;% & cellfun(@isempty,ph_sec);

[~,p1,~,t1] = ttest2(FC_mats(ADHD,:),FC_mats(control,:));
[~,p2,~,t2] = ttest2(FC_mats(exter,:),FC_mats(control,:));
[~,p3,~,t3] = ttest2(FC_mats(inter,:),FC_mats(control,:));
Tvalues = table;
Tvalues.FCtype = FC_mat.Properties.VariableNames';
Tvalues.ADHD_Tvlaue = t1.tstat';
Tvalues.ADHD_Pvalue = p1';
Tvalues.Exter_Tvlaue = t2.tstat';
Tvalues.Exter_Pvalue = p2';
Tvalues.Inter_Tvlaue = t3.tstat';
Tvalues.Inter_Pvalue = p3';

ADHD_only = ph_mat~=0 .* cellfun(@isempty,ph_sec);


%% save Plot data

ADHD_Case = FC_mats(ADHD,5);
ADHD_Control = FC_mats(control,5);

save N5_5_4_ADHD200_FC.mat  ADHD_Case  ADHD_Control


