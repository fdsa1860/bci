function idx=svdLabeling(tdata,T)
e=[0 0 0 0];
for i=1:4
    e(i)=norm(tdata-T(:,:,i)*(T(:,:,i).'*tdata));
end

[v,idx]=min(e);

end
