% Specify the folder path
folderPath = 'C:\Users\cmadrigal\OneDrive - Estudiantes ITCR\COMSOL\Sim de Ronald\INFUSORES Y DIFUSORES\COMSOL';

% Get list of all files in the folder
fileList = dir(fullfile(folderPath, '*')); 

% Remove directories (like '.' and '..')
fileList = fileList(~[fileList.isdir]);

% Extract file names
fileNames = {fileList.name};

% Display file names
% disp(fileNames);

lastThree = cellfun(@(x) lower(x(max(1,end-2):end)), fileNames, 'UniformOutput', false);

% Display result
% disp(lastThree);

mphFiles = [];

for i=1:length(lastThree)
    if lastThree(i) == "mph"
        mphFiles = [mphFiles fileNames(i)];
    end
end


for i=1:length(mphFiles)
    try
        disp(mphFiles(i))
        filePath = append(folderPath,'\');
        model = mphopen(append(filePath,mphFiles{i}))

    catch ME
        warning('Error reading file %s: %s', fileNames{i}, ME.message);
    end
end