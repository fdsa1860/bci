% Test the indep_dyn_switch_detect

clc;clear all;close all;

% N=200;
% T1=50;
% y=zeros(N,1);
% y(1:3)=[1; 1; 1];
% c1=[0.7, 0.2, -0.4];
% c2=[0.2, 0.4, -0.9];
% % % c2=c1;
% for i=1:T1
%     y(i+3)=c1*y(i:i+2)+0.01*randn(1);
% end
% for i=T1+1:N-3
%     y(i+3)=c2*y(i:i+2)+0.01*randn(1);
% end

y=zeros(10,1);
y(1:3)=[1; 1; 1];
c1=[0.7, 0.2, -0.4];
c2=[0.2, 0.4, -0.9];
% c2=c1;
for i=1:3
    y(i+3)=c1*y(i:i+2)+0.0*randn(1);
end
for i=4:7
    y(i+3)=c2*y(i:i+2)+0.0*randn(1);
end


norm_used=inf;
epsilon=0;
order=3;
p_est=indep_dyn_switch_detect(y,norm_used,epsilon,order);

H=hankel_mo(y',[4 length(y)-3]);
H'*[p_est(1:3); -1]





