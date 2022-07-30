function FilteredptCloud = filterNoise(ptCloud)

th = 0.02;
nn = 25;
figure();
axis equal
%subplot(2,2,1)
pcshow(ptCloud);
title(['Original Data : ',num2str(size(ptCloud.Location))])
xlabel("X","FontSize",23)
ylabel("Y","FontSize",23)
zlabel("Z","FontSize",23)
set(gca,"FontSize",23)
hold on
FilteredptCloud = pcdenoise(ptCloud,"NumNeighbors",nn,"Threshold",th);
%FilteredptCloud = pcdenoise(FirstFilteredptCloud,"NumNeighbors",nn,"Threshold",th);
figure()
axis equal
pcshow (FilteredptCloud);
title(['Denoised Data : ',num2str(size(FilteredptCloud.Location))])
xlabel("X","FontSize",23)
ylabel("Y","FontSize",23)
zlabel("Z","FontSize",23)
set(gca,"FontSize",23)
hold on
end