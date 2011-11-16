% This code is for BCI data processing project
% Hankel Angle is utilized to classify training data
clc;clear;close all;
%% read data
[ym,labels,data]=read_binary_data();   % read data and labels
numLabels=numel(unique(labels));

% % denoise 
% for i=1:size(ym,2)
% [yph,eta,x] = hstln_mo(ym(:,i)',20);
% yph=yph';
% keyboard;
% ym(:,i)=yph;
% end

% load bci_data_label
% ym=bci.data;
% labels=bci.label;
% numLabels=numel(unique(labels));

% load bci_denoised
% numLabels=numel(unique(labels));

fprintf('data acquired\n');

sampleRate = 1;                     % sampling
[y,ym,dataLength]=sampleData(ym,sampleRate);
fprintf('data sampling done\n');



%% Cross Validation
crossIdx=crossvalind('Kfold',size(ym,2),10);
GRlabels=[];
TTlabels=[];
for k=1:10
    % Training
    ytrain=ym(:,crossIdx~=k);
    trainLabels=labels(:,crossIdx~=k);
    for i=1:numLabels
        template(:,i)=mean(ytrain(:,trainLabels==i),2);
    end
    
    % Testing
    ytest=ym(1:266,crossIdx==k);
    testLabels=labels(crossIdx==k);
    lb=zeros(size(testLabels));
    for i=1:size(ytest,2)
        lb(i)=Hlabeling(ytest(:,i),template,numLabels);
    end
    GRlabels=[GRlabels testLabels];
    TTlabels=[TTlabels lb];
end

%% Display results
[GRlabels;TTlabels]
precisionMat=zeros(numLabels);
for j=1:numLabels
    for i=1:numLabels
        precisionMat(i,j)=nnz(TTlabels(GRlabels==j)==i)/nnz(GRlabels==j);
    end
end
precisionMat

for ind=1:266
ytest=data(ind+16662:ind+16662+266-1,2);
d_all=sum((repmat(ytest,1,numLabels)-template).^2);
[Y,I]=min(d_all);
result(ind)=I;
end
result
sum(result==3)