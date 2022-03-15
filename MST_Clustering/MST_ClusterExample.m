% %% MST clustering
% clc,clear
% ax=gca;
% ax.DataAspectRatio=[1 1 1];
% ax.XLim=[0 1];
% ax.YLim=[0 1];
% ax.XColor='none';
% ax.YColor='none';
% hold(ax,'on')
% DelayTime=.5;
% 
% % =========================================================================
% 
% rng default
% r=1/(2+2*cos(pi/12));
% p=1-r-2*r*sin(pi/12);
% P1 = rand([10,2]).*[r*3/4 2*pi];P1 = [cos(P1(:,2)) sin(P1(:,2))].*P1(:,1)+[r p];
% P2 = rand([20,2]).*[r*3/4 2*pi];P2 = [cos(P2(:,2)) sin(P2(:,2))].*P2(:,1)+[p r];
% P3 = rand([30,2]).*[r*3/4 2*pi];P3 = [cos(P3(:,2)) sin(P3(:,2))].*P3(:,1)+[1-r 1-r];
% scatter(P1(:,1),P1(:,2),100,'k','LineWidth',2,'MarkerFaceColor','auto');
% scatter(P2(:,1),P2(:,2),100,'k','LineWidth',2,'MarkerFaceColor','auto');
% scatter(P3(:,1),P3(:,2),100,'k','LineWidth',2,'MarkerFaceColor','auto');
% P=[P1;P2;P3];
% DM = pdist2(P,P);
% G=graph(DM);
% T=minspantree(G,'Method','sparse');
% 
% % figure
% pause(.5)
% F=getframe(ax);
% [imind,cm]=rgb2ind(F.cdata,256);
% imwrite(imind,cm,'Kruskal_Clustering.gif','gif','Loopcount',inf,'DelayTime',DelayTime);
% 
% T1.Edges=sortrows(T.Edges,2);
% 
% for j = 0.02:0.04:0.08
%     for i = 1:floor(length(T1.Edges.Weight)*j)
%         plot([P(T1.Edges.EndNodes(i,1),1),P(T1.Edges.EndNodes(i,2),1)]...
%             ,[P(T1.Edges.EndNodes(i,1),2),P(T1.Edges.EndNodes(i,2),2)],'r',"LineWidth",3);
%     end
%     pause(.5);saveFrame(ax,DelayTime)
% end
% for j = 0.1:0.1:0.9
%     for i = 1:floor(length(T1.Edges.Weight)*j)
%         plot([P(T1.Edges.EndNodes(i,1),1),P(T1.Edges.EndNodes(i,2),1)]...
%             ,[P(T1.Edges.EndNodes(i,1),2),P(T1.Edges.EndNodes(i,2),2)],'r',"LineWidth",3);
%     end
%     pause(.5);saveFrame(ax,DelayTime)
% end
% for j = 0.92:0.02:0.98
%     for i = 1:floor(length(T1.Edges.Weight)*j)
%         plot([P(T1.Edges.EndNodes(i,1),1),P(T1.Edges.EndNodes(i,2),1)]...
%             ,[P(T1.Edges.EndNodes(i,1),2),P(T1.Edges.EndNodes(i,2),2)],'r',"LineWidth",3);
%     end
%     pause(.5);saveFrame(ax,DelayTime)
% end
% 
% [X,Y]=getEllipse([r,p],[1,0;0,0.7],r^2,200);
% plot(X,Y,'Color',[250,250,0]./255,'LineWidth',1.8);
% [X,Y]=getEllipse([p,r],[0.8,0;0,0.7],r^2,200);
% plot(X,Y,'Color',[0,250,0]./255,'LineWidth',1.8);
% [X,Y]=getEllipse([1-r,1-r],[0.7,0;0,0.8],r^2,200);
% plot(X,Y,'Color',[0,0,250]./255,'LineWidth',1.8);
% pause(.5);saveFrame(ax,DelayTime)
% 
% %% 椭圆数据计算函数，输入协方差矩阵、中心点、半径生成椭圆数据
%     function [X,Y]=getEllipse(Mu,Sigma,S,pntNum)
%         % (X-Mu)*inv(Sigma)*(X-Mu)=S
%         invSig=inv(Sigma);
%         
%         [V,D]=eig(invSig);
%         aa=sqrt(S/D(1));
%         bb=sqrt(S/D(4));
%         
%         t=linspace(0,2*pi,pntNum);
%         XY=V*[aa*cos(t);bb*sin(t)];
%         X=(XY(1,:)+Mu(1))';
%         Y=(XY(2,:)+Mu(2))';
%     end
% 
% 
% %% save gif 
% function saveFrame(ax,DelayTime)
% F=getframe(ax);
% [imind,cm]=rgb2ind(F.cdata,256);
% imwrite(imind,cm,'kruskal_Clustering.gif','gif','WriteMode','append','DelayTime',DelayTime);
% end
