function m = mlocal(XY)
% Computes element mass matrix for a linear triangular element
x1= XY(1,1); x2= XY(2,1); x3= XY(3,1);
y1= XY(1,2); y2= XY(2,2); y3= XY(3,2);

J= [ x1-x3 x2-x3; y1-y3 y2-y3];
 det_J= det(J);
m = det_J *1/24*[2 1 1; 1 2 1; 1 1 2]; % mass matrix in local coordinates
