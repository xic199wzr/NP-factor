# NP-factor
## First, estimating the task-based connectome for eight task conditions 
### CONN v16 batch with the shen-268 template
### code for task-based connectome estimation: .\functions\xic_conn_batch.m

## Second, predicting each of the eight psychiatric symptoms
### code for brain-behavior prediction:.\functions\CPM-master
### using the default threshold p = 0.01, linear regression 
### the significance level was set as 0.05/8/8 with Bonferroni correction

## Thrid, we conducted the cross-disorder network for each task condition 
### the edge was both predictive to externalising and internalising symptoms
### the longitudinal analysis for each group of cross-disorder network

## Fourth, neurobiological characterisation of the NP factor 
### Brain anatomy, Cognitive behavior relevance

## Fifth, genetic association of the NP factor
### PRS of ADHD, MDD and IQ
### SNP of rs6780942
### code for gene expression:.\BrainSpan_NP_factor

## Last, generalisation of the NP factor
### ADHD-rest
### ABCD-task
### IMAGEN-rest
### HCP-rest
### Striatify-task
