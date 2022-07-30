function [Xmean, X] = ObtainMeanXFromAllPoses(sphereCenter,pose,TCPRs,TCPTs)

X = [];
for i = 1:size(sphereCenter,2)
    temp = inv(pose(1:3,1:3,i)) * ((TCPRs*sphereCenter(:,i)) + (TCPTs - pose(1:3,4,i)));
    X =  [X temp];
end

Xmean = [mean(X,2);1];


