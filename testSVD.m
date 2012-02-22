% This code is for BCI data processing project
% Hankel Angle is utilized to classify training data
clc;clear;close all;
%% read data
[ym,labels,data]=read_binary_data();   % read data and labels
% load bcidata_filter0125_htlsn10;
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

ymfft=fft(ym);
ymfft1=ymfft(:,labels==1);
[U5,S5,V5]=svd(ymfft1);

ym1=ym(:,labels==1);
ym2=ym(:,labels==2);
ym3=ym(:,labels==3);
ym4=ym(:,labels==4);
[U1,S1,V1]=svd(ym1);
[U2,S2,V2]=svd(ym2);
[U3,S3,V3]=svd(ym3);
[U4,S4,V4]=svd(ym4);

T1=U1(:,1:40);
T2=U2(:,1:40);
T3=U3(:,1:40);
T4=U4(:,1:40);

tdata=ym(:,end);

e1=tdata-T1*(T1.'*tdata);

% yh=drop_rank_nuclear_norm_fro(ym,10);

%% Cross Validation
crossIdx=crossvalind('Kfold',size(ym,2),10);
GRlabels=[];
TTlabels=[];
for k=1:10
    % Training
    ytrain=ym(:,crossIdx~=k);
    trainLabels=labels(:,crossIdx~=k);
    for i=1:numLabels
%         template(:,i)=mean(ytrain(:,trainLabels==i),2);
        [U,S,V]=svd(ytrain(:,trainLabels==i));
        T(:,1:40,i)=U(:,1:40);
    end
    
    % Testing
    ytest=ym(1:266,crossIdx==k);
    testLabels=labels(crossIdx==k);
    lb=zeros(size(testLabels));
    for i=1:size(ytest,2)
%         lb(i)=Hlabeling(ytest(:,i),template,numLabels);
        lb(i)=svdLabeling(ytest(:,i),T);
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

% for ind=1:266
% ytest=data(ind+16662:ind+16662+266-1,2);
% d_all=sum((repmat(ytest,1,numLabels)-template).^2);
% [Y,I]=min(d_all);
% result(ind)=I;
% end
% result
% sum(result==3)