
clear;clc;close all

model_name = {'_SST_stopsuc.mat','_SST_stopfai.mat' ...
        'SST_gowrong.mat','feed_miss.mat','feed_hit.mat' ...
        'antici_hit.mat','EFT_neutral.mat','EFT_angry.mat'};
model  = [1 2 5 6];

name = {'SST_stopsuccess','SST_stopfailure','SST_gowrong',...
       'MID_feedmiss','MID_feedhit','MID_anticihit', ...
       'EFT_neutral','EFT_angry'};

 load('/home1/xic_fdu/project/IAMGEN_Develop_diagnostic_0814/MyColormaps.mat')

number=[4 2 5 7 3 1 6 8];
dis_names  = {'asd','adhd','cd' ,'od','anxiety','dep','eat','speph'};
  
load('/share/inspurStorage/home1/xic_fdu/project/IAMGEN_Develop_diagnostic_0814/Trans_diagnostic_p_facotr/A2_1_1_Network_P_factor.mat')

mask = reshape(tril(reshape(1:268*268,268,268),-1),[],1); 

for k= 1:4
    k
    models = dir(fullfile('/home1/xic_fdu/project/IAMGEN_Develop_diagnostic_0814/CPM_Models/',['*',model_name{model(k)}]));
 
    neg_neg = neg_neg_all_dimension{model(k)};
    neg_pos = neg_pos_all_dimension{model(k)};
    pos_pos = pos_pos_all_dimension{model(k)};
    pos_neg = pos_neg_all_dimension{model(k)};
    
    inter_all = zeros(268,268); inter_all_pp = zeros(268,268);inter_all_nn = zeros(268,268);
    exter_all = zeros(268,268); exter_all_pp = zeros(268,268);exter_all_nn = zeros(268,268);
    oppo_all = zeros(268,268); 
    oppo_all_pn = zeros(268,268);oppo_all_np = zeros(268,268);
    oppo_all_nn = zeros(268,268);oppo_all_pp = zeros(268,268);
    
    
    %% get the cross-disorder fc: external-postive FC, Internal Negative FC, Translation Pos-Neg FC

    for i = 1:4
        for j=1:4
            if i~=j
            	exter_all_pp =  exter_all_pp +  pos_pos{i,j};
                exter_all_nn =  exter_all_nn +  neg_neg{i,j};
                exter_all =  exter_all +  pos_pos{i,j}+neg_neg{i,j};
            end
        end
    end
    
    exter_all = tril(exter_all./2);exter_all_pp = tril(exter_all_pp./2);exter_all_nn = tril(exter_all_nn./2);
    exter_all_dimen{k} = exter_all; exter_all_dimen_ind{k}  = find(exter_all>0);
    exter_pp_dimen{k} = exter_all_pp; exter_pp_dimen_ind{k} = find(exter_all_pp>0);
    exter_nn_dimen{k} = exter_all_nn; exter_nn_dimen_ind{k} = find(exter_all_nn>0);
    
    for i = 5:8
        for j=5:8
            if i~=j
            	inter_all_pp =  inter_all_pp +  pos_pos{i,j};
                inter_all_nn =  inter_all_nn +  neg_neg{i,j};
                inter_all =  inter_all +  pos_pos{i,j}+neg_neg{i,j};

            end
        end
    end
    
    inter_all = tril(inter_all./2);inter_all_pp = tril(inter_all_pp./2);inter_all_nn = tril(inter_all_nn./2);
    inter_all_dimen{k} = inter_all;   inter_all_dimen_ind{k} = find(inter_all>0);
    inter_pp_dimen{k} = inter_all_pp; inter_pp_dimen_ind{k} = find(inter_all_pp>0);
    inter_nn_dimen{k} = inter_all_nn; inter_nn_dimen_ind{k} = find(inter_all_nn>0);
    
    for i = 1:4
        for j=5:8
            if i~=j 
                
                oppo_all_nn =  oppo_all_nn +  neg_neg{i,j};
                oppo_all_pp =  oppo_all_pp +  pos_pos{i,j};
                
                oppo_all_np =  oppo_all_np +  neg_pos{i,j};
                oppo_all_pn =  oppo_all_pn +  pos_neg{i,j};
                
                oppo_all =  oppo_all +  neg_pos{i,j} + pos_neg{i,j} + neg_neg{i,j} + pos_pos{i,j};

            end
        end
    end
    
    oppo = tril(oppo_all); oppo_all_pn =  tril(oppo_all_pn); oppo_all_np = tril(oppo_all_np);
    oppo_all_dimen{k} = oppo;       oppo_all_dimen_ind{k} = find(oppo>0);
    oppo_pn_dimen{k} = oppo_all_pn; oppo_pn_dimen_ind{k} = find(oppo_all_pn>0);
    oppo_np_dimen{k} = oppo_all_np; oppo_np_dimen_ind{k} = find(oppo_all_np>0);
    oppo_nn_dimen{k} = oppo_all_nn; oppo_nn_dimen_ind{k} = find(oppo_all_nn>0);
    oppo_pp_dimen{k} = oppo_all_pp; oppo_pp_dimen_ind{k} = find(oppo_all_pp>0);
