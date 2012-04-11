%% test SVM
clc;clear;close all;
%% Read data
[ym,labels,data]=read_binary_data();   % read data and labels
numLabels=numel(unique(labels));

% FILTER_EN=1;    %enable or disable low pass filter
% SEL_EN=1;    %enable or disable selection
% %% Lowpass filter
% if FILTER_EN==1
%     B=25;
%     F=ones(size(ym,1),1);
%     F(1+B:length(F)-B)=0;
%     for i=1:size(ym,2)
%         Y(:,i)=fft(ym(:,i)).*F;
%         ymF(:,i)=real(ifft(Y(:,i)));    % not a good filter
% %         figure(1);
% %         plot(ym(:,i),'r');hold on;        
% %         plot(real(ymF(:,i)),'k');
% %         hold off;
% %         figure(2);
% %         plot(abs(fftshift(fft(ym(:,i)))),'r');
% %         hold on;
% %         plot(abs(fftshift(fft(ymF(:,i)))),'k');
% %         hold off;
% %         pause;
%     end
%     %     keyboard;
% end
% %% Select only the good data
% if SEL_EN
%     Ind=ones(size(ymF,2),1);
%     parfor i=1:size(ymF,2)
%         if norm(ymF(:,i),inf)>50
%             Ind(i)=0;
%         end
%     end
% end
% %% mask out bad data
% mask=Ind;
% ym=ym(:,mask==1);
% ymF=ymF(:,mask==1);
% labels=labels(:,mask==1);
% sum(labels==1)
% sum(labels==2)
% sum(labels==3)
% sum(labels==4)
% x1=ym(:,labels==1);
% x2=ym(:,labels==2);
% x3=ym(:,labels==3);
% x4=ym(:,labels==4);
% ym=[x1(:,1:37) x2(:,1:37) x3(:,1:37) x4(:,1:37)];
% labels=[ones(1,37) 2*ones(1,37) 3*ones(1,37) 4*ones(1,37)];

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
    model = svmtrain(trainLabels', ytrain',['-s 1 -t 1 -d 1 -c ' num2str(cRange(kk))]);
    
    % Testing
    ytest=ym(:,crossIdx==k);
    testLabels=labels(crossIdx==k);
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
% plot(z);