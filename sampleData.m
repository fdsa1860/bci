function [yh,ymh,dataLength]=sampleData(ym,sampleRate)
cnt=0;
for k=1:size(ym,1)
    if mod(k,sampleRate)==0
        cnt=cnt+1;
        ymh(cnt,:)=ym(k,:);
%         yh(cnt,1)=ymean(k);
    end
end
dataLength=cnt;
yh=ymh(:);
