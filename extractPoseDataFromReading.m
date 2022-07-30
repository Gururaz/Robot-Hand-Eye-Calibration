function [pose] = extractPoseDataFromReading(path)

    txtpath = path;
    txtfiles = dir(txtpath);
    txtfiles = struct2table(txtfiles);
    txtfile_names = txtfiles.name;
    txtpaths = txtfiles.folder;
    txttab = [];
    
    for i=3: length(txtpaths)
     f  = fullfile(txtpaths{i}, txtfile_names{i});
     [txttab] = [txttab; f ];
    end

    pose = [];
    for i = 1: size(txttab,1)
        file = i;
        PoseValues = load(txttab(file,:));
        eulerAngles = PoseValues(1,4:6);
         
      % Storing a rot and trans matrix from the txt file
        %Roll - X
        %pitch - Y
        %yaw - Z
      
        rpy =  [deg2rad(eulerAngles(3)) deg2rad(eulerAngles(2)) deg2rad(eulerAngles(1))];
      
        sequence = "ZYX"; %  Output sequence 
        rot  = eul2rotm(rpy,sequence);
 
        tran = PoseValues(1,1:3);
        temp = [rot tran'; 0 0 0 1 ];
        pose(:,:,i) = temp ;
    end   
end
