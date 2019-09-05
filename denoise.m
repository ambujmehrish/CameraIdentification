clear 
close all
imageDir = 'Database';
% sigma = [1];
nofCam = cameradatase;
% nofCam = dir(imageDir);
% nofCam = nofCam(:,2:end);
cd(imageDir)
for i = 1:size(nofCam,2)
    cd(nofCam(i).name)
    camfld = dir('EstimatedRAW/');
    camfld = camfld(3:end,:);
    disp(['Camera Folder = ' nofCam(i).name]) ;
    cd('EstimatedRAW')
  %  try
    for j = 1:size(camfld,1)
        imfl = dir(camfld(j).name);
        imfl = imfl(3:end,:);
        cd(camfld(j).name)
       for k = 1:size(imfl,1)
            imx = importdata(imfl(k).name);
           % imx = rgb2ycbcr(imx);
            disp(['Processing Image' num2str(k)]) ;
           % imshow(imx)
              if strcmp(nofCam(i).name,'Canon_EOS_40D') || strcmp(nofCam(i).name, 'Canon_PowerShot_S90') ||strcmp(nofCam(i).name ,'FUJIFILM_J10') ||strcmp(nofCam(i).name , 'Panasonic_DMC-LX3')
              filename = imfl(k).name;
              else
              filename = imfl(k).name;
              [~,filename,~] = fileparts(filename);
              end
           
              
%             for p =1:size(sigma,2)
              folderPath = strcat('/home/ambuj/PRNUEstimation/derender/Database/',nofCam(i).name,'/1/');
               fName = strcat(folderPath,filename,'_denoised');
%                  if~exist(fName)
                    y_est = denoiseImage(imx);
                    save(fName,'y_est')
                    clear 'y_est'
%                   end
        
                       
        end
        cd ..
    end
   % catch
        %disp('Error.. Process will continue with next file')
%     end
    cd ..
    cd ..
end