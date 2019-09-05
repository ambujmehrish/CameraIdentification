clear
close all
cameraname = 'ImageDatabase/NikonD5200';
rawimageFolder = strcat(cameraname,'/RAW/');
jpgimageFolder = strcat(cameraname,'/JPG/');
maskFolder = strcat(cameraname,'/CHECKER/');
maskFiles = dir([maskFolder,'*_mask.txt']);
index = 1;
for i = 1:size(maskFiles,1)
    try
        
disp( ['Processing Image' , num2str(i)])
[~,fileName,~]=fileparts(maskFiles(i).name);
C = strsplit(fileName,'.');
fileName = C{1};
rawfileName = strcat(rawimageFolder,fileName,'.mat');
jpgfileName = strcat(jpgimageFolder,fileName,'.mat');
rawData = load(rawfileName);
jpgData = load(jpgfileName);
R(:,:,index) = rawData.data';
J(:,:,index) = jpgData.data';
index = index+1;
    catch
        disp('An error occurred loading mat file.');
        disp('Execution will continue with next file');
    end
end
