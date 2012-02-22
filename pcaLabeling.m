function idx=pcaLabeling(tdata,T,template)
e=[0 0 0 0];
for i=1:4
    e(i)=norm(tdata-template(:,i)-T(:,:,i)*(T(:,:,i).'*(tdata-template(:,i))));
end

[v,idx]=min(e);

end