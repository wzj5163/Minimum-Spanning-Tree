rm(list = ls())

library(PerformanceAnalytics)
library(xts)
library(quantmod)
library(timeSeries)
library(xtable)
library(igraph)
library(tcltk2)
library(MTS)
library(matrixcalc)
library(Matrix)
library(fPortfolio)
library(IntroCompFinR)  #install.packages("IntroCompFinR", repos="http://R-Forge.R-project.org")
require(quadprog)
library(pracma)
library(glasso)

setwd("~/Documents/METIS/Minimum Spanning Tree/Codes/MSTCC_CovMtx")
prices<-read.table("def.csv", header=TRUE, sep=",", dec=".")
ZOO <- zoo(prices[,-1], order.by=as.Date(as.character(prices$Date), format='%m/%d/%Y'))

#return
return<- Return.calculate(ZOO, method="log")
return<- return[-1, ]
returnstd<-xts(return)
class(return)
dim(return)

W<-list()
for(t in 0: 92){
  W[[(t+1)]]=returnstd[(1+t*7):(120+t*7),]
}

W_in<-list()
W_out<-list()

for(t in 1: 93){
  W_in[[(t)]]=W[[t]][c(1:113),]
  W_out[[(t)]]=W[[t]][c(114:120),]
}

# RMT: get lambda_max

M<-matrix(rnorm(10*113, mean=0,sd=1),10,113)
E<-t(M)
O<-M%*%E
L<-1/113
R<-L*O
eigen(R, symmetric = TRUE)
eigen_R<-eigen(R, symmetric = TRUE)$values
Q<-113/10

lambda_max<-(1+1/Q+2*sqrt(1/Q))   ##taking into account the behaviour of the first eigenvalue
lambda_max
lambda_min<-(1+1/Q-2*sqrt(1/Q))
lambda_min

# Get filtered eigenvalue and eigenvector
C <- list()        # correlation matrix
lambda_C<-list()   # eigenvalue and eigenvector of correlation matrix
eigen_C<-list()    # eigenvalue of correlation matrix
eigenvec_C<-list() # eigenvector of correlation matrix

for(t in 1: length(W_in)){
  #Wt[[(t)]]=returnstd[(t):(tw+t),]
  C[[(t)]] =cor(W_in[[(t)]])
  lambda_C[[t]]<-eigen(C[[t]], symmetric = TRUE)
  eigen_C[[t]]<-lambda_C[[t]]$values
  eigenvec_C[[t]]<-lambda_C[[t]]$vectors
}

# sort "eigen_C" by ascent
for(i in 1:10){
  for (t in 1:93) {
    if(eigen_C[[t]][i]<lambda_max){eigen_C[[t]][i]=0}
    eigen_C[[t]]<-sort(eigen_C[[t]])  # I think we do NOT need to sort
  }
}

filtered_diagonal_C<-list()  # filtered diagnal matrix of eigenvalue
V<-list()                    # eigenvector from 10 to 1
f<-list()                    # transport of V
C_1<-list()                  # filtered correlation matrix
Dist <- list()               # distance matrix

for(t in 1: length(W_in)){
  filtered_diagonal_C[[t]]<-diag(eigen_C[[t]])
  V[[t]]<-eigenvec_C[[t]]
  V[[t]]<-eigenvec_C[[t]][,10:1]  # I think we do NOT need to sort from 10 to 1
  f[[t]]<-t(V[[t]])
  C_1[[t]]<-V[[t]]%*%filtered_diagonal_C[[t]]%*%f[[t]]
  diag(C_1[[t]])<-1               # I think we do NOT need to sign 1 to diagonal 
  C_1[[t]]<-as.matrix(C_1[[t]])
  diag(C_1[[t]])<-1
  Dist[[t]]<-sqrt(2-2*C_1[[t]])
  Dist[[t]]<-as.matrix(Dist[[t]])
  Dist[[t]][is.nan(Dist[[t]])]<-0              # why nan? I think it may be set as inf
  colnames(Dist[[(t)]])<-colnames(returnstd)
  rownames(Dist[[(t)]])<-colnames(returnstd)
}
# what's the difference between Dist and ciao? I think it is the SAME
ciao<-list()
for(t in 1: length(W)){
  ciao[[t]]<-as.numeric(unlist(Dist[[t]]))
  ciao[[t]]<-matrix(ciao[[t]],10,10)
  colnames(ciao[[t]])<-colnames(returnstd)
  rownames(ciao[[t]])<-colnames(returnstd)
}

# draw heatmap
library(pheatmap)
library(RColorBrewer)
png("DistMtx.png",width = 500,height = 400,bg="transparent")
pheatmap(ciao[[1]],cluster_rows=F,cluster_cols=F,border=FALSE,display_numbers = T)
dev.off()


