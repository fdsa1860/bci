%test

function output=test(x,num_order,norm_used)

if nargin<3
    norm_used=2;
end
% load parameters;
load yy;
for i=1:num_order
p(:,i)=x(i:num_order:end,:);
% pp=[p p(:,i)];
end

p1=p(100,:);
p2=p(end,:);

data1=mean(yy(1:266,:),2);
data2=mean(yy(1+266:266+266,:),2);

for i=1:size(data1,1)-num_order
e11(i)=p1*data1(i:i+num_order-1)-data1(i+num_order);
e12(i)=p2*data1(i:i+num_order-1)-data1(i+num_order);
end
if norm(e11,norm_used)<=norm(e12,norm_used)
    fprintf('data1 is labeled with %d\n',1);
else
    fprintf('data1 is labeled with %d\n',2);
end

for i=1:size(data2,1)-num_order
e21(i)=p1*data2(i:i+num_order-1)-data2(i+num_order);
e22(i)=p2*data2(i:i+num_order-1)-data2(i+num_order);
end

if norm(e21,norm_used)<=norm(e22,norm_used)
    fprintf('data2 is labeled with %d\n',1);
else
    fprintf('data2 is labeled with %d\n',2);
end


output=[norm(e11,norm_used) norm(e12,norm_used) norm(e21,norm_used) norm(e22,norm_used)];