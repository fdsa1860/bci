function lb=subspaceLabeling(ytest,ytrain,labels,Hsize,order)
% Input train data and one instance of test data, decide the label of the
% test data using subspace

numLabels = length(unique(labels));

H1 = hankel_mo(ytest',[Hsize,length(ytest)-Hsize+1]);
[U1,S1,V1] = svd(H1);
for i=1:numLabels
    dat = ytrain(:,labels==i);
    fprintf('dealing with training data %d of all %d\n',i,numLabels);    
    parfor j=1:size(dat,2)
        H2 = hankel_mo(dat(:,j)',[Hsize,length(dat(:,j))-Hsize+1]);
        [U2,S2,V2] = svd(H2);
        angles(j)=subspace(U1(:,1:order),U2(:,1:order));
    end
    all_lb(i)=mean(angles);
end
[Y,lb]=min(all_lb);

end