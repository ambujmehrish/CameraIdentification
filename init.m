global SVM_TRAIN;
global SVM_PREDICT;

% Set Paths
addpath(fullfile(pwd,'.'));
addpath(fullfile(pwd,'ForwardFit'));
addpath(fullfile(pwd,'ProbInvert'));

% Set Paths to SVM command files
SVM_TRAIN = fullfile(pwd,'ForwardFit/svm/svm-train');
SVM_PREDICT = fullfile(pwd,'ForwardFit/svm/svm-predict');
