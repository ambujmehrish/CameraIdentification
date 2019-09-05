clear 
close all
imageFolder = 'Database/';
imageD = dir(imageFolder);
imageD = imageD(3:end,:);
for i = 1:size(imageD,1)
    if isequal(imageD(i).name,'FujifilmXM1')
      images = dir([strcat(imageFolder,imageD(i).name,'/','JPG/'),'*.jpg']);
      images = images(1:end,:);
    else
      images = dir([strcat(imageFolder,imageD(i).name,'/','JPG/'),'*.JPG']);
      images = images(1:end,:);
    end
   for j =1:size(images,1)
       imx = imread(images(j).name);
       [~,fileName,~] = fileparts(images(j).name);
%        [m,n,~] = size(imx);
%        rect = [m/2-256,n/2-256,511,511];
%        imx = imcrop(imx,rect);
        imx = imcropmiddle(imx,[512 512],'NW');
       [m,n,~] = size(imx);
       rawImage = jpgtoRaw( imx,imageD(i).name,m,n );
    folderName = strcat(imageFolder,imageD(i).name,'/','EstimatedRAW/',imageD(i).name,'/',fileName);
       save(folderName,'rawImage')
       clear rawImage
        
   end
 end