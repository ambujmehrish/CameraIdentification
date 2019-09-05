function rawImage = jpgtoRaw( jpgImage,cModel,M,N )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
l=1;
  for i=1:M
     for j=1:N
          for k=1:3
             J(k,l)=jpgImage(i,j,k);
          end
         l=l+1;

     end
  end
 J=double(J);
[mu,cv] = invJ(J,strcat('traindata/',cModel));
l=1;
  for i=1:M
     for j=1:N
          for k=1:3
             rawImage(i,j,k)=mu(k,l);
          end
         l=l+1;

     end
  end
end

