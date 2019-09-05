function imF = HPgaussian(im,k,sigma)
n = (k-1)/2;
h = padarray(1,[n n])- fspecial('gaussian',k,sigma);
imF = imfilter(im,h,'replicate');
end