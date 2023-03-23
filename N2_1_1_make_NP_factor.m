
clear;clc;close all

path_model = 'CPM_Models';

model_name = {'_SST_stopsuc.mat','_SST_stopfai.mat' ...
        'SST_gowrong.mat','feed_miss.mat','feed_hit.mat' ...
        'antici_hit.mat','EFT_neutral.mat','EFT_angry.mat'};
 
name = {'SST:stop success','SST:stop failure','SST:go wrong',...
       'MID:feedmiss','MID:feedhit','MID: antici hit', ...
       'EFT:neutral','EFT:angry'};

number=[4 2 5 7 3 1 6 8];
dis_names  = {'asd','adhd','cd' ,'od','anxiety','dep','eat','speph'};

mask_id = reshape(1:8*8,8,8);
mask = reshape(tril(reshape(1:8*8,8,8),-1),[],1); 
exter_mask = [2 3 4 11 12 20];
inter_mask = [38 39 40 47 48 56];
across_mask = [33:36 41:44 49:52 57:60];
mask_id_all = tril(reshape(1:268*268,268,268),-1);

for k= 1:8

    models = dir(fullfile(path_model,['*',model_name{k}]));

    for i=1:8
        disp(i)
        
            model1 = load(fullfile(path_model,models(number(i)).name));
            network1_neg = model1.CPM_Result.neg_mask;  network1_neg(network1_neg<0.95)=0;network1_neg(network1_neg>0)=1;
            network1_pos = model1.CPM_Result.pos_mask;  network1_pos(network1_pos<0.95)=0;network1_pos(network1_pos>0)=1;

        for j=1:8
        
            if i~=j
            if net1_r(i,j) > 0.075
   
                model2 = load(fullfile(path_model,models(number(j)).name));
                network2_neg = model2.CPM_Result.neg_mask;network2_neg(network2_neg<0.95)=0;network2_neg(network2_neg>0)=1;
                network2_pos = model2.CPM_Result.pos_mask;network2_pos(network2_pos<0.95)=0;network2_pos(network2_pos>0)=1;

                neg_pos =network1_neg.*network2_pos; neg_pos_id = mask_id_all(neg_pos>0); neg_pos_id(neg_pos_id==0)=[];
                neg_neg =network1_neg.*network2_neg; neg_neg_id = mask_id_all(neg_neg>0); neg_neg_id(neg_neg_id==0)=[];
                pos_pos =network1_pos.*network2_pos; pos_pos_id = mask_id_all(pos_pos>0); pos_pos_id(pos_pos_id==0)=[];
                pos_neg =network1_pos.*network2_neg; pos_neg_id = mask_id_all(pos_neg>0); pos_neg_id(pos_neg_id==0)=[];

                neg_pos_all{i,j} =neg_pos;    neg_pos_all_id{i,j} =neg_pos_id;  
                neg_neg_all{i,j} =neg_neg;    neg_neg_all_id{i,j} =neg_neg_id; 
                pos_neg_all{i,j} =pos_neg;    pos_neg_all_id{i,j} =pos_neg_id;
                pos_pos_all{i,j} =pos_pos;    pos_pos_all_id{i,j} =pos_pos_id;

                neg_neg_num(i,j) = sum(neg_neg(:))/2;
                pos_pos_num(i,j) = sum(pos_pos(:))/2;
                pos_neg_num(i,j) = sum(pos_neg(:))/2;
                neg_pos_num(i,j) = sum(neg_pos(:))/2;

            end
            end

        end

    end
    disp(['Overlaped edges'])
  
    neg_pos_all_dimension_id{k} =neg_pos_all_id;     oppo_neg_pos_all_dimension_id{k} = unique_cell(neg_pos_all_id(across_mask));     
    neg_neg_all_dimension_id{k} =neg_neg_all_id;    oppo_neg_neg_all_dimension_id{k} = unique_cell(neg_neg_all_id(across_mask));    
    pos_neg_all_dimension_id{k} =pos_neg_all_id;     oppo_pos_neg_all_dimension_id{k} = unique_cell(pos_neg_all_id(across_mask));   
    pos_pos_all_dimension_id{k} =pos_pos_all_id;     oppo_pos_pos_all_dimension_id{k} = unique_cell(pos_pos_all_id(across_mask));    
    
    exter_neg_pos_all_dimension_id{k} = unique_cell(neg_pos_all_id(exter_mask));  inter_neg_pos_all_dimension_id{k} = unique_cell(neg_pos_all_id(inter_mask));  
    exter_neg_neg_all_dimension_id{k} = unique_cell(neg_neg_all_id(exter_mask)); inter_neg_neg_all_dimension_id{k} = unique_cell(neg_neg_all_id(inter_mask));
    exter_pos_neg_all_dimension_id{k} = unique_cell(pos_neg_all_id(exter_mask));  inter_pos_neg_all_dimension_id{k} = unique_cell(pos_neg_all_id(inter_mask));
    exter_pos_pos_all_dimension_id{k} = unique_cell(pos_pos_all_id(exter_mask)); inter_pos_pos_all_dimension_id{k} = unique_cell(pos_pos_all_id(inter_mask));

    neg_pos_all_dimension{k} =neg_pos_all;    
    neg_neg_all_dimension{k} =neg_neg_all;    
    pos_neg_all_dimension{k} =pos_neg_all;    
    pos_pos_all_dimension{k} =pos_pos_all;    

end

 
