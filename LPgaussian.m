function imF = LPgaussian(im,k,sigma)
h = fspecial('gaussian',k,sigma);
imF = imfilter(im,h,'replicate');
end