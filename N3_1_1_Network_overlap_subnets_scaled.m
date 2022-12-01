
clear;clc

load('A3_1_1_Network_overlap_subnets.mat')


net_name = {'exter_pp_net', 'exter_nn_net','inter_nn_net','oppo_pn_net','oppo_pp_net','oppo_np_net'};
Table_Net = table;
Table_Net.net_label = TableS7.TableS7_2_Subnetwork.net_label;

for i=1:6
    eval(['net = TableS7.TableS7_2_Subnetwork.',net_name{i},';']);
    eval(['net_p = TableS7.TableS7_2_Subnetwork.',net_name{i},'_p;']);
    eval(['Table_Net.',net_name{i},'_scaled = net.* ( net_p< 0.05/55)/ max(net).*100;']);
    eval(['Table_Net.',net_name{i},'_scaled_P_ind =  ( net_p< (0.05/55));']);
end


exter_pp = TableS7.TableS7_1_Across.All_matrix_cumulative{2};  
oppo_pp  = TableS7.TableS7_1_Across.All_matrix_cumulative{7};  

exter_nn = TableS7.TableS7_1_Across.All_matrix_cumulative{3};  
inter_nn = TableS7.TableS7_1_Across.All_matrix_cumulative{6};  

oppo_pn = TableS7.TableS7_1_Across.All_matrix_cumulative{8};   


late_on     = inter_nn;            
persist_pp  = exter_pp + oppo_pp;  
persist_nn  = exter_nn;            
remission   = oppo_pn;            

late_on_matrix    = xic_imagsec_b(late_on,0);
persist_pp_matrix = xic_imagsec_b(persist_pp,0);
persist_nn_matrix = xic_imagsec_b(persist_nn,1);
remission_matrix  = xic_imagsec_b(remission,1);








all_net = late_on + persist +  remission;
all_net_ind = all_net + fliplr(rot90(all_net)); 
all_net_ind(all_net_ind>0)= 1;
all_net_sum = sum(all_net_ind,2);

[max_net(:,1),max_net(:,2)] = sort(all_net_sum,'descend'); 
 max_net_num = max_net(max_net(:,1)>1,2);
[max_net2(:,1),max_net2(:,2)] = find(sum(all_net_ind(max_net_num,:)));
max_ind = sort([max_net2(:,2);max_net_num]);

all_net_toghther = all_net_ind(max_ind,max_ind); 
xic_imagsec_b(all_net_toghther)


subplot(1,3,1); h1 = imagesc(exter_pp,[0 20]); title('exter-pp'); colorbar
subplot(1,3,2); h2 = imagesc(oppo_pp,[0 20]);  title('oppo-pp') ; colorbar
subplot(1,3,3); h3 = imagesc(oppo_pp + exter_pp,[0 20]);  title('oppo and exter -pp') ; colorbar


