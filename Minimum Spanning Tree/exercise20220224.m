
load("sp500.mat");
logret=sample(:,4);
timeline=datenum(sample(:,1:3));
DM=pdist2(logret,logret);
for i=1:length(DM)-2
    for j=i+2:length(DM)
        DM(i,j)=inf;
    end
end
for j=1:length(DM)-2
    for i=j+2:length(DM)
        DM(i,j)=inf;
    end
end
Z=linkage(squareform(DM));
KK=25;
dendrogram_copy(Z,0,"ColorThreshold",Z(end-KK+2,3),"Reorder",1:length(Z)+1);