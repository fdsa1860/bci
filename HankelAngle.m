function DF=HankelAngle(x1,x2,order)

if numel(x1)>numel(x2)
    temp=x1;
    x1=x2;
    x2=temp;
end

if nargin<3
    order=round(numel(x1)/2);
end

% xLength=size(x1,1);
% if mod(xLength,2)==0
%     x1=x1(1:xLength-1,1);
%     x2=x2(1:xLength-1,1);
%     Hsize = xLength/2;
% else
%     Hsize = (xLength+1)/2;
% end


H1=hankel_mo(x1,[length(x1)-order+1,order]);
H2=hankel_mo(x2,[length(x2)-order+1,order]);

% order=10;
% H1=hankel(x1(1:end-order+1),x1(end-order+1:end));
% L=length(x1(1:end-order+1));
% H2=hankel(x2(1:L),x2(L:end));

H1=H1/norm(H1,'fro');
H2=H2/norm(H2,'fro');
% keyboard;

DF= norm(H1*H1.'+H2*H2.','fro')-norm(H1*H1.','fro')-norm(H2*H2.','fro');
end