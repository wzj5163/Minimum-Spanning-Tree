
%% MST by Prim
clc,clear
a = zeros(7);
a(1,2)=3;a(1,3)=4;a(1,4)=7;
a(2,3)=3;a(2,4)=2;a(2,5)=4;
a(3,5)=5;a(3,6)=7;
a(4,5)=2;a(4,7)=6;
a(5,6)=1;a(5,7)=4;
a(6,7)=2;
% Prim
a=a+a';a(a==0)=inf;
result=[];p=1;tb=2:length(a);
while length(result)~=length(a)-1
    temp=a(p,tb);temp=temp(:);
    d=min(temp);
    [jb,kb]=find(a(p,tb)==d);
    j=p(jb(1));k=tb(kb(1));
    result=[result,[j;k;d]];
    p=[p,k];tb(tb==k)=[];
end
Wt=sum(result(3,:));
% plot tree
axis equal;
hold on
n=7;
[x,y]=cylinder(1,n);
xm=min(x(1,:));
ym=min(y(1,:));
xx=max(x(1,:));
yy=max(y(1,:));
axis([xm-abs(xm)*0.15,xx+abs(xx)*0.15,ym-abs(ym)*0.15,yy+abs(yy)*0.15]);
plot(x(1,:),y(1,:),'ko');
for i=1:n
    temp=['v',int2str(i)];
    text(x(1,i),y(1,i),temp);
end
for i=1:k-n+1
    plot(x(1,data(1:2,i)),y(1,data(1:2,i)),'b');
end
for i=1:n-1
    plot(x(1,result(1:2,i)),y(1,result(1:2,i)),'r');
