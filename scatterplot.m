function scatterplot(inter_roh,intra_roh,cameraName)
for i = 1:size(cameraName,2)
    interclassroh = inter_roh((i-1)*150+1:150*i,1);
    intraclassroh = intra_roh((i-1)*1350+1:1350*i,1);
    figure
   
    n=randperm(1350,150);
    intraclassroh = intraclassroh(n);
    scatter(1:150,interclassroh,'b')
    hold on
    scatter(1:150,intraclassroh,'r')
    title(cameraName(i).name)
end
end