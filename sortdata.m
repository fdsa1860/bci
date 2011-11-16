function [yy yms]=sortdata(ym,labels)

if size(ym,2)~=size(labels,2)
    error('the number of labels should match the data size');
end

L=size(ym,1);
% N=size(unique(labels));

yy=zeros(4*L,5*13);

for i=1:4
yy(1+(i-1)*L:i*L,:)=ym(:,labels==i);
end
yms = [yy(1:L,:) yy(1+L:L+L,:) yy(1+L*2:L+L*2,:) yy(1+L*3:L+L*3,:)];