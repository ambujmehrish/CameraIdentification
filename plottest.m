clear
close all
load('K.mat')
sigma = 1;
for i =1:10
k = 0.3*K(:,:,1,i)+0.6*K(:,:,2,i)+0.1*K(:,:,3,i);
k = LPgaussian(k,5,sigma);
% k = K(:,:,2,i);
figure
plotfft(k) 
end