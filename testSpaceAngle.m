% This code is for BCI data processing project
% Hankel Angle is utilized to classify training data
clc;clear;close all;
%% read data
[ym,labels,data]=read_binary_data();   % read data and labels
% load bcidata_filter0125_htlsn10;
% numLabels=numel(unique(labels));
% load bcidata_0315_SRPCA_HSTLN_manually_selected.mat;
% load bcidata_SRPCA0315_5_1000_first26data;

x=ym(:,1);
% for i=3:size(ym,2)
% % ymR(:,i)=SRPCA_e1_e2_clean(ym(:,i),4.44,1000,ones(size(x)));
% % ymR(:,i)=SRPCA_e1_e2_clean(ym(:,i),4.34,100000,ones(size(x)));
% ymR(:,i)=SRPCA_e1_e2_clean(ym(:,i),5,100000,ones(size(x)));
% plot(ym(:,i),'b'); hold on; plot(ymR(:,i),'r');hold off;
% end
% ym = ymR;
% keyboard;
%%
ymR(:,1)=SRPCA_e1_e2_clean(ym(:,1),4.34,100000,ones(size(x)));
ymR(:,2)=SRPCA_e1_e2_clean(ym(:,2),4.34,100000,ones(size(x)));
ymR(:,3)=SRPCA_e1_e2_clean(ym(:,3),5,100000,ones(size(x)));
ymR(:,14)=SRPCA_e1_e2_clean(ym(:,14),5,100000,ones(size(x)));

% load bcidata_SRPCA0315_5_1000_first26data.mat
% denoise 
for i=[1 2 3 14]
[yph,eta,x] = hstln_mo(ymR(:,i)',10);
hold on;
plot(ym(:,i),'r');
hold off;
yph=yph';
% keyboard;
ymH(:,i)=yph;
end
%%
yH1 = hstln_mo(ymR(:,1)',10)';
yH2 = hstln_mo(ymR(:,2)',10)';
yH3 = hstln_mo(ymR(:,3)',10)';
yH4 = hstln_mo(ymR(:,14)',10)';

% mask=ones(1,26);
% mask([15,18,19,20,21,23])=0;
% ym=ym(:,mask==1);
% ymR=ymR(:,mask==1);
% ymH=ymH(:,mask==1);
% labels=labels(:,mask==1);

% load bcidata_0315_SRPCA_HSTLN_first26data;

fprintf('data acquired\n');

% sampleRate = 1;                     % sampling
% [y,ym,dataLength]=sampleData(ym,sampleRate);
% fprintf('data sampling done\n');

% [yy,yms]=sortdata(ym,labels);       % sort data according to labels
% 
% for k=1:13
for j=10:233
    for i=1
        x1=yH1;
        x2=yH2;
        x3=yH3;
        x4=yH4;
        H1=hankel_mo(x1',[j,length(x1)-j+1]);
        H2=hankel_mo(x2',[j,length(x2)-j+1]);
        H3=hankel_mo(x3',[j,length(x3)-j+1]);
        H4=hankel_mo(x4',[j,length(x4)-j+1]);
        [U1,S1,V1]=svd(H1);
        [U2,S2,V2]=svd(H2);
        [U3,S3,V3]=svd(H3);
        [U4,S4,V4]=svd(H4);
        
        angles1(i)=subspace(U1(:,1:10),U2(:,1:10));
        angles2(i)=subspace(U1(:,1:10),U3(:,1:10));
        angles3(i)=subspace(U1(:,1:10),U4(:,1:10));
    end
    angleNorms(j,:)=[norm(angles1,2) norm(angles2,2) norm(angles3,2)];
    % keyboard;
end

% figure;
hold on;
plot(angleNorms(:,1),'b');
plot(angleNorms(:,2),'g');
plot(angleNorms(:,3),'m');
hold off;
% keyboard;
% end
keyboard;

%% Cross Validation
crossIdx=crossvalind('Kfold',size(ym,2),10);
order = 10;
HCount = 1;
for Hsize=60:62
    fprintf('Hsize = %d\n',Hsize);
GRlabels=[];
TTlabels=[];
parfor k=1:10
    fprintf('performing %d th of 10 experiments\n',k);
    % Training
    ytrain=ym(:,crossIdx~=k);
    trainLabels=labels(:,crossIdx~=k);
%     parfor i=1:numLabels
%         template(:,i)=mean(ytrain(:,trainLabels==i),2);
%     end
    
    % Testing
    ytest=ym(1:266,crossIdx==k);
    testLabels=labels(crossIdx==k);
    lb=zeros(size(testLabels));
%     Hsize = 40;
    
    for i=1:size(ytest,2)
        fprintf('computing label of %d th test data of all %d \n', i,size(ytest,2));
        lb(i)=subspaceLabeling(ytest(:,i),ytrain,trainLabels,Hsize,order);        
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
A(:,:,HCount)=precisionMat
HCount=HCount+1;
end
% for ind=1:266
% ytest=data(ind+16662:ind+16662+266-1,2);
% d_all=sum((repmat(ytest,1,numLabels)-template).^2);
% [Y,I]=min(d_all);
% result(ind)=I;
% end
% result
% sum(result==3)