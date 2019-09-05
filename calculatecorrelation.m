function  [roh_interclass,roh_intraclass] = calculatecorrelation(K,N,class,flag)
[~,~,~,p] = size(K);
[~,~,~,q] = size(N);
for i = 1:p
    if flag.channel == 0
    k = 0.3*K(:,:,1,i)+0.6*K(:,:,2,i)+0.1*K(:,:,3,i);
    k = LPgaussian(k,3,0.5);
%       figure
%       plotfft(k)
%     k = wiener2(k,[3 3],std2(k));
         if flag.testMethod == 0
    k = reshape(k,size(k,1)*size(k,2),1);
         end
    elseif flag.channel == 1
        k = K(:,:,1,i);
         if flag.testMethod == 0
        k = reshape(k,size(k,1)*size(k,2),1);
         end
    elseif flag.channel == 2
        k = K(:,:,2,i);
        if flag.testMethod == 0
        k = reshape(k,size(k,1)*size(k,2),1);
         end
    elseif flag.channel == 3
        k = K(:,:,3,i);
         if flag.testMethod == 0
        k = reshape(k,size(k,1)*size(k,2),1);
         end
    end
    for j = 1:q
         if flag.channel == 0
            n = N(:,:,j);
%             n = wiener2(n,[3 3],std2(n));
               if flag.testMethod == 0
            n = reshape(n,size(n,1)*size(n,2),1);
               end
        elseif flag.channel == 1
            n = N(:,:,1,j);
             if flag.testMethod == 0
            n = reshape(n,size(n,1)*size(n,2),1);
             end
        elseif flag.channel == 2
            n = N(:,:,2,j);
             if flag.testMethod == 0
            n = reshape(n,size(n,1)*size(n,2),1);
             end
        elseif flag.channel == 3
            n = N(:,:,3,j);
            if flag.testMethod == 0
            n = reshape(n,size(n,1)*size(n,2),1);
            end
        end

         if flag.testMethod ==0
        roh(j,i) = corr2(k,n);
         else
        C = crosscorr(n,k);
        detection = PCE(C) ;
        roh(j,i) = detection.PCE;
         end
    end
end
roh_interclass = roh(:,class);
index = setdiff(1:p,class);
roh_intraclass = roh(:,index);
roh_intraclass = reshape(roh_intraclass,size(roh_intraclass,1)*size(roh_intraclass,2),1);
end