end
%% MST of Kruskal: an 8-points example
% calculate MST
P=[-3, -2, -2, -2, 1, 1, 2, 4;0, 4, -1, -2, 4, 2, -4, -3]';
P = P([8, 7, 3, 1, 4, 2, 6, 5], :);
DM=pdist2(P,P);
DM2=DM.^2;
t=mst(DM);
%% plot
figure;
% for i = 1 : length(t)
%     plot([P(t(i,1),1),P(t(i,2),1)],[P(t(i,1),2),P(t(i,2),2)],'k-','LineWidth',2);
% end
scatter(P(:,1),P(:,2),800,'k','LineWidth',2,'MarkerFaceColor','auto');hold on
text(P(:,1)-0.07,P(:,2),char(num2str((1:8)')),'Color','r','FontSize',16)
box on
xlim([-4.5,4.5]);
ylim([-4.5,4.5]);
ylabel("brand loyalty","FontWeight","bold","FontSize",16);
xlabel("price conciousness","FontWeight","bold","FontSize",16);
set(gca, 'LineWidth', 1.6, 'FontSize', 16, 'FontWeight', 'Bold'...
    ,'XTick',-4:2:4,'YTick',-4:2:4);
saveas(gcf,'MST_8p','png')
% set(gcf,'Position',[500 500 500 500]);
%% plot 7 steps
for j=1:7
figure;
for i = 1 : j
    plot([P(t(i,1),1),P(t(i,2),1)],[P(t(i,1),2),P(t(i,2),2)],'k-','LineWidth',2);hold on
end
scatter(P(:,1),P(:,2),800,'k','LineWidth',2,'MarkerFaceColor','auto');
text(P(:,1)-0.07,P(:,2),char(num2str((1:8)')),'Color','r','FontSize',16)
box on
xlim([-4.5,4.5]);
ylim([-4.5,4.5]);
ylabel("brand loyalty","FontWeight","bold","FontSize",16);
xlabel("price conciousness","FontWeight","bold","FontSize",16);
set(gca, 'LineWidth', 1.6, 'FontSize', 16, 'FontWeight', 'Bold'...
    ,'XTick',-4:2:4,'YTick',-4:2:4);
saveas(gcf,['MST_8p_',num2str(j)],'png')
end

%% MST of Kruskal
clc,clear
rng default
P = rand([150,2]);
DT = delaunayTriangulation(P);
% triplot(DT)
% D = pdist(P);
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
saveas(gcf,'Kruskal1_0','png')

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
saveas(gcf,'Kruskal1_1','png')

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
saveas(gcf,'Kruskal1_2','png')

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
saveas(gcf,'Kruskal1_3','png')
%% MST of Prim
clc,clear
rng default
P = rand([150,2]);
DT = delaunayTriangulation(P);
D = pdist(P);
DM = pdist2(P,P);
G=graph(DM);

result=nan(length(DM)-1,3);p=1;tb=2:length(DM);
for i=1:length(DM)-1
    temp=DM(p,tb);temp=temp(:);
    d=min(temp);
    [Frow,Fcolume]=find(DM(p,tb)==d);
    j=p(Frow(1));k=tb(Fcolume(1));
    result(i,1)=p(Frow(1));
    result(i,2)=tb(Fcolume(1));
    result(i,3)=d;
    p=[p,k];tb(tb==k)=[];
end
T.Edges=table(result(:,1:2),result(:,3),'VariableNames',["EndNodes","Weight"]);

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
for i = 1:floor(length(T.Edges.Weight)*0.25)
    plot([P(T.Edges.EndNodes(i,1),1),P(T.Edges.EndNodes(i,2),1)]...
        ,[P(T.Edges.EndNodes(i,1),2),P(T.Edges.EndNodes(i,2),2)],'r',"LineWidth",2);
end
set(gca,'color','none','ytick',[],'yticklabel',[],'xtick',[],'xticklabel',[]);
saveas(gcf,'Prim1_0','png');

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
for i = 1:floor(length(T.Edges.Weight)*0.5)
    plot([P(T.Edges.EndNodes(i,1),1),P(T.Edges.EndNodes(i,2),1)]...
        ,[P(T.Edges.EndNodes(i,1),2),P(T.Edges.EndNodes(i,2),2)],'r',"LineWidth",2);
end
set(gca,'color','none','ytick',[],'yticklabel',[],'xtick',[],'xticklabel',[]);
saveas(gcf,'Prim1_1','png')

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
for i = 1:floor(length(T.Edges.Weight)*0.75)
    plot([P(T.Edges.EndNodes(i,1),1),P(T.Edges.EndNodes(i,2),1)]...
        ,[P(T.Edges.EndNodes(i,1),2),P(T.Edges.EndNodes(i,2),2)],'r',"LineWidth",2);
end
set(gca,'color','none','ytick',[],'yticklabel',[],'xtick',[],'xticklabel',[]);
saveas(gcf,'Prim1_2','png')

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
for i = 1:length(T.Edges.Weight)
    plot([P(T.Edges.EndNodes(i,1),1),P(T.Edges.EndNodes(i,2),1)]...
        ,[P(T.Edges.EndNodes(i,1),2),P(T.Edges.EndNodes(i,2),2)],'r',"LineWidth",2);
end
set(gca,'color','none','ytick',[],'yticklabel',[],'xtick',[],'xticklabel',[]);
saveas(gcf,'Prim1_3','png')
%% TiME SERIES by Kruskal
% treat every date as a node
% Every node only connects to closest node
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
saveas(gcf,'PriRet_SP','png')
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
saveas(gcf,'tsKruskal_0','png')

figure;
plot(P(:,1),P(:,2),'b');
dateaxis('x',12)
hold on
T1.Edges=sortrows(T.Edges,2);
for i = 1:floor(length(T1.Edges.Weight)*0.5)
    plot([P(T1.Edges.EndNodes(i,1),1),P(T1.Edges.EndNodes(i,2),1)]...
        ,[P(T1.Edges.EndNodes(i,1),2),P(T1.Edges.EndNodes(i,2),2)],'r');
end
set(gca,'color','none','ytick',[],'yticklabel',[],'xtick',[],'xticklabel',[]);
saveas(gcf,'tsKruskal_1','png')

figure;
plot(P(:,1),P(:,2),'b');
dateaxis('x',12)
hold on
T1.Edges=sortrows(T.Edges,2);
for i = 1:floor(length(T1.Edges.Weight)*0.75)
    plot([P(T1.Edges.EndNodes(i,1),1),P(T1.Edges.EndNodes(i,2),1)]...
        ,[P(T1.Edges.EndNodes(i,1),2),P(T1.Edges.EndNodes(i,2),2)],'r');
end
set(gca,'color','none','ytick',[],'yticklabel',[],'xtick',[],'xticklabel',[]);
saveas(gcf,'tsKruskal_2','png');

figure;
plot(P(:,1),P(:,2),'b');
dateaxis('x',12)
hold on
T1.Edges=sortrows(T.Edges,2);
for i = 1:floor(length(T1.Edges.Weight)*1)
    plot([P(T1.Edges.EndNodes(i,1),1),P(T1.Edges.EndNodes(i,2),1)]...
        ,[P(T1.Edges.EndNodes(i,1),2),P(T1.Edges.EndNodes(i,2),2)],'r');
end
set(gca,'color','none','ytick',[],'yticklabel',[],'xtick',[],'xticklabel',[]);
saveas(gcf,'tsKruskal_3','png')
%% plot returns clustered by MST with random colors
K=36;%K >= 2
rng default
NodesStart=[1;sort(T1.Edges.EndNodes(end-K+2:end,2))];
NodesEnd=[sort(T1.Edges.EndNodes(end-K+2:end,1));max(T1.Edges.EndNodes(:,2))];
figure;
for i=1:K
    plot(timeline(NodesStart(i):NodesEnd(i)),logret(NodesStart(i):NodesEnd(i))...
        ,"Color",[(i+1000)/(K+1000)*rand,(i+1000)/(K+1000)*rand,(i+1000)/(K+1000)*rand]);
    hold on
end
dateaxis('x',12);
%% Time Series by Hierarchical Clustering
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
%% plot default hierarchical clustering dendrogram
figure;[~,T]=dendrogram(Z,0);
%% 
% Z1=linkage(squareform(DM),'average');
% figure;dendrogram(Z1,0)
% max(logret)-min(logret)
% max(max(DM(DM<inf)))
% % In fact, hierarchical clustering with singleton generates a tree only
% % accoding to the proximity of two nearby nodes
%% set cluster number as 10
figure;[~,T]=dendrogram(Z,10);
set(gca,'color','none','ytick',[],'yticklabel',[],'xtick',[],'xticklabel',[]);
saveas(gcf,'HierarchicalExample','png');
%% use the default color threshold
figure;[H,T]=dendrogram(Z,0,"ColorThreshold","default");
saveas(gcf,'Hierarchical','png');
%% change the order of leaf nodes as descent
figure;[H,T]=dendrogram(Z,0,"ColorThreshold","default","Reorder",length(logret):-1:1);
%% try checkcrossing
figure;[H,T]=dendrogram(Z,1000,"ColorThreshold","default","CheckCrossing",true);
%% assign a unique color to each group of nodes whose linkage is less than 50% of the maximum linkage
figure;[H,T]=dendrogram(Z,0,"ColorThreshold",.5*max(Z(:,3)));
%% orientation downside
figure;[H,T]=dendrogram(Z,0,"ColorThreshold",.5*max(Z(:,3)),"Orientation",'bottom');
%% to see outperm of permutation of node labels
figure;[H,T,outperm]=dendrogram(Z,0,"ColorThreshold",.5*max(Z(:,3)),"Orientation",'bottom');
%% to see how to use Labels
figure;[H,T,outperm]=dendrogram(Z,0,"ColorThreshold",.5*max(Z(:,3)),"Orientation",'bottom',"Labels",[]);
%% to plot hierarchical clustering and original returns
figure;
subplot(2,1,1);
% [H,T,outperm]=dendrogram(Z,0,"ColorThreshold",.5*max(Z(:,3)));
[H,T,outperm]=dendrogram(Z,0,"ColorThreshold",Z(end-20+2,3),"Reorder",1:length(Z)+1);
set(gca,'xtick',[],'xticklabel',[]);
subplot(2,1,2);
plot(timeline,logret);
xlim([timeline(1),timeline(end)])
dateaxis('x',12)
saveas(gcf,'Hierarchical1','png')
%% Hierarchical clustering against MST with different colors
figure;
subplot(2,1,1);
% [H,T,outperm]=dendrogram(Z,0,"ColorThreshold",.5*max(Z(:,3)));
[H,T,outperm]=dendrogram(Z,0,"ColorThreshold",Z(end-KK+2,3),"Reorder",1:length(Z)+1);
set(gca,'xtick',[],'xticklabel',[]);
subplot(2,1,2);
K=24;%K >= 2
NodesStart=[1;sort(T1.Edges.EndNodes(end-K+2:end,2))];
NodesEnd=[sort(T1.Edges.EndNodes(end-K+2:end,1));max(T1.Edges.EndNodes(:,2))];
Cluster = [NodesStart NodesEnd];
for i=1:K
    plot(timeline(NodesStart(i):NodesEnd(i)),logret(NodesStart(i):NodesEnd(i)));
    hold on
end
xlim([timeline(1),timeline(end)]);
dateaxis('x',12);
saveas(gcf,'HierarchicalvsMST','png')
%% Hierarchical clustering against MST with same colors
KK=20;
rng default
figure;
subplot(2,1,1);
for K=2:KK
    Kset_HC= ones(K,1);
    [~,T,~]=dendrogram(Z,K);
    for k = 2:numel(Kset_HC)
        Kset_HC(k)=find(T==k,1);
    end
end
[H,T,outperm]=dendrogram(Z,0,"ColorThreshold",Z(end-KK+2,3),"Reorder",1:length(Z)+1);
set(gca,'xtick',[],'xticklabel',[]);

subplot(2,1,2);
Kset_MST=sort([1;T1.Edges.EndNodes(end-KK+2:end,2)]);
NodesStart=[1;sort(T1.Edges.EndNodes(end-KK+2:end,2))];
NodesEnd=[sort(T1.Edges.EndNodes(end-KK+2:end,1));max(T1.Edges.EndNodes(:,2))];
Cluster = [NodesStart NodesEnd];
cmap = hsv(KK);
cmap([1,2,3,4,18],:) = cmap([5,18,13,3,4],:);
plot(timeline(NodesStart(1):NodesEnd(1)),logret(NodesStart(1):NodesEnd(1))...
        ,"Color",cmap(1,:));hold on
for i=2:KK
    plot(timeline(NodesEnd(i-1):NodesEnd(i)),logret(NodesEnd(i-1):NodesEnd(i))...
        ,"Color",cmap(i,:));
    hold on
end
xlim([timeline(1),timeline(end)]);
dateaxis('x',12);
saveas(gcf,'HierarchicalvsMST_0','png')
%% change color of MST (exercise)
KK=25;
rng default
figure;
subplot(2,1,1);
for K=2:KK
    Kset_HC= ones(K,1);
    [~,T,~]=dendrogram(Z,K);
    for k = 2:numel(Kset_HC)
        Kset_HC(k)=find(T==k,1);
    end
end
[H,T,outperm]=dendrogram(Z,0,"ColorThreshold",Z(end-KK+2,3),"Reorder",1:length(Z)+1);

subplot(2,1,2);
Kset_MST=sort([1;T1.Edges.EndNodes(end-KK+2:end,2)]);
NodesStart=[1;sort(T1.Edges.EndNodes(end-KK+2:end,2))];
NodesEnd=[sort(T1.Edges.EndNodes(end-KK+2:end,1));max(T1.Edges.EndNodes(:,2))];
Cluster = [NodesStart NodesEnd];
cmap = hsv(KK);
c = linspace(1,10,KK);
for i=1:KK
    plot(timeline(NodesStart(i):NodesEnd(i)),logret(NodesStart(i):NodesEnd(i))...
        ,"Color",cmap(i,:));
    hold on
end
xlim([timeline(1),timeline(end)]);
dateaxis('x',12);
%% exercise of dendrogram
dendrogram_copy(Z,0,"ColorThreshold",Z(end-KK+2,3),"Reorder",1:length(Z)+1);
%% Time Series Clustering 
clc,clear
load("sp500.mat");
logret=sample(:,4);
timeline=datenum(sample(:,1:3));
ts_length=5;
logret_ts=zeros(length(logret)-ts_length+1,ts_length);
for i=1:length(logret_ts)
    logret_ts(i,:)=logret(i:i+ts_length-1)';
end
CorrM=corr(logret_ts',logret_ts');
for i=1:length(CorrM)
    for j=i:length(CorrM)
        CorrM(i,j)=CorrM(j,i);
    end
end
DM1=1./abs(CorrM)-1;
DM2=1-abs(CorrM);
G1=graph(DM1);
T1=minspantree(G1,'Method','sparse');
G2=graph(DM2);
T2=minspantree(G2,'Method','sparse');
Z1=linkage(DM1);
figure;
dendrogram(Z1)
figure;
Z2=linkage(DM2);
dendrogram(Z2)
dendrogram(Z2,0)
