function [K_hat,K_dash] = ZM(K)
sum_c = sum(K,1);
sum_r = sum(K,2);
avgr = sum_c/size(K,1);
avgc = sum_r/size(K,2);
I = ones(size(K));
R = I.*avgr;
C = I.*avgc;
K_hat = K-C;
K_hat = K_hat-R;

K_dash = K-K_hat;
end