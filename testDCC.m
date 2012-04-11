%% test DCC and SVM
clc;clear;close all;

%% Read data
[ym,labels,data]=read_binary_data();   % read data and labels
numLabels=numel(unique(labels));

opt=1;
[P1,D1] = Eigen_Decompose(ym(:,labels==1),opt);
