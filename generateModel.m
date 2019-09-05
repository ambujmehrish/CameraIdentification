clear
close all
init
compileFF
compilePI
camdataFolder = 'camdata/';
camdata = dir(camdataFolder);
camdata = camdata(3:end,:);
%parpool('local',4)
for i = 1:size(camdata,1)
    try
   c = load(camdata(i).name);
   R = c.R;
   J = uint8(c.J);
  % [raw,jpg] = selSubset(c,0,[1:max(c.iTag)]);
  raw = reshape(R,3,size(R,2)*size(R,3));
  jpg = reshape(J,3,size(J,2)*size(J,3));
  
   [~,camName,~] = fileparts(camdata(i).name); 
   modelName = strcat('traindata/',camName);
   CameraFit(raw,double(jpg),modelName);
   InvertBase(modelName);
   InvertBaseQ(modelName);
   clear raw jpg c 
    catch
        disp('Error...')
    end
end
%delete(gcp('nocreate'))
  