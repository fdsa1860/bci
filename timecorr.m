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

load bcidata_lowpass_35Hz;
load bcidata_lowpass_35Hz_SRPCA_7_100000;
load bcidata_lowpass_35Hz_SRPCA_7_100000_HSTLN_10;

FILTER_EN=0;

if FILTER_EN==1
    B=25;
    F=ones(size(ym,1),1);
    F(1+B:length(F)-B)=0;
    for i=1:size(ym,2)
        Y(:,i)=fft(ym(:,i)).*F;
        ymF(:,i)=real(ifft(Y(:,i)));    % not a good filter
        %     plot(abs(fftshift(fft(ymF(:,i)))),'b');
    end
%     keyboard;
end
% % sampling
% sampleRate = 1;
% [y,ym,dataLength]=sampleData(ym,sampleRate);

% [yy,yms]=sortdata(ym,labels);       % sort data according to labels

ym=ym;
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
%         template1=mean(ytrain(:,trainLabels==i),2);
%         template(:,i)=SRPCA_e1_e2_clean(template1,5,100000,ones(size(ym,1),1));
%         figure(1);
%         plot(template1,'r');hold on;   plot(template(:,i),'b'); hold off;
%         pause;
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

%% Display results
[GRlabels;TTlabels]
precisionMat=zeros(numLabels);
for j=1:numLabels
    for i=1:numLabels
        precisionMat(i,j)=nnz(TTlabels(GRlabels==j)==i)/nnz(GRlabels==j);
    end
end
precisionMat
trace(precisionMat)/4
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
