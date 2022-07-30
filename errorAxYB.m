function dx = errorAxYB(pose,X,Y,sphereCenter)
dx= [];
B = [];

for i = 1:size(sphereCenter,2)
    B(:,i) = [sphereCenter(:,i) ; 1];
end

for i = 1 : size(pose,3)
    temp = (pose(:,:,i)*X)-(Y*B(:,i));
    dx = [temp dx];
end