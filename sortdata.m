function [yy yms lb]=sortdata(ym,labels,cut_EN)

if size(ym,2)~=size(labels,2)
    error('the number of labels should match the data size');
end
if nargin==2
    cut_EN=0;
end

L=size(ym,1);
nDat=[nnz(labels==1) nnz(labels==2) nnz(labels==3) nnz(labels==4)];
Mn=min(nDat);
Mx=max(nDat);
yy=zeros(4*L,Mx);

for i=1:4
    yy(1+(i-1)*L:i*L,1:nDat(i))=ym(:,labels==i);
end

if cut_EN==0      
    yms = [ym(:,labels==1) ym(:,labels==2) ym(:,labels==3) ym(:,labels==4)];
    lb = [ones(1,nDat(1)) 2*ones(1,nDat(2)) 3*ones(1,nDat(3)) 4*ones(1,nDat(4))];
else
    yms = [yy(1:L,1:Mn) yy(1+L:L+L,1:Mn) yy(1+L*2:L+L*2,1:Mn) yy(1+L*3:L+L*3,1:Mn)];
    lb = [ones(1,Mn) 2*ones(1,Mn) 3*ones(1,Mn) 4*ones(1,Mn) ];
end
