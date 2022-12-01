

clear;clc
load('/home1/xic_fdu/project/IAMGEN_Develop_diagnostic_0814/Trans_diagnostic_p_facotr/A2_2_1_1_make_mask_across.mat');
load('/home1/xic_fdu/project/IAMGEN_Develop_diagnostic_0814/Trans_diagnostic_p_facotr/Shen_net_index.mat')

[external_net,internal_net,translation_net] = xic_transdiagnostic_network(TableS7);


load('A3_1_0_Network_overlap_subnets_permute');


mask_shen = reshape(1:268*268,268,268);
mask_shen_id = mask_shen(mask_shen>0);

Table_Net = table;

k =0;
for i=1:10
   for j=1:10
       if i > j || i==j
        k = k+1;
        Table_Net.net_label{k,1} = [shen_index_label{i},'-',shen_index_label{j}];
        
        Table_Net.exter_pp_net(k,1) = sum(sum(external_net{1}(shen_net_index ==i,shen_net_index ==j)));
        Table_Net.exter_nn_net(k,1) = sum(sum(external_net{2}(shen_net_index ==i,shen_net_index ==j)));
        
        Table_Net.inter_nn_net(k,1) = sum(sum(internal_net{1}(shen_net_index ==i,shen_net_index ==j)));
        Table_Net.oppo_pn_net(k,1)  = sum(sum(translation_net{1}(shen_net_index ==i,shen_net_index ==j)));
        Table_Net.oppo_pp_net(k,1)  = sum(sum(translation_net{2}(shen_net_index ==i,shen_net_index ==j)));
        Table_Net.oppo_np_net(k,1)  = sum(sum(translation_net{3}(shen_net_index ==i,shen_net_index ==j)));
       end
   end
end


within_ind = [1 3 6 10 15 21 28 36 45 55];
between_ind = 1:55; between_ind(within_ind)=[];

within = table2array(Table_Net(within_ind,[2:7]));
Table_Net(within_ind,[2:7]) = array2table(within/2);

Table_Net.exter_pp_net_p = sum(Table_Net.exter_pp_net < Permute_All.exter_pp_net_all,2)/1000;
Table_Net.exter_nn_net_p = sum(Table_Net.exter_nn_net < Permute_All.exter_nn_net_all,2)/1000;
Table_Net.inter_nn_net_p = sum(Table_Net.inter_nn_net < Permute_All.inter_nn_net_all,2)/1000;
Table_Net.oppo_pn_net_p = sum(Table_Net.oppo_pn_net < Permute_All.oppo_pn_net_all,2)/1000;
Table_Net.oppo_pp_net_p = sum(Table_Net.oppo_pp_net < Permute_All.oppo_pp_net_all,2)/1000;
Table_Net.oppo_np_net_p = sum(Table_Net.oppo_np_net < Permute_All.oppo_np_net_all,2)/1000;

Table_Net.oppo_np_net_p(Table_Net.oppo_np_net==0) = 1;
Table_Net.oppo_pp_net_p(Table_Net.oppo_pp_net==0) = 1;
Table_Net.oppo_pn_net_p(Table_Net.oppo_pn_net==0) = 1;
Table_Net.inter_nn_net_p(Table_Net.inter_nn_net==0) = 1;
Table_Net.exter_nn_net_p(Table_Net.exter_nn_net==0) = 1;
Table_Net.exter_pp_net_p(Table_Net.exter_pp_net==0) = 1;

Table_Net.exter_pp_net_score = Table_Net.exter_pp_net./ mean( Permute_All.exter_pp_net_all,2);
Table_Net.exter_nn_net_score = Table_Net.exter_nn_net./ mean( Permute_All.exter_nn_net_all,2);
Table_Net.inter_nn_net_score = Table_Net.inter_nn_net./ mean( Permute_All.inter_nn_net_all,2);
Table_Net.exter_pn_net_score = Table_Net.oppo_pn_net./ mean( Permute_All.oppo_pn_net_all,2);
Table_Net.oppo_pp_net_p_score = Table_Net.oppo_pp_net./ mean( Permute_All.oppo_pp_net_all,2);
Table_Net.oppo_np_net_score = Table_Net.oppo_np_net./ mean( Permute_All.oppo_pp_net_all,2);



Table_Net_within = Table_Net(within_ind,:);
Table_Net_between = Table_Net(between_ind,:);

TableS7.TableS7_2_Subnetwork = Table_Net;
TableS7.TableS7_3_Subnetwork_within = Table_Net_within;
TableS7.TableS7_4_Subnetwork_between = Table_Net_between;

save A3_1_1_Network_overlap_subnets.mat TableS7
