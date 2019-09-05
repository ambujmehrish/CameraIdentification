function im = denoiseImage(imx)
[~,~,p] = size(imx);
for i =1:p
%    im(:,:,i) = VSTpoisson(imx(:,:,i));
  [~, im(:,:,i)] = BM3D(1, imx(:,:,i),10);

end
