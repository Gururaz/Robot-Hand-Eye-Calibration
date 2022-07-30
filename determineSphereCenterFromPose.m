
% Program to find the sphere center from the measured point cloud

function [Center] = determineSphereCenterFromPose(path,radius,samplePointsToRead) 

% Choose the point cloud file
% Choose the number of point cloud files to read

ptClouddata = readptCloud(path);
files = size(ptClouddata,2);

Center = [];
%XmsCenter = [];
for i = 1 : files
    file = i;

%   Filter the outliners from the noisy data 
    
    originalptCloud = ptClouddata(file);
    filteredptCloud = filterNoise(originalptCloud);
    
    % Select number of samples to consider
    
    %numberOfSamples = filteredptCloud.Count;
    numberOfSamples = filteredptCloud.Count;
    [xdata,ydata,zdata] = randomPtSelection(filteredptCloud,numberOfSamples);
    
    
    % Finding the sphere center using nonlinear least square estimation (Levenberg-Marquardt Algorithm)
   
    % To have an reasonable intial point X0 we use the sphere fit algorithm 
    [Center_FGFA, ~] = sphereFitGeometric(xdata,ydata,zdata)

    [Center_LS,R_LS] = determineSphereCenterInitialPoint(xdata,ydata,zdata)

    % Initialisation:
    X0 = [double(Center_LS(1)) double(Center_LS(2)) double(Center_LS(3))];
    R = radius;
    [Center] = [Center ; LM_SphereCenter(X0,R,xdata,ydata,zdata)];

    %[XmsCenter] = [XmsCenter ; Multistartoptimization(X0,R,xdata,ydata,zdata)];
    
end
[Center] = Center';
%XmsCenter = XmsCenter'; 
end


