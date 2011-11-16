function [ind,d,d_all]=zz_minVMdist(v,M)
% get the vector in M which is closest to v by euclidiean dist

if size(v,1)~=size(M,1)
    error('vector size should be the same as matrix size');
end
d_all=sum((repmat(v,1,size(M,2))-M).^2);
[d,ind]=min(d_all);

end
    


