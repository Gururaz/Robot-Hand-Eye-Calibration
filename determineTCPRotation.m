% Pseudo inverse solver for xA = b 

function [Xtilda] = determineTCPRotation(sphereCenter,pose,pureTranslationPoseCount)

% Segregating pure translational poses from all recorded poses

translationPose = [];
center = [];
for i = 1:pureTranslationPoseCount
    [translationPose] = [translationPose pose(1:3,4,i)];
    [center] = [center sphereCenter(1:3,i)];
end

A =[];   % reduced centeres
for j = 1:(pureTranslationPoseCount-1)
    x = center(:,j);
    for i = (j+1):pureTranslationPoseCount
    y = center(:,i);
    z = x-y;
    [A] = [A z];
    end
end

B = [];  % reduced translation poses
for j= 1:(pureTranslationPoseCount-1)
    x = translationPose(:,j);
    for i = j+1:pureTranslationPoseCount
    y = translationPose(:,i);
    z = x-y;
    [B] = [B z];
    end
end

% Concept of SVD for LSE
% Here A = Center, B = tran, solve for X tilda
% [u,sigma,V'] = svd(A)
% Pseudo inverse of A = V*inv(sigma)*U' 
% xtilda = pseudo inverse of A * b

Xtilda = B/A;
[U,S,V] = svd(A);
Xtilda1 = B * V * pinv(S) * U';

% Method 2 
% Transpose XA = b to A^T X^T = b^T

At = A';
Bt = B';
Xt = inv(At'*At) * At'*Bt;

end
