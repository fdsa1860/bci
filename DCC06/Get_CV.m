% a sub ftn. of 'Learn_DCC.m'
% Ftn. to compute canonical vectors
%
% Copyright by Tae-Kyun Kim, Department of Engineering, University of
% Cambridge (http://mi.eng.cam.ac.uk/~tkk22)
%
% Written by T-K. Kim, 17 May 2006

function [can1 can2] = Get_CV(T,V_tr,V_te);

[Y C Z] = svd((T'*V_tr)'*(T'*V_te));
can1 = V_tr*Y;
can2 = V_te*Z;