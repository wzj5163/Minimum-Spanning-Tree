%% SP500 by Hierarchical Clustering
% to produce dendrogram
% treat every date as a node
clc,clear
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
%% generate hierarchical clustering
Z=linkage(squareform(DM));% default is singleton
%% to plot hierarchical clustering and original returns
figure;
subplot(2,1,1);
[H,T,outperm]=dendrogram(Z,0,"ColorThreshold",Z(end-20+2,3),"Reorder",1:length(Z)+1);
set(gca,'xtick',[],'xticklabel',[]);
subplot(2,1,2);
plot(timeline,logret);
xlim([timeline(1),timeline(end)])
dateaxis('x',12)
saveas(gcf,'Hierarchical_sp500','png')