end


name_dimen = {'SST_stopsucc','SST_stopfail','MID_feedhit','MID_anticihit'};
name_dimen_ind = {'SST_stopsucc_ind','SST_stopfail_ind','MID_feedhit_ind','MID_anticihit_ind'};
 
TableS7_1_Across = table;      
TableS7_1_Across.FC_type = { 'Across_EXTER_all','Across_EXTER_pp','Across_EXTER_nn', ...
                    'Across_INTER_all','Across_INTER_pp','Across_INTER_nn', ....
                    'Across_Oppo_all','Across_Oppo_pn','Across_Oppo_np', ...
                    'Across_Oppo_pp','Across_Oppo_nn'}';
                
TableS7_1_Across.All_unique_ind = [{unique(cell2mat(exter_all_dimen_ind'))};{unique(cell2mat(exter_pp_dimen_ind'))};{unique(cell2mat(exter_nn_dimen_ind'))}; ...
    {unique(cell2mat(inter_all_dimen_ind'))};{ unique(cell2mat(inter_pp_dimen_ind'))}; {unique(cell2mat(inter_nn_dimen_ind'))}; ...
    {unique(cell2mat(oppo_all_dimen_ind'))};{unique(cell2mat(oppo_pn_dimen_ind'))};{unique(cell2mat(oppo_np_dimen_ind'))}; ...
    {unique(cell2mat(oppo_pp_dimen_ind'))};{unique(cell2mat(oppo_nn_dimen_ind'))}];

for i=1:4
    
    eval( ['TableS7_1_Across.',name_dimen{i},' = {exter_all_dimen{',num2str(i),'};exter_pp_dimen{',num2str(i),'};exter_nn_dimen{',num2str(i),'};' ...
        'inter_all_dimen{',num2str(i),'};inter_pp_dimen{',num2str(i),'};inter_nn_dimen{',num2str(i),'};' ...
       'oppo_all_dimen{',num2str(i),'};oppo_pn_dimen{',num2str(i),'};oppo_np_dimen{',num2str(i),'};' ...
       'oppo_pp_dimen{',num2str(i),'};oppo_nn_dimen{',num2str(i),'}}']);
     
    eval(['TableS7_1_Across.',name_dimen_ind{i},' = {exter_all_dimen_ind{',num2str(i),'};exter_pp_dimen_ind{',num2str(i),'};exter_nn_dimen_ind{',num2str(i),'};' ...
        'inter_all_dimen_ind{',num2str(i),'};inter_pp_dimen_ind{',num2str(i),'};inter_nn_dimen_ind{',num2str(i),'};' ...
       'oppo_all_dimen_ind{',num2str(i),'};oppo_pn_dimen_ind{',num2str(i),'};oppo_np_dimen_ind{',num2str(i),'};' ...
       'oppo_pp_dimen_ind{',num2str(i),'};oppo_nn_dimen_ind{',num2str(i),'}};' ]);
    
end

for i=1:11
    TableS7_1_Across.All_matrix_cumulative{i,1} = TableS7_1_Across.MID_anticihit{i}+TableS7_1_Across.MID_feedhit{i}+TableS7_1_Across.SST_stopfail{i}+TableS7_1_Across.SST_stopsucc{i};
    
end
 
TableS7.TableS7_1_Across = TableS7_1_Across(:,[1,11,2:10]);
     
save A2_2_1_1_make_mask_across.mat TableS7

