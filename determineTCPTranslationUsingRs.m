% Pseudo inverse solver for Ax = b 

function [Xtilda] = determineTCPTranslationUsingRs(pose,sphereCenter,TCPRs,pureTranslationPoseCount,combineRotTransPosesCount)

totalPosesRecorded = pureTranslationPoseCount + combineRotTransPosesCount;

tran = [];
rot = [];
center = [];
count = 1;
%for i = (pureTranslationPoseCount+1):totalPosesRecorded
for i = 1:totalPosesRecorded
    [tran] = [tran pose(1:3,4,i)];
    rot(:,:,count) = pose(1:3,1:3,i);
    [center] = [center sphereCenter(1:3,i)];
    count = count +1;
end

%Method old
% A =[];

%  for j = 1:(totalPosesRecorded-1)   
%     x = inv(rot(:,:,j));
%     for i= j+1:(totalPosesRecorded) % CHANGE TO COMBINED
%     y = inv(rot (:,:,i));
%     z = y-x;
%     [A] = [A ; z];
%     end
% end
% 
% 
% B = [];

% for j = 1:(totalPosesRecorded-1)    
%    x = inv(rot(:,:,j))*((TCPRs*center(:,j))-tran(:,j));
%    for i = j+1:(totalPosesRecorded)          % CHANGE TO COMBINED
%         y = inv(rot(:,:,i))*((TCPRs*center(:,i))-tran(:,i));  
%         z = x-y;
%         [B] = [B ;z];
%     end    
% end
c=0;
A =[];
 for j = 1:(totalPosesRecorded-1)   
    x = inv(rot(:,:,j));
    for i= (totalPosesRecorded-combineRotTransPosesCount+1) :(totalPosesRecorded) % CHANGE TO COMBINED
    y = inv(rot(:,:,i));
    z = y-x;
    c = c+1;
    [A] = [A ; z];
    end
end


B = [];
for j = 1:(totalPosesRecorded-1)    
   x = inv(rot(:,:,j))*((TCPRs*center(:,j))-tran(:,j));
   for i = (totalPosesRecorded-combineRotTransPosesCount+1):(totalPosesRecorded)  % CHANGE TO COMBINED
        y = inv(rot(:,:,i))*((TCPRs*center(:,i))-tran(:,i));  
        z = x-y;
        [B] = [B ;z];
    end    
end




% Here A = inv(Differencein Rotation Matrix) & B = inv(,  solve for Xtilda
% [u,sigma,V'] = svd(A)
% Pseudo inverse of A = V*inv(sigma)*U' 
%xtilda = pseudo inverse of A * b

 Xtilda = inv(A'*A) * A'*B;
%  [U,S,V] = svd(A);
%  Xtilda = V*pinv(S)*U'*B;

end

