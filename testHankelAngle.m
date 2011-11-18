% test if hankel angle is right or wrong
for i=1:1000
    a = i*(2*pi/200);
R = [ cos(a) -sin(a); sin(a) cos(a)];

y_traj=randn(2,5);
yaff_traj=3*eye(2)*y_traj+3;

z(i)=HankelAngle(y_traj,yaff_traj);

% y_traj
% hankel_mo(y_traj,[6 2])
end
min(z)