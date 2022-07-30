%% Main File
% Project tile : Implementation and validation of a calibration strategy for a white light interferometer statically fixed in space relative to a robot base
% Creator : Gururaj Horakeri
%           MSc. Mechatronics
% Program to find the transformation matrix between the Robot base and light interferometry 
% Clearing the environment

clear;
clc;
%% Inputs required : 
%   1. Path to read pcd data files for pure translation and combined (Rotation + translation) poses
%   2. Path to read pose data in txt format for pure translation and combined (Rotation + translation) poses 
%   3. Radius of the calibration object
%   4. Count of pure translation poses recorded 
%   5. Count of combined (Rotation + translation) poses recorded

% Path for Point cloud files(.pcd)

%
%%
sample = 6;
PcdPath = fullfile("F:\TUHH\projects\Material\SampleDataTrials", "Sample "+int2str(sample),"\PCD files\");            
% Path for saved robot path files (.txt)
txtPath =  fullfile("F:\TUHH\projects\Material\SampleDataTrials", "Sample "+int2str(sample),"\Pose files\"); 


%%
mkdir PcdPatch;
mkdir txtPath;


%%
% Radius of calibration object
radius = 12.5;

%% Data acquisition

% Mention the number of poses recorded for pure translation and combined 
pureTranslationPoseCount = 8;
combineRotTransPosesCount = 4;

% Mention the number of points to consider from the point cloud
samplePointsToRead = 50000; 

[sphereCenter] = determineSphereCenterFromPose(PcdPath,radius,samplePointsToRead);
[pose] = extractPoseDataFromReading(txtPath);

%% Step 1 : To find the TCP Rotation matrix from robot base to white light interferometry 

TCPRs = determineTCPRotation(sphereCenter,pose,pureTranslationPoseCount);

%% Step 2 : Finding Ts using determined Rs
TCPTs = determineTCPTranslationUsingRs(pose,sphereCenter,TCPRs,pureTranslationPoseCount,combineRotTransPosesCount);

%% Method 2 : With out using Rs
%[TCPTs2] = determineTCPTranslationWithoutRs(pose,sphereCenter,pureTranslationPoseCount,combineRotTransPosesCount);

%% Mergine the result to for the complete transformation matrix from TCP to robot base
Y = [TCPRs TCPTs ; 0 0 0 1];
%% To find the translation data from the end effector to the sphere center
%TCPTs = [-217.52;1458.95;985.39];
[Xmean,X] = ObtainMeanXFromAllPoses(sphereCenter,pose,TCPRs,TCPTs);
dx = errorAxYB(pose,Xmean,Y,sphereCenter);


%% Rotation matrix to euler angles
sequence = 'ZYX';
Eul = rotm2eul(TCPRs,sequence);
Deg = rad2deg(Eul);
A =dx';
[MeanE,SD] = solveEuclidean(A(:,1:3));



