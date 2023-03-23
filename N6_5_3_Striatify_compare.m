
addpath('/share/home1/xic_fdu/project/IAMGEN_Develop_diagnostic_0814/Trans_diagnostic_p_facotr')
addpath('/share/home1/xic_fdu/project/IMAGEN_Develop_NatMed_revise')

clear;clc
data = readtable('/share/home1/ISTBI_data/IMAGEN_Stratify/psytools/STRATIFY_demographics.csv');
dawba = readtable('/share/home1/xic_fdu/project/IMAGEN_Develop_NatMed_revise/Striatify_model/STRATIFY_dawba.csv');
adhd =  readtable('/share/home1/ISTBI_data/IMAGEN_Stratify/psytools/STRATIFY-STRATIFY_ADHD-BASIC_DIGEST.csv');
adhd_dat = table2array(adhd(:,29:end));
adhd_dat_age = table2array(adhd(:,5))/365;
% [r p] = corr(ashd_dat,'row','complete');
adhd_dat_sum = nansum(adhd_dat,2);
adhd_sub = adhd.UserCode;


% covainfo
sub_site = (string(data.recruitmentSite));
sub_site(contains(sub_site,'BERLIN'))=1;
sub_site(contains(sub_site,'LONDON'))=2;
sub_site(contains(sub_site,'SOUTHAMPTON'))=3;

sub_gender  = data.sex;
sub_cova = [ones(length(sub_gender),1),contains(sub_gender,'F'),dummyvar(str2double(sub_site))];
sub_cova(:,end)=[];

sub_id = data.PSC2;
sub_type = string(data.patientGroup);
for i=1:length(sub_type)
    if (sub_type(i))=='';
        sub_type(i)='NaN';
    end
end

[sub_idAll,ind1,ind2] = intersect(adhd_sub,sub_id);
adhd_dat_sum = adhd_dat_sum(ind1);
sub_cova = sub_cova(ind2,:);
sub_type = sub_type(ind2);
sub_age  = adhd_dat_age(ind1);

% fc dat
mid  = load('/share/home1/xic_fdu/project/IMAGEN_Develop_NatMed_revise/Striatify_model/old/N5_3_2_1_Striatify_FC_MID_v2.mat');
sst  = load('/share/home1/xic_fdu/project/IMAGEN_Develop_NatMed_revise/Striatify_model/old/N5_3_2_1_Striatify_FC_SST_v2.mat');

mid_sub = mid.Striatify_FC_MID.subID;
mid_dat = mid.Striatify_FC_MID.oppo_pp;

sst_sub = sst.Striatify_FC_SST.subID;
sst_dat = sst.Striatify_FC_SST.oppo_pp;
%% subject
[~,ind1,ind2] = intersect(mid_sub,sub_idAll);
sub_type1 = sub_type(ind2);
sum(contains(sub_type1,'Control'))

[~,ind1,ind2] = intersect(sst_sub,sub_idAll);
sub_type1 = sub_type(ind2);
sum(contains(sub_type1,'Control'))

%% Combine
[~,ind1,ind2] = xic_intersect(mid_sub,sst_sub,sub_idAll);
[r p] = corr(sst_dat(ind2), mid_dat(ind1))

%% SST
[~,ind1,ind2] = intersect(sst_sub,sub_idAll);

% sub_fc =  sst_dat(ind2)+ mid_dat(ind1);
sub_fc =  sst_dat(ind1);
sub_fc_type = sub_type(ind2);
sub_adhd = adhd_dat_sum(ind2);
sub_age = sub_age(ind2);
sub_cova = sub_cova(ind2,:);
sub_sex  = sub_cova(:,2);

[~,~,sub_fcR] = regress(sub_fc,sub_cova) ;
[r p] = corr(sub_fcR,sub_adhd);

control_id = contains(sub_fc_type,'Control')+ contains(sub_fc_type,'NaN');
AN_id = contains(sub_fc_type,'AN');
AUD_id = contains(sub_fc_type,'AUD');
BN_id = contains(sub_fc_type,'BN');
MDD_id = contains(sub_fc_type,'MDD');

adhd_score_control = sub_adhd(control_id==1);
adhd_score_case = sub_adhd(control_id~=1);

sub_fc_control = sub_fcR(control_id==1);
% sub_fc_case = sub_fcR(control_id~=1);
sub_fc_case = sub_fcR((AN_id + AUD_id + BN_id + MDD_id)==1);

sub_fc_AN = sub_fcR(AN_id==1);
sub_fc_AUD = sub_fcR(AUD_id==1);
sub_fc_BN = sub_fcR(BN_id==1);
sub_fc_MDD = sub_fcR(MDD_id==1);

[tvalue,p,dvalue] = xic_ttest2(sub_fc_case,sub_fc_control);
 
[tvalue,p,dvalue] = xic_ttest2(sub_fc_AN,sub_fc_control);
[tvalue,p,dvalue] = xic_ttest2(sub_fc_AUD,sub_fc_control);

[tvalue,p,dvalue] = xic_ttest2(sub_fc_BN,sub_fc_control);
[tvalue,p,dvalue] = xic_ttest2(sub_fc_MDD,sub_fc_control);

