function ptClouddata = readptCloud(path)
files = dir(path);
files = struct2table(files);
file_names = files.name;
paths = files.folder;
ptClouddata = [];

 for i=3:length(paths)
     x  = pcread( fullfile(paths{i}, file_names{i}));
     [ptClouddata] = [ptClouddata x ];
 end
 
end