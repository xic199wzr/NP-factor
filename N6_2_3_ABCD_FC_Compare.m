

clear;clc

load('N5_3_2_2_ABCD_FC_SST_v2.mat')
load('N5_3_2_ABCD_FC_MID_v2.mat')

[~,ind1,ind2] = intersect(ABCD_FC_SST.subID,ABCD_FC_MID.subID);
ABCD_FC_SST = ABCD_FC_SST(ind1,:);
ABCD_FC_MID = ABCD_FC_MID(ind2,:);

%% BL behavior
load('N5_3_2_ABCD_Tables_v2.mat')

i =5;
dat_table = abcd_dat_resi{i};
[bl_sub,ind1,ind2] = intersect(dat_table.sub,ABCD_FC_SST.subID);

cbcl_bl = table2array(dat_table(ind1,2:end));
fc_bl_sst     = table2array(ABCD_FC_SST(ind2,2:end));
fc_bl_mid     = table2array(ABCD_FC_MID(ind2,2:end));

fc_bl = fc_bl_sst +fc_bl_mid;
[r1,p1] = corr(cbcl_bl,fc_bl);

%% FU2 Behavior
load('N5_3_2_ABCD_Tables_v2_fu2.mat')
dat_table = abcd_dat_resi{i};
[fu2_sub,ind1,ind2] = intersect(dat_table.sub,ABCD_FC_SST.subID);

cbcl_fu2 = table2array(dat_table(ind1,2:end));
fc_bl_sst     = table2array(ABCD_FC_SST(ind2,2:end));
fc_bl_mid    = table2array(ABCD_FC_MID(ind2,2:end));
fc_fu2 = fc_bl_sst + fc_bl_mid;
[r2,p2] = corr(cbcl_fu2,fc_fu2);

%% combine BL and FU2

[~,ind1,ind2] = intersect(bl_sub,fu2_sub);
[r3 ,p3] = partialcorr(cbcl_fu2(ind2,:),fc_fu2(ind2,5),cbcl_bl(ind1,5));

[r4 ,p4] = corr(fc_fu2(ind2,5),(cbcl_fu2(ind2,:)+cbcl_bl(ind1,5)));

Rvalue_CBCL = table;
Rvalue_CBCL.name = dat_table.Properties.VariableNames(2:end)';
Rvalue_CBCL.BL_R = r1(:,5);
Rvalue_CBCL.BL_P = p1(:,5)/2;
Rvalue_CBCL.FU_R = r2(:,5);
Rvalue_CBCL.FU_P = p2(:,5)/2;
Rvalue_CBCL.Partial_FU_R = r3;
Rvalue_CBCL.Partial_FU_P = p3/2;
Rvalue_CBCL.BL_FU_R = r4';
Rvalue_CBCL.BL_FU_P = p4';

