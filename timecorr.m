% timecorr
clc;clear;close all;
%% Read data
[ym,labels,data]=read_binary_data();   % read data and labels
% load bcidata_filter0125_htlsn14;
numLabels=numel(unique(labels));
% denoise
% bandwidth = 0.1;
% htlsn_order = 10;
% ym = denoise(ym,true,bandwidth,false,htlsn_order);

% sampling
sampleRate = 1;
[y,ym,dataLength]=sampleData(ym,sampleRate);

[yy,yms]=sortdata(ym,labels);       % sort data according to labels

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
    ytest=ym(:,crossIdx==k);
    testLabels=labels(crossIdx==k);
    lb=zeros(size(testLabels));
    for i=1:size(ytest,2)
        d_all=sum((repmat(ytest(:,i),1,numLabels)-template).^2);
        [Y,I]=min(d_all);
        lb(i)=I;
    end
    GRlabels=[GRlabels testLabels];
    TTlabels=[TTlabels lb];
end

% %% Display results
% [GRlabels;TTlabels]
% precisionMat=zeros(numLabels);
% for j=1:numLabels
%     for i=1:numLabels
%         precisionMat(i,j)=nnz(TTlabels(GRlabels==j)==i)/nnz(GRlabels==j);
%     end
% end
% precisionMat
% 
% % for ind=1:266
% % ytest=data(ind+16662:ind+16662+266-1,2);
% % d_all=sum((repmat(ytest,1,numLabels)-template).^2);
% % [Y,I]=min(d_all);
% % result(ind)=I;
% % end
% % result
% % sum(result==3)
% ind=5;
% ytest=ym;
% yt=ytest(:);
% yt=[yt(ind+1:end);yt(1:ind)];
% ytest=reshape(yt,size(ym));
% for i=1:size(ytest,2)
%     d_all=sum((repmat(ytest(:,i),1,numLabels)-template).^2);
%     [Y,I]=min(d_all);
%     lb(i)=I;
% end
% sum(lb==labels)/260
