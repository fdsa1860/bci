%% test DCC and SVM
clc;clear;close all;

%% Read data
[ym,labels,data]=read_binary_data();   % read data and labels
numLabels=numel(unique(labels));
[~,ym]=sortdata(ym,labels);
[~,labels]=sortdata(labels,labels);

hsize=133;
H=zeros(hsize,size(ym,1)-hsize+1,size(ym,2));
for i=1:size(ym,2)
    H(:,:,i)=hankel(ym(1:hsize,i),ym(hsize:end,i));
end

pca_dim=60;
P=[];
opt=1;
for i=1:size(ym,2)
    [P1,D1] = Eigen_Decompose(H(:,:,i),opt);
    P=[P P1(:,1:pca_dim)];
end

Pm=P;
n_class=4;
n_set=65;
red_dim=100;
T = Learn_DCC(Pm,n_class,n_set,pca_dim,red_dim);

ym=[];
Q=T'*P;
for i=1:(size(Q,2)/pca_dim)
    temp=Q(:,(i-1)*pca_dim+1:i*pca_dim);
    Y(:,:,i)=temp;
    ym(:,i)=temp(:,1);
end
save dataY ym labels;