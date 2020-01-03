function k = klocal(X)

kp = 1; 
B = [-1 1 0; -1 0 1]; 
detJ = det([1,1,1; X']); 
jinv = (1/detJ)*[X(3,2)-X(1,2) X(1,1)-X(3,1); X(1,2)-X(2,2) X(2,1)-X(1,1)];
k = kp * 0.5 * (B') * jinv * (jinv') * B * detJ;
