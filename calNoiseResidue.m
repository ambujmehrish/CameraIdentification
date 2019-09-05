function  N = calNoiseResidue(imageFiles,d_imageFiles,testingSet,patchSize,flag)
imageFiles = imageFiles(testingSet);
d_imageFiles = d_imageFiles(testingSet);
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
        imshow(Img)
        D_Img = imcrop(d_img,rect);
        imshow(D_Img)
        end
        
            if flag.channel == 0
            N(:,:,1,i) = rgb2gray(Img)-rgb2gray(D_Img);
            N(:,:,1,i) = WienerInDFT(N(:,:,1,i),std2(N(:,:,1,i)));
            else
             for j = 1:p
             N(:,:,j,i) = Img(:,:,j)-D_Img(:,:,j);
          N(:,:,j,i) = WienerInDFT(N(:,:,j,i),std2(N(:,:,j,i)));
             end
            end
                        
       
end
end