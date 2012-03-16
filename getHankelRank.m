% get hankel rank
function y= getHankelRank(H)

thr=0.9;
y=0;
s=svd(H);
Tr=sum(s);
ss=0;

for i=1:length(s)
    ss=ss+s(i);
    if ss>=thr*Tr
        y=i;
        break;  
    end
end


end