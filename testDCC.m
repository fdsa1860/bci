%% test DCC and SVM
clc;clear;close all;

%% Read data
[ym,labels,data]=read_binary_data();   % read data and labels
numLabels=numel(unique(labels));
% [~,ym,labels]=sortdata(ym,labels);
% [~,labels]=sortdata(labels,labels);

pca_dim=1;
n_class=4;
% n_set=65;
red_dim=150;
% T = Learn_DCC(Pm,n_class,n_set,pca_dim,red_dim);

% ym=T'*ym;
% save dataY ym labels;

%% Cross Validation
cRange=1;
for kk=1:length(cRange)
crossIdx=crossvalind('Kfold',size(ym,2),10);
GRlabels=[];
TTlabels=[];
for k=1:10
    % Training
    ytrain=ym(:,crossIdx~=k);
    trainLabels=labels(:,crossIdx~=k);
    
    % arg(3)==1 means enable cutting so that data are of same size
    [~,ytrain,trainLabels]=sortdata(ytrain,trainLabels,1);
    n_set=nnz(trainLabels==1);
    T = Learn_DCC(ytrain,n_class,n_set,pca_dim,red_dim);
    ytrain=T'*ytrain;
    model = svmtrain(trainLabels', ytrain',['-s 1 -t 1 -d 1 -c ' num2str(cRange(kk))]);
    
    % Testing
    ytest=ym(:,crossIdx==k);
    testLabels=labels(crossIdx==k);
    ytest=T'*ytest;
    [predicted_label, accuracy, decision_values] = svmpredict(testLabels', ytest', model);
%     pause;
    lb=predicted_label';
%     for i=1:size(ytest,2)
%         d_all=sum((repmat(ytest(:,i),1,numLabels)-template).^2);
%         [Y,I]=min(d_all);
%         lb(i)=I;
%     end
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
z(kk)=trace(precisionMat)/4
end