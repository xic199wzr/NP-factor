
function  Result_FC = xic_FC_behavior_sum(BL_subject_match,BL_subject_residual,BL_FC_table,Ex_score,In_score,Age)

BL_FC = table2array(BL_FC_table(:,1:end));
Result_FC = table;
Result_FC.FC2Pheno_name = {'ExterBehav & Exter_FC','ExterBehav & Inter_FC', ...
                           'ExterBehav & Share_FC_Con','ExterBehav & Share_FC_Dis_ex' ...
                           'InterBehav & Exter_FC','InterBehav & Inter_FC', ...
                           'InterBehav & Share_FC_Con','InterBehav & Share_FC_Dis_in'}';
                       
Exter_FC = BL_FC(:,2) - BL_FC(:,3);
Inter_FC = BL_FC(:,5);
Share_FC_Con    = BL_FC(:,6);
Share_FC_Dis_ex = BL_FC(:,7) - BL_FC(:,8);
Share_FC_Dis_in = BL_FC(:,8) - BL_FC(:,7);
                      
[~,ind1,ind2] = intersect(BL_subject_match,BL_subject_residual);

eval(['[Result_FC.',Age,'_R(1),Result_FC.',Age,'_P_onetail(1)] = corr(Exter_FC(ind1),Ex_score(ind2),''row'',''complete'');']);
eval(['[Result_FC.',Age,'_R(2),Result_FC.',Age,'_P_onetail(2)] = corr(Inter_FC(ind1),Ex_score(ind2),''row'',''complete'');']);
eval(['[Result_FC.',Age,'_R(3),Result_FC.',Age,'_P_onetail(3)] = corr(Share_FC_Con(ind1),Ex_score(ind2),''row'',''complete'');']);
eval(['[Result_FC.',Age,'_R(4),Result_FC.',Age,'_P_onetail(4)] = corr(Share_FC_Dis_ex(ind1),Ex_score(ind2),''row'',''complete'');']);

eval(['[Result_FC.',Age,'_R(5),Result_FC.',Age,'_P_onetail(5)] = corr(Exter_FC(ind1),In_score(ind2),''row'',''complete'');']);
eval(['[Result_FC.',Age,'_R(6),Result_FC.',Age,'_P_onetail(6)] = corr(Inter_FC(ind1),In_score(ind2),''row'',''complete'');']);
eval(['[Result_FC.',Age,'_R(7),Result_FC.',Age,'_P_onetail(7)] = corr(Share_FC_Con(ind1),In_score(ind2),''row'',''complete'');']);
eval(['[Result_FC.',Age,'_R(8),Result_FC.',Age,'_P_onetail(8)] = corr(Share_FC_Dis_in(ind1),In_score(ind2),''row'',''complete'');']);

eval(['Result_FC.',Age,'_P_onetail = Result_FC.',Age,'_P_onetail/2;']);
eval(['Result_FC.',Age,'_T = xic_r2t(Result_FC.',Age,'_R,length(ind1));']);
eval(['Result_FC.',Age,'_subject = repmat(length(ind1),length(Result_FC.',Age,'_R),1);']);
