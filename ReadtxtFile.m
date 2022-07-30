pose = [];
for x = 1:3
    txtPath =  fullfile("F:\TUHH\projects\Material\SampleDataTrials\Sample "+int2str(x),"\Pose files\"); 
    txtfiles = dir(txtPath);
    txtfiles = struct2table(txtfiles);
    txtfile_names = txtfiles.name;
    txtpaths = txtfiles.folder;
    txttab = [];

    for i=3: length(txtpaths)
       f  = fullfile(txtpaths{i}, txtfile_names{i});
       [txttab] = [txttab; f ];
    end
    
    for i = 1: size(txttab,1)
        file = i;
        PoseValues = load(txttab(file,:));
        [pose] = [pose ; PoseValues];
    end
        pose = [pose ; zeros(1,size(pose,2))];
end 
posediff1 = pose(1:12,:) - pose(14:25,:);
posediff2 = pose(1:12,:) - pose(27:38,:);
posediff3 = pose(14:25,:) - pose(27:38,:);
dlmwrite("pose_readings.csv", pose,'delimiter',',','precision',9);