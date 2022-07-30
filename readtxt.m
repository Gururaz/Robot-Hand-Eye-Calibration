function poses = readtxt(path)

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

    poses = [];
    for i = 1: size(txttab,1)
        file = i;
        PoseValues = load(txttab(file,:));
        eulerAngles = PoseValues(1,4:6);
        poses = [poses ; PoseValues];
    end 

