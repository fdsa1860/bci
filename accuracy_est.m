%test

function accuracy=accuracy_est(x,num_order,norm_used)

if nargin<3
    norm_used=2;
end
% load parameters;
load yy;
for i=1:num_order
p(:,i)=x(i:num_order:end,:);
% pp=[p p(:,i)];
end

p1=p(1,:);
p2=p(end,:);

data=[yy(1:266,:) yy(1+266:266+266,:) yy(1+266*2:266+266*2,:) yy(1+266*3:266+266*3,:)];
label=[ones(65,1) 2*ones(65,1) 3*ones(65,1) 4*ones(65,1)];

wrong=0;
right=0;

for j=1:size(data,2)/2
    for i=1:size(data(:,j),1)-num_order
        e1(i)=p1*data(i:i+num_order-1,j)-data(i+num_order,j);
        e2(i)=p2*data(i:i+num_order-1,j)-data(i+num_order,j);
    end
    if (norm(e1,norm_used)<=norm(e2,norm_used) && label(j)==1) ||...
            (norm(e1,norm_used)>norm(e2,norm_used) && label(j)==2)        
        right=right+1;
    else
        wrong=wrong+1;
    end
end
accuracy=right/(right+wrong);
right
wrong
    


% data1=mean(yy(1:266,:),2);
% data2=mean(yy(1+266:266+266,:),2);
% 
% for i=1:size(data1,1)-num_order
% e11(i)=p1*data1(i:i+num_order-1)-data1(i+num_order);
% e12(i)=p2*data1(i:i+num_order-1)-data1(i+num_order);
% end
% if norm(e11,norm_used)<=norm(e12,norm_used)
%     fprintf('data1 is labeled with %d\n',1);
% else
%     fprintf('data1 is labeled with %d\n',2);
% end
% 
% for i=1:size(data2,1)-num_order
% e21(i)=p1*data2(i:i+num_order-1)-data2(i+num_order);
% e22(i)=p2*data2(i:i+num_order-1)-data2(i+num_order);
% end
% 
% if norm(e21,norm_used)<=norm(e22,norm_used)
%     fprintf('data2 is labeled with %d\n',1);
% else
%     fprintf('data2 is labeled with %d\n',2);
% end
% 
% 
% output=[norm(e11,norm_used) norm(e12,norm_used) norm(e21,norm_used)
% norm(e22,norm_used)];