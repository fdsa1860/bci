% timecorr
clc;clear;close all;
%% Read data
% [ym,labels,data]=read_binary_data();   % read data and labels
load bcidata_filter0125_htlsn10;
numLabels=numel(unique(labels));
% sampling
sampleRate = 1;
[y,ym,dataLength]=sampleData(ym,sampleRate);

% [yy,yms]=sortdata(ym,labels);       % sort data according to labels

%% Cross Validation
crossIdx=crossvalind('Kfold',size(ym,2),10);
GRlabels=[];
TTlabels=[];
for k=1:10
    % Training
    ytrain=ym(:,crossIdx~=k);
    trainLabels=labels(:,crossIdx~=k);
    ytrainfft=abs(fft(ytrain));
    %         ytrainfft=angle(fft(ytrain));
    for i=1:numLabels
        template(:,i)=mean(ytrainfft(:,trainLabels==i),2);
    end
    
    % Testing
    ytest=ym(:,crossIdx==k);
    testLabels=labels(crossIdx==k);
    lb=zeros(size(testLabels));
    ytestfft=abs(fft(ytest));
    %         ytestfft=angle(fft(ytest));
    for i=1:size(ytest,2)
        d_all=sum((repmat(ytestfft(:,i),1,numLabels)-template).^2);
        [Y,I]=min(d_all);
        lb(i)=I;
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
ind=4;
ytest=ym;
yt=ytest(:);
yt=[yt(ind+1:end);yt(1:ind)];
ytest=reshape(yt,size(ym));
ytestfft=abs(fft(ytest));
    %     ytestfft=angle(fft(ytest));
for i=1:size(ytest,2)    
    d_all=sum((repmat(ytestfft(:,i),1,numLabels)-template).^2);
    [Y,I]=min(d_all);
    lb(i)=I;
end
sum(lb==labels)/260
