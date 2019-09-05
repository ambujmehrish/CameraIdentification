clear 
close all
imageDir = 'ImageDatabase';
nofCam = dir(imageDir);
nofCam = nofCam(3:end,:);
cd(imageDir)
for i = 1:size(nofCam,1)
    cd(nofCam(i).name)
    camfld = dir('EstimatedRAW/');
    camfld = camfld(3:end,:);
    disp(['Camera Folder = ' nofCam(i).name]) ;
    cd('EstimatedRAW')
    denoisedImageFolder = strcat(nofCam(i).name,'/denoised/1/');
    denoisedImages = dir(denoisedImageFolder);
    denoisedImages = denoisedImages(3:end,:);
    inx = randperm(size(denoisedImages,1),50);
    cd(denoisedImageFolder)
    trainInx(:,i) = inx';
    for j = 1:size(trainInx,1)
         img = importdata(denoisedImages(denoisedImages(trainInx(j,i)).name));
         img = reshape(size(img,1)*size(img,2),1);
         Y_hat(:,j,i) = img;
    end
    cd ..
    cd ..
    cd ..
end