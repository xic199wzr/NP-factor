# NP-factor

## Overview
This repository contains the code and documentation for estimating the task-based connectome, predicting psychiatric symptoms, analyzing cross-disorder networks, characterizing the NP factor neurobiologically, and investigating its genetic associations and generalization.

## Steps

### 1. Estimating the Task-Based Connectome for Eight Task Conditions
- **Tool**: CONN v16 batch
- **Template**: Shen-268
- **Code**: `.\functions\xic_conn_batch.m`

### 2. Predicting Each of the Eight Psychiatric Symptoms
- **Tool**: CPM-master
- **Threshold**: Default p = 0.01
- **Method**: Linear regression
- **Significance Level**: 0.05/8/8 (Bonferroni correction)
- **Code**: `.\functions\CPM-master`

### 3. Cross-Disorder Network Analysis for Each Task Condition
- **Criteria**: Edge predictive to both externalizing and internalizing symptoms
- **Analysis**: Longitudinal analysis for each group of cross-disorder networks

### 4. Neurobiological Characterization of the NP Factor
- **Aspects**: Brain anatomy, cognitive behavior relevance

### 5. Genetic Association of the NP Factor
- **PRS**: ADHD, MDD, and IQ
- **SNP**: rs6780942
- **Code**: `.\BrainSpan_NP_factor`

### 6. Generalization of the NP Factor
- **Datasets**:
  - ADHD-rest
  - ABCD-task
  - IMAGEN-rest
  - HCP-rest
  - Striatify-task
