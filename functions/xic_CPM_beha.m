
function [BL_Exter_beha,BL_Inter_beha,BL_all_beha,BL_Pheno_residual_match_sub,disName] = xic_CPM_beha

models = dir('/share/inspurStorage/home1/xic_fdu/project/IAMGEN_Develop_diagnostic_0814/CPM_Models/*feed_hit.mat');
number=[4 2 5 7 3 1 6 8];

Pheno_residual = table;
Pheno_residual.name = {'asd','adhd','cd' ,'od','anxiety','dep','eat','speph'}';

for i=1:length(models)
   load(fullfile(models(1).folder,models(number(i)).name))
   sub = CPM_Result.subject; beha = CPM_Result.test;
   
   Pheno_residual.sub{i,1} = sub;
   Pheno_residual.beha{i,1} = beha;
end

[N,BIN] = histc(cell2mat(Pheno_residual.sub),unique(cell2mat(Pheno_residual.sub)));
all_sub = unique(cell2mat(Pheno_residual.sub));
all_sub = all_sub(N==8);
BL_Pheno_residual_match_sub = all_sub;

for i=1:8
    
   [~,ind1] = intersect(Pheno_residual.sub{i,1},all_sub); 
   Pheno_residual.match_beha{i,1} = Pheno_residual.beha{i}(ind1);
    
end

BL_Exter_beha = mean(cell2mat(Pheno_residual.match_beha(1:4)'),2);
BL_Inter_beha = mean(cell2mat(Pheno_residual.match_beha(5:8)'),2);
BL_all_beha   = cell2mat(Pheno_residual.match_beha');
disName = Pheno_residual.name;


