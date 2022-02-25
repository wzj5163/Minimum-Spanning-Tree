%% MST of Kruskal
clc,clear
rng default
P = rand([150,2]);
DT = delaunayTriangulation(P);
DM = pdist2(P,P);
G=graph(DM);
T=minspantree(G,'Method','sparse');
figure;
for i = 1:size(DT.ConnectivityList,1)
    for i1=1:size(DT.ConnectivityList,2)-1
        for i2=i1+1:size(DT.ConnectivityList,2)
            plot([P(DT.ConnectivityList(i,i1),1),P(DT.ConnectivityList(i,i2),1)]...
                ,[P(DT.ConnectivityList(i,i1),2),P(DT.ConnectivityList(i,i2),2)],'LineWidth',1,'Color',[.86 .86 .86]);
            hold on
        end
    end
end
plot(P(:,1),P(:,2),'bo');
T1.Edges=sortrows(T.Edges,2);
for i = 1:floor(length(T1.Edges.Weight)*0.25)
    plot([P(T1.Edges.EndNodes(i,1),1),P(T1.Edges.EndNodes(i,2),1)]...
        ,[P(T1.Edges.EndNodes(i,1),2),P(T1.Edges.EndNodes(i,2),2)],'r',"LineWidth",2);
end
set(gca,'color','none','ytick',[],'yticklabel',[],'xtick',[],'xticklabel',[]);
saveas(gcf,'Kruskal_0','png')

figure;
for i = 1:size(DT.ConnectivityList,1)
    for i1=1:size(DT.ConnectivityList,2)-1
        for i2=i1+1:size(DT.ConnectivityList,2)
            plot([P(DT.ConnectivityList(i,i1),1),P(DT.ConnectivityList(i,i2),1)]...
                ,[P(DT.ConnectivityList(i,i1),2),P(DT.ConnectivityList(i,i2),2)],'LineWidth',1,'Color',[.86 .86 .86]);
            hold on
        end
    end
end
plot(P(:,1),P(:,2),'bo');
T1.Edges=sortrows(T.Edges,2);
for i = 1:floor(length(T1.Edges.Weight)*0.5)
    plot([P(T1.Edges.EndNodes(i,1),1),P(T1.Edges.EndNodes(i,2),1)]...
        ,[P(T1.Edges.EndNodes(i,1),2),P(T1.Edges.EndNodes(i,2),2)],'r',"LineWidth",2);
end
set(gca,'color','none','ytick',[],'yticklabel',[],'xtick',[],'xticklabel',[]);
saveas(gcf,'Kruskal_1','png')

figure;
for i = 1:size(DT.ConnectivityList,1)
    for i1=1:size(DT.ConnectivityList,2)-1
        for i2=i1+1:size(DT.ConnectivityList,2)
            plot([P(DT.ConnectivityList(i,i1),1),P(DT.ConnectivityList(i,i2),1)]...
                ,[P(DT.ConnectivityList(i,i1),2),P(DT.ConnectivityList(i,i2),2)],'LineWidth',1,'Color',[.86 .86 .86]);
            hold on
        end
    end
end
plot(P(:,1),P(:,2),'bo');
T1.Edges=sortrows(T.Edges,2);
for i = 1:floor(length(T1.Edges.Weight)*0.75)
    plot([P(T1.Edges.EndNodes(i,1),1),P(T1.Edges.EndNodes(i,2),1)]...
        ,[P(T1.Edges.EndNodes(i,1),2),P(T1.Edges.EndNodes(i,2),2)],'r',"LineWidth",2);
end
set(gca,'color','none','ytick',[],'yticklabel',[],'xtick',[],'xticklabel',[]);
saveas(gcf,'Kruskal_2','png')

figure;
for i = 1:size(DT.ConnectivityList,1)
    for i1=1:size(DT.ConnectivityList,2)-1
        for i2=i1+1:size(DT.ConnectivityList,2)
            plot([P(DT.ConnectivityList(i,i1),1),P(DT.ConnectivityList(i,i2),1)]...
                ,[P(DT.ConnectivityList(i,i1),2),P(DT.ConnectivityList(i,i2),2)],'LineWidth',1,'Color',[.86 .86 .86]);
            hold on
        end
    end
end
plot(P(:,1),P(:,2),'bo');
T1.Edges=sortrows(T.Edges,2);
for i = 1:floor(length(T1.Edges.Weight)*1)
    plot([P(T1.Edges.EndNodes(i,1),1),P(T1.Edges.EndNodes(i,2),1)]...
        ,[P(T1.Edges.EndNodes(i,1),2),P(T1.Edges.EndNodes(i,2),2)],'r',"LineWidth",2);
end
set(gca,'color','none','ytick',[],'yticklabel',[],'xtick',[],'xticklabel',[]);
saveas(gcf,'Kruskal_3','png')
