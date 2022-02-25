%% TiME SERIES by Kruskal
clc,clear
load("sp500.mat");
logret=sample(:,4);
price=sample(:,5);
timeline=datenum(sample(:,1:3));
%% plot data set
figure;
subplot(2,1,1);
plot(timeline,price);
dateaxis('x',12);
xlim([timeline(1),timeline(end)]);
set(gca,'color','none','ytick',[],'yticklabel',[]);
subplot(2,1,2);
plot(timeline,logret);
dateaxis('x',12);
xlim([timeline(1),timeline(end)]);
set(gca,'color','none','ytick',[],'yticklabel',[]);
saveas(gcf,'PriRet_SP','png');
%% generate minimal spanning tree
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
G=graph(DM);
T=minspantree(G,'Method','sparse');
P=[timeline,logret];
%% plot 4 steps of time series by kuskal algorithm from 25% to 100%
figure;
plot(P(:,1),P(:,2),'b');
dateaxis('x',12);
hold on
T1.Edges=sortrows(T.Edges,2);
for i = 1:floor(length(T1.Edges.Weight)*0.25)
    plot([P(T1.Edges.EndNodes(i,1),1),P(T1.Edges.EndNodes(i,2),1)]...
        ,[P(T1.Edges.EndNodes(i,1),2),P(T1.Edges.EndNodes(i,2),2)],'r');
end
set(gca,'color','none','ytick',[],'yticklabel',[],'xtick',[],'xticklabel',[]);
saveas(gcf,'SP_Kruskal_0','png')

figure;
plot(P(:,1),P(:,2),'b');
dateaxis('x',12);
hold on
T1.Edges=sortrows(T.Edges,2);
for i = 1:floor(length(T1.Edges.Weight)*0.5)
    plot([P(T1.Edges.EndNodes(i,1),1),P(T1.Edges.EndNodes(i,2),1)]...
        ,[P(T1.Edges.EndNodes(i,1),2),P(T1.Edges.EndNodes(i,2),2)],'r');
end
set(gca,'color','none','ytick',[],'yticklabel',[],'xtick',[],'xticklabel',[]);
saveas(gcf,'SP_Kruskal_1','png')

figure;
plot(P(:,1),P(:,2),'b');
dateaxis('x',12);
hold on
T1.Edges=sortrows(T.Edges,2);
for i = 1:floor(length(T1.Edges.Weight)*0.75)
    plot([P(T1.Edges.EndNodes(i,1),1),P(T1.Edges.EndNodes(i,2),1)]...
        ,[P(T1.Edges.EndNodes(i,1),2),P(T1.Edges.EndNodes(i,2),2)],'r');
end
set(gca,'color','none','ytick',[],'yticklabel',[],'xtick',[],'xticklabel',[]);
saveas(gcf,'SP_Kruskal_2','png');

figure;
plot(P(:,1),P(:,2),'b');
dateaxis('x',12);
hold on
T1.Edges=sortrows(T.Edges,2);
for i = 1:floor(length(T1.Edges.Weight)*1)
    plot([P(T1.Edges.EndNodes(i,1),1),P(T1.Edges.EndNodes(i,2),1)]...
        ,[P(T1.Edges.EndNodes(i,1),2),P(T1.Edges.EndNodes(i,2),2)],'r');
end
set(gca,'color','none','ytick',[],'yticklabel',[],'xtick',[],'xticklabel',[]);
saveas(gcf,'SP_Kruskal_3','png')
