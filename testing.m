%ImageDatabase folder consists images for different camera
% Images should be placed in respective camera folder
% This code selects 200 images randomly from each camera folder and divide
% them in training and testing set. 50 images are used for training and 150
% images for testing

clear 
close all

%  ImageDir = 'MobileImageDatabase/'; 
 ImageDir = 'Database/';
 patchSize = 512;
 flag.channel = 0; % 0 -- gray 1 --- R ,2 ---- G , 3 ---- B
 flag.perProcessingON = 1; % 0 - disabled 1 -- enabled
 flag.testMethod = 1; % 0--- correlation 1 = PCE
% ImageDir = 'ImageDatabase/'; % Image Direcotry path
camDir = cameradatase;
denoisedfld = dcamfolder;
% camDir = dir(ImageDir);
% camDir = camDir(3:end,1);
numofCam = size(camDir,2); % Number of cameras in Experiment(Number of floder in ImageDatabase)
trainImagesPerCam = 50;
testImagesPerCam = 150;
 nTrainImages = numofCam*trainImagesPerCam;
 nTestImages = numofCam*testImagesPerCam;
cd(ImageDir)
 % Read Images from each camera folder and Seperates 50 images for training
 % and 150 images for testing.
 
for i =1:numofCam
    disp(['Camera Folder = ' camDir(i).name]) ;
    imageFiles = dir([camDir(i).name,'/EstimatedRAW/',camDir(i).name,'/']);
    d_imageFiles = dir([camDir(i).name,'/',denoisedfld(i).name,'/']);
    imageFiles = imageFiles(3:end,1);
    d_imageFiles = d_imageFiles(3:end,1);
    imageSet = randperm(size(imageFiles,1),200); % Selecting 200 images randomly
    trainingSet = randperm(size(imageSet,2),trainImagesPerCam); % randomly selecting Training Images
    testingSet(:,:,i) = setdiff(1:200,trainingSet);% Testing Image set
    if strcmp(camDir(i).name,'Canon_EOS_40D') || strcmp(camDir(i).name, 'Canon_PowerShot_S90') ||strcmp(camDir(i).name ,'FUJIFILM_J10') ||strcmp(camDir(i).name , 'Panasonic_DMC-LX3')
    flag.cam = 1;
        K(:,:,:,i) = calPRNU(imageFiles,d_imageFiles,trainingSet,patchSize,flag);
        
         
    else
        flag.cam = 2;
        K(:,:,:,i) = calPRNU(imageFiles,d_imageFiles,trainingSet,patchSize,flag);
    end
           
end
for i =1:numofCam
    disp(['Camera Folder = ' camDir(i).name]) ;
    imageFiles = dir([camDir(i).name,'/EstimatedRAW/',camDir(i).name,'/']);
    imageFiles = imageFiles(3:end,:);
    d_imageFiles = dir([camDir(i).name,'/',denoisedfld(i).name,'/']);
    d_imageFiles = d_imageFiles(3:end,:);
    if strcmp(camDir(i).name,'Canon_EOS_40D') || strcmp(camDir(i).name, 'Canon_PowerShot_S90') ||strcmp(camDir(i).name ,'FUJIFILM_J10') ||strcmp(camDir(i).name , 'Panasonic_DMC-LX3')
       flag.cam = 1;
        N = calNoiseResidue(imageFiles,d_imageFiles,testingSet(:,:,i),patchSize,flag);
    else
         flag.cam = 2;
        N = calNoiseResidue(imageFiles,d_imageFiles,testingSet(:,:,i),patchSize,flag);
    end
  [roh_interclass,roh_intraclass] = calculatecorrelation(K,N,i,flag) ;
  Acc(i,1) = Accuracy(roh_interclass,roh_intraclass)

  if i == 1
      inter_roh = roh_interclass;
      intra_roh = roh_intraclass;

  else
       inter_roh = [inter_roh;roh_interclass];
       intra_roh = [intra_roh;roh_intraclass];

  end
 clear roh_interclass roh_intraclass
  
end
scatterplot(inter_roh,intra_roh,camDir)

