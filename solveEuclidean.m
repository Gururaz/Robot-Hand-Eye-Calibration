function [meanEuclidean,SD] = solveEuclidean(datapoints)

MeanXYZ = mean(datapoints);
Euclidean = pdist2(datapoints,MeanXYZ,"euclidean");
meanEuclidean = mean(Euclidean);
SD = std(Euclidean);
end