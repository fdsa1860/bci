function DF = relativeDynamicsDistance_HHp(HHp, HHpFrob, index, w)

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

Np = size(HHp, 2);

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
% w = [ones(1, 2 * m) 2 * ones(1, length(2*m+1 : size(HHp, 1)))];

  
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

return
