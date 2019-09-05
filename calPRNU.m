function Fingerprint = calPRNU(imageFiles,d_imageFiles,trainingSet,patchSize,flag)
S(1:patchSize,1:patchSize,1:3) = 0;
D_S(1:patchSize,1:patchSize,1:3) = 0;
imageFiles = imageFiles(trainingSet);
d_imageFiles = d_imageFiles(trainingSet);
for i=1:size(imageFiles,1)
        disp(['Processing Image' num2str(i)]) ;
        if flag.cam == 1
            imF = strcat(imageFiles(i).folder,'/',imageFiles(i).name);
            dimF =  strcat(d_imageFiles(i).folder,'/',d_imageFiles(i).name);
        img = importdata(imF);
        
        d_img = importdata(dimF);
        
        else
            imF = strcat(imageFiles(i).folder,'/',imageFiles(i).name);
            dimF =  strcat(d_imageFiles(i).folder,'/',d_imageFiles(i).name);
        img = load(imF);
        d_img = load(dimF);
        img = img.rawImage;
              
        d_img = d_img.y_est;
        
        end
        [m,n,p] = size(img);
        if patchSize == 512
            %do nothing
            Img = img;
            D_Img = d_img;
        else
        rect = [n/2-(patchSize/2),m/2-(patchSize/2),patchSize-1,patchSize-1];% for Patch size 512x512
        Img = imcrop(img,rect);
        D_Img = imcrop(d_img,rect);
        end
        for j = 1:p
            S(:,:,j) = S(:,:,j)+Img(:,:,j);
            D_S(:,:,j) = D_S(:,:,j)+D_Img(:,:,j);
            
        end
end
K = S./D_S;
if flag.perProcessingON == 1
% [Fingerprint,~]=ZeroMean(K,'both'); 
for j =1:3
[Fingerprint(:,:,j),~]=ZM(K(:,:,j));
end
else
 Fingerprint = K;
  
end

end