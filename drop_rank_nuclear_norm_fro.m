
function Hc = drop_rank_nuclear_norm_fro(Hn,distance)

% N.Ozay, July 20, 2011;  M. Sznaier, August, 2011;
% Given mxn full rank matrix Hn (m>n) and a distance
% Approximately solves the following feasibility problem
% find Hc
% s.t. rank(Hc) = n-1
%      Hc hankel
%      ||Hn-Hc||_F<=distance

[m n] = size(Hn);

Wy = eye(m); 
Wz = eye(n);
cvx_quiet(true);
for iter = 1:5 %reweighting iterations
  cvx_begin sdp
    variable Y(m,m) symmetric
    variable Z(n,n) symmetric
    variable X(m,n)

    minimize( trace(Wy*Y)+trace(Wz*Z))
    subject to
        [Y X; X' Z] >= 0;
        norm(Hn(:)-X(:),inf)<=distance;
  cvx_end
  if isnan(X);
      if iter==1; disp('No solution found! Returning the original matrix'); Hc = Hn;
      else; X = Xold; disp('Warning: might not converge to a rank deficient solution!'); end
      break;
  else
      Xold = X;
      d = svd(X);
      delta = min(d);
      if 0
          break;
      else
          Wy = inv(Y+delta*eye(m));
          Wz = inv(Z+delta*eye(n));
      end
   end
end
disp('Min singular value is:'), disp(min(svd(X)));
Hc = X;