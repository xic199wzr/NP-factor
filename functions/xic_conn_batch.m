


function xic_conn_batch(spm_file,t1_file,tr,out_name,roi_name,roi_file)


% SPM_FILE = 'F:\FDU_Project\IMAGEN_Task_Rest\test_all\SPM.mat';

% STRUCTURAL_FILE = cellstr('E:\toolbox\spm12\canonical\avg152T1.nii');

% TR=inputdlg('Enter Repetition-Time (in seconds)','TR',1,{num2str('2')});

TR=tr;

%% CONN Setup
% batch.filename=fullfile(pwd,'conn_test2.mat');
batch.filename=out_name;

% if ~isempty(dir(batch.filename)), 
%     Ransw=questdlg('conn_singlesubject_nopreprocesing01 project already exists, Overwrite?','warning','Yes','No','No');
%     if ~strcmp(Ransw,'Yes'), return; end; 
% end
batch.Setup.spmfiles=spm_file;
batch.Setup.structurals=cellstr(t1_file);
batch.Setup.nsubjects=1;
batch.Setup.RT=TR;
batch.Setup.rois.names= cellstr(roi_name);
batch.Setup.rois.files{1}=roi_file;
% batch.Setup.rois.names={'Reslice_shen_2mm_268_parcellation'};
% batch.Setup.rois.files{1}='F:\FDU_Project\IMAGEN_Task_Rest\Reslice_shen_2mm_268_parcellation.nii';
batch.Setup.rois.mask = 1;           % 1/0 to mask with grey matter voxels
batch.Setup.rois.multiplelabels = 1; % 1/0 to indicate roi file contains multiple labels/ROIs

batch.Setup.isnew=1;
batch.Setup.done=1;
batch.Setup.Setup.steps = [1 0 0 0];

%% CONN Denoising
batch.Denoising.filter=[0.01,0.1];          % frequency filter (band-pass values, in Hz)
batch.Denoising.done=1;
batch.Denoising.despiking= 1;                %  0/1/2: temporal despiking with a hyperbolic tangent squashing function (1:before regression; 2:after regression) [0] 
%% CONN Analysis
%    modulation      %    conditions      : (for modulation==1 only) list of task condition names to be simultaneously entered in gPPI model (leave empty for default 'all existing conditions') []

batch.Analysis.modulation = 0;  %  temporal modulation, 0 = standard weighted GLM analyses; 1 = gPPI analyses of condition-specific temporal modulation factor, or a string for PPI analyses of other temporal modulation factor (same for all conditions; valid strings are ROI names and 1st-level covariate names)'; [0] 
batch.Analysis.measure=1;               % connectivity measure used {1 = 'correlation (bivariate)', 2 = 'correlation (semipartial)', 3 = 'regression (bivariate)', 4 = 'regression (multivariate)';
batch.Analysis.weight=2;                % within-condition weight used {1 = 'none', 2 = 'hrf', 3 = 'hanning';
batch.Analysis.type= 1;                  % analysis type, 1 = 'ROI-to-ROI', 2 = 'Seed-to-Voxel', 3 = 'all'; [3] 
batch.Analysis.sources={};              % (defaults to all ROIs)
batch.Analysis.done=1;

conn_batch(batch);

