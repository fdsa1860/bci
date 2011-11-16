% Test the indep_dyn_switch_detect

clc;clear;close all;
y=zeros(200,1);
y(1:3)=[1; 1; 0];
c1=[0.7, 0.2, 0.4];
c2=[0.2, 0.7, -0.1];
for i=1:100
    y(i+3)=c1*y(i:i+2)+0.1*randn(1);
end
for i=101:200
    y(i+3)=c2*y(i:i+2)+0.1*randn(1);
end


norm_used=1;
epsilon=0.0001;
order=3;
indep_dyn_switch_detect(y,norm_used,epsilon,order)

