function DF = relativeDynamicsDistance(W, index, mode)

%
% This function computes the matrix of pairwise "dynamical affinity" matrix
%
% input:
%        W: matrix with the temporal trajectories  2*Nf times Np
%          one column per point, with the (x,y) stacked
%
% output: affinity matrices  Np time Np
%
%       DF: distance computed using ||sum||-sum(|| |)
%           In this case all elements are <0, with correlated points having
%           distance ~0
%
%       DF2: distance computed using  ||sum||^2 -sum(||.||^2)
%           in this case correlated points should have distance close to 1
%           and uncorrelated ones distance close to 0.
%
%


[Nf, Np]=size(W);
Nf=Nf/2;

% each column is the trajectory of a single point
%

X=W(1:2:end,:);
Y=W(2:2:end,:);


xp=X(:,1);
yp=Y(:,1);
Hxp=hankel(xp(1:round(Nf/2)),xp(round(Nf/2):Nf));
Hyp=hankel(yp(1:round(Nf/2)),yp(round(Nf/2):Nf));
HH=[Hxp;Hyp];
% [nrh,nch]=size(HH);

% matrix frob norm for HH = [Hxp; Hyp];
Hp = [X; Y];
n = size(X, 1); m = size(Hxp, 1); p = n - m + 1;
maxRep = min(m, p);
if 2 * maxRep == n + 1
    R = [1 : maxRep maxRep - 1 : -1 : 1];
else
    R = [1 : maxRep ones(1, n - 2 * maxRep)*maxRep maxRep : -1 : 1];
end
% repmat for Hxp on top of Hyp
Rmat = repmat(R, 1, 2);
HpFrob = sqrt(Rmat * Hp.^2);
HpNorm = Hp .* repmat(1 ./ HpFrob, size(Hp, 1), 1);

% HHp = zeros(size(HH, 1) ^ 2, Np);

% if memoryCheck(10e9)
%     parfor i = 1 : Np
%         tmpHpNorm = HpNorm(:, i);
%         xp = tmpHpNorm(1:n); yp = tmpHpNorm(n+1:end);
%         tmp = [hankel(xp(1:m), xp(m:end)); hankel(yp(1:m), yp(m:end))];
%         tmpHankel = tmp*tmp';
%         HHp(:, i) = tmpHankel(:);
%     end
% else
HHp = dividedH_Ht(HpNorm, m);
% end


HHpFrob = dividedH_HtFrob(HHp, m);

indexHHp = HHp(:, index);
indexHHpFrob = HHpFrob(index);

%         for j=1:1:Np;
%             %             DF(k,j)=norm(HHp(:,:,i)+HHp(:,:,j),'fro')-norm(HHp(:,:,i),'fro')-norm(HHp(:,:,j),'fro');
%             %             DF2(k,j)=(trace(HHp(:,:,i)'*HHp(:,:,j))+ trace(HHp(:,:,j)'*HHp(:,:,i)))/(trace(HHp(:,:,i)'*HHp(:,:,i))+ trace(HHp(:,:,j)'*HHp(:,:,j)));
%             switch mode
%                 case 'DF'
%                     tmpDF(j)=norm(HHp(:,:,i)+HHp(:,:,j),'fro')-norm(HHp(:,:,i),'fro')-norm(HHp(:,:,j),'fro');
%                 case 'DF2'
%                     tmpDF(j)=(trace(HHp(:,:,i)'*HHp(:,:,j))+ trace(HHp(:,:,j)'*HHp(:,:,i)))/(trace(HHp(:,:,i)'*HHp(:,:,i))+ trace(HHp(:,:,j)'*HHp(:,:,j)));
%             end
%         end
w = [ones(1, 2 * m) 2 * ones(1, length(2*m+1 : size(HHp, 1)))];

switch mode
    case 'DF'  
% bsxfun without loop version
%         nCenter = length(index);
%         HHk = reshape(bsxfun(@power, sum(bsxfun(@times, w', bsxfun(@plus, HHp, reshape(indexHHp, size(indexHHp, 1), 1, nCenter))), 1), 1/2), length(index), Np);
        HHk = zeros(length(index), Np);
        parfor k = 1 : length(index)
            HHk(k, :) = bsxfun(@power, (w * bsxfun(@power, bsxfun(@plus, HHp, indexHHp(:, k)), 2)), 1/2);
% repmat version within loop
%             tmpHHp = bsxfun(@plus, HHp, indexHHp(:, k));            
%             tmpHHp = HHp + repmat(indexHHp(:, k), 1, Np);
%             tmpHHpFrob = dividedH_HtFrob(tmpHHp, m);
%             HHk(k, :) = tmpHHpFrob;
        end
        DF = bsxfun(@minus, bsxfun(@minus, HHk, indexHHpFrob'), HHpFrob);
%         DF = HHk - repmat(indexHHpFrob', 1, Np) - repmat(HHpFrob, length(index), 1);
    case 'DF2'
        ;
end


% normFrob = sqrt(w * (symMatrix.^2));


% end


%     switch mode
%         case 'DF'

%     for k = 1 : length(index)
%         tmpDF = zeros(1, Np);
%         iHHp = indexHHp(:, k);
%         switch mode
%             case 'DF'
%                 tmpHHp = repmat(iHHp, 1, Np) + HHp;
%                 tmpHHpFrob = sqrt(sum(tmpHHp.^2, 1));
%                 tmpDF = tmpHHpFrob - repmat(indexHHpFrob(k), 1, Np) - HHpFrob;
%         end
%
%         DF(k, :) = tmpDF;
%     end
% end

close all

return
