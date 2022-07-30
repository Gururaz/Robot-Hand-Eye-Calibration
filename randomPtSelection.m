function [xdata,ydata,zdata] = RandomPtSelection(filteredptCloud,NumberOfSamples)

RandomPointCloud = datasample(filteredptCloud.Location,NumberOfSamples,'Replace',false);

xdata = double(RandomPointCloud(:,1));
ydata = double(RandomPointCloud(:,2));
zdata = double(RandomPointCloud(:,3));
%  subplot(2,2,3)
% pcshow (pointCloud(RandomPointCloud),"VerticalAxis","Z");
% title(['Number of samples : ', NumberOfSamples])
% hold on;
end