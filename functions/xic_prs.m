
%% PRS from the pgc
%% shooul have a  dummy variabe
R --file=PRSice_v1.25.R -q --args \
wd /share/home1/xic_fdu/project/OCD_IMAGEN/PRS_Sore/PRS_0403 \
plink /share/home1/xic_fdu/project/OCD_IMAGEN/PRS_Sore/PRSice_v1.25/plink_1.9_linux_160914 \
base /share/home1/xic_fdu/project/OCD_IMAGEN/PRS_Sore/ocd_aug2017/ocd_aug2017 \
target /home1/xic_fdu/project/IAMGEN/IMAGEN_Genetics/full-ima \
slower 0 \
sinc 0.01 \
supper 0.5 \
no.regression T \
report.individual.scores T \




   