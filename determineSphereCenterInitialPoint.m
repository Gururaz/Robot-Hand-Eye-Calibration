function [Center_LS,r] = determineSphereCenterInitialPoint(xdata,ydata,zdata)
A = [];
B = [];

for i = 1:size(xdata)
    tempA = [];
    tempB = [];
    tempA = [-2*xdata(i) -2*ydata(i) -2*zdata(i) 1]; 
    A = [A ; tempA];
    tempB = [-xdata(i)*xdata(i) - ydata(i)*ydata(i) - zdata(i)*zdata(i)];
    B = [B ;tempB];
end    

% [U,S,V] = svd(A);
% X = B * V * pinv(S) * U';

X = pinv(A'*A) * A'*B; 
Center_LS = [X(1) X(2) X(3)];
r = sqrt(power(X(1),2) + power(X(2),2) + power(X(3),2)- X(4)); 

end