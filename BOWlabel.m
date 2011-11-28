% This code is for BCI data processing project
% Attampt to use bags of word s to classify training data
clc;clear;close all;
% %% read data
% [ym,labels,data]=read_binary_data();   % read data and labels
load bcidata_filter0125_htlsn14;
numLabels=numel(unique(labels));

% sampling
sampleRate = 1;
[y,ym,dataLength]=sampleData(ym,sampleRate);

[yy,yms]=sortdata(ym,labels);       % sort data according to labels



fprintf('data acquired...');

%% generating feature pieces
pieces='segment';
% pieces = 'hankel';
switch pieces
    case 'segment'
        % segment
        pieceSize=floor(dataLength/sampleRate/5);
        numPiece=floor(size(ym,1)/pieceSize);
        ymspieces=reshape(yms(1:pieceSize*numPiece,:),pieceSize,numPiece*size(yms,2));  % break up yms into feature pieces
    case 'hankel'
        pieceSize=floor(dataLength/sampleRate)-100;
        ymspieces=[];
        for i=1:size(yms,2)
            ymspieces=[ymspieces hankel(yms(1:pieceSize,i),yms(pieceSize:end,i))];
        end
end

%% cluster and label pieces
numCluster=3;
[idx,C]=kmeans(ymspieces.',numCluster,'Options',statset('MaxIter',201));
idxm=reshape(idx,size(idx,1)/numLabels,numLabels);

%% histogram of each class
h1=hist(idxm(:,1),numCluster)/numel(idxm(:,1))
h2=hist(idxm(:,2),numCluster)/numel(idxm(:,2))
h3=hist(idxm(:,3),numCluster)/numel(idxm(:,3))
h4=hist(idxm(:,4),numCluster)/numel(idxm(:,4))

%% testing
for j=1:260-4
    ytest=[yms(:,j); yms(:,j+1); yms(:,j+2) ;yms(:,j+3)];
    numPiece=floor(size(ytest,1)/pieceSize);
    ytestpieces=reshape(ytest(1:pieceSize*numPiece,:),pieceSize,numPiece*size(ytest,2));
    lbl=zeros(numPiece,1);
    for i=1:numPiece
        %         [Y,I]=min(sum((C.'-repmat(ytestpieces(:,i),1,numCluster)).^2));
        [I,Y1,Y2]=zz_minVMdist(ytestpieces(:,i),C.');
        lbl(i)=I;
    end
    h=hist(lbl,numCluster)/numel(lbl)
    [lb(j,1),Y1,Y2]=zz_minVMdist(h.',[h1.' h2.' h3.' h4.']);
    lb(j,1)
    % pause;
end

lb=reshape(lb,[size(lb,1)/numLabels,numLabels])

fprintf('the groundtruth labels are:\n');
[1 2 3 4]

precisionMat=zeros(4);
for j=1:4
    for i=1:4
        precisionMat(i,j)=numel(find(lb(:,j)==i))/numel(lb(:,j));
    end
end
precisionMat



