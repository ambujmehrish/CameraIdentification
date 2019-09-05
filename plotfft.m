function plotfft(I)
F = fft2(I); 
F = fftshift(F); % Center FFT
F = abs(F); % Get the magnitude
F = log(F+1); % Use log, for perceptual scaling, and +1 since log(0) is undefined
F = mat2gray(F); % Use mat2gray to scale the image between 0 and 1
imshow(F,[]); % Display the result
%  mesh(F)
end