citation(package="fda")
citation(package="fdapace")
citation(package="MASS")
citation(package="EMCluster")

library(Matrix)
library(fda)
library(fdapace)
library(MASS)
library(EMCluster)
library(ggplot2)
library(xlsx)


data.cov<-file.path("..","data","COVID-19.xlsx")
##load the data of 16 cities in Hubei data and 30 provinces in China 

hbcity=c("Xiaogan","Huanggang","Jingzhou","Ezhou","Suizhou","Xiangyang","Huangshi","Yichang","Jingmen","Xianning","Shiyan","Xiantao","Tianmen","Enshi","Qianjiang","Shennongjia")
##set up indices of 16 cities in Hubei

chnpro=c("Zhejiang","Shanghai","Beijing","Hebei","Henan","Hunan","Anhui","Jiangxi","Shaanxi","Shanxi","Sichuan","Chongqing","Guxangxi","Guangdong","Jiangsu","Fujian","Shangdong","Neimenggu","Tianjin","Jilin","Heilongjiang","Tibet","Xinjiang","Gansu","Qinghai","Ningxia","Hainan","liaoning","Guizhou","Yunan")
##set up indices of 30 provinces in China

covday=(0:76)+0.5
daytime=1:77
daybasis77 <- create.fourier.basis(c(0, 77), nbasis=9, period=77)
## set up the times

data.hbc<-read.xlsx2(data.cov,sheetIndex=1)
hbcitymat=matrix(0,77,16)
for(i in 1:16){
  hbcitymat[,i]=as.numeric(data.hbc[,i])
}
## confirmed cases of 16 citys in Hubei 

data.proc<-read.xlsx2(data.cov,sheetIndex=3)
chnallpromat=matrix(0,77,30)
for(i in 1:30){
  chnallpromat[,i]=as.numeric(data.proc[,i])
}
## load new case of 30 China provinces 


data.hbd<-read.xlsx2(data.cov,sheetIndex=2)
hbcdmat=matrix(0,77,16)
for(i in 1:16){
  hbcdmat[,i]=as.numeric(data.hbd[,i])
}
## death cases of 16 citys in Hubei


data.prod<-read.xlsx2(data.cov,sheetIndex=4)
prodmat=matrix(0,77,30)
for(i in 1:30){
  prodmat[,i]=as.numeric(data.prod[,i])
}
## death cases of 30 provinces

op<-par(mfrow=c(1,2))
par(xaxt = 'n')
plot(hbcitymat[,1],type="o",pch=".",col=1,xlab="Date",ylab="Number of confirmed cases")
for(i in 2:16){
  points(hbcitymat[,i],pch=".")
  lines(hbcitymat[,i],col=i)
}
par(xaxt = 's')
axis(1, at = seq(0,75, by = 15), labels = c("1/23", "2/07", "2/22", "3/08", "3/23", "4/07"))
par(xaxt = 'n')
plot(apply(hbcitymat,1,mean),type="o",pch=".",col=1,xlab="Date",ylab="Number of confirmed cases")
par(xaxt = 's')
axis(1, at = seq(0,75, by = 15), labels = c("1/23", "2/07", "2/22", "3/08", "3/23", "4/07"))
##confirmed cases of 16 cities in Hubei (Left side of Figure 1)

par(xaxt = 'n')
plot(chnallpromat[,1],type="o",pch=".",col=1,xlab="Date",ylab="Number of confirmed cases")
for(i in 2:30){
  points(chnallpromat[,i],pch=".")
  lines(chnallpromat[,i],col=i)
}
par(xaxt = 's')
axis(1, at = seq(0,75, by = 15), labels = c("1/23", "2/07", "2/22", "3/08", "3/23", "4/07"))
par(xaxt = 'n')
plot(apply(chnallpromat,1,mean),type="o",pch=".",col=1,xlab="Date",ylab="Number of confirmed cases")
par(xaxt = 's')
axis(1, at = seq(0,75, by = 15), labels = c("1/23", "2/07", "2/22", "3/08", "3/23", "4/07"))
##confirmed cases of 30 provinces (Left side of Figure 1)


par(xaxt = 'n')
plot(hbcdmat[,1],type="o",pch=".",col=1,xlab="Date",ylab="Number of daeth cases",ylim=c(0,10))
for(i in 2:16){
  points(hbcdmat[,i],pch=".")
  lines(hbcdmat[,i],col=i)
}
par(xaxt = 's')
axis(1, at = seq(0,75, by = 15), labels = c("1/23", "2/07", "2/22", "3/08", "3/23", "4/07"))
par(xaxt = 'n')
plot(apply(hbcdmat,1,mean),type="o",pch=".",col=1,xlab="Date",ylab="Number of death cases")
par(xaxt = 's')
axis(1, at = seq(0,75, by = 15), labels = c("1/23", "2/07", "2/22", "3/08", "3/23", "4/07"))
##death cases of 16 cities in Hubei (Left side of Figure 9)

par(xaxt = 'n')
plot(prodmat[,1],type="o",pch=".",col=1,xlab="Date",ylab="Number of death cases",ylim=c(0,5))
for(i in 2:30){
  points(prodmat[,i],pch=".")
  lines(prodmat[,i],col=i)
}
par(xaxt = 's')
axis(1, at = seq(0,75, by = 15), labels = c("1/23", "2/07", "2/22", "3/08", "3/23", "4/07"))
par(xaxt = 'n')
plot(apply(prodmat,1,mean),type="o",pch=".",col=1,xlab="Date",ylab="Number of death cases")
par(xaxt = 's')
axis(1, at = seq(0,75, by = 15), labels = c("1/23", "2/07", "2/22", "3/08", "3/23", "4/07"))
##death cases of 30 provinces of China (Left side of Figure 9)


##surface and smooth curve
hbcityfd=smooth.basis(covday,hbcitymat,daybasis77)$fd
hbcityfd$fdnames=list("Date","Hubei cities","Number of Confirmed cases")
##smooth curve of confirmed cases of hubei cities
hbcasevarfd=var.fd(hbcityfd)
hbcasevarmat <- eval.bifd(daytime,daytime,hbcasevarfd)
persp(hbcasevarmat,theta=45,xlab="Date(Jan 23 to Apr 8)", ylab="Date(Jan 23 to Apr 8)", zlab="Variance",col="lightblue")
par(xaxt = 'n')
par(yaxt = 'n')
contour(daytime,daytime,hbcasevarmat,xlab="Date(Jan 23 to Apr 8)",ylab="Date (Jan 23 to Apr 8)",lwd=2,labcex=1)
par(xaxt = 's')
par(yaxt = 's')
axis(1, at = seq(0,75, by = 15), labels = c("1/23", "2/07", "2/22", "3/08", "3/23", "4/07"))
axis(2, at = seq(0,75, by = 15), labels = c("1/23", "2/07", "2/22", "3/08", "3/23", "4/07"))
##variance of confirmed cases of Hubei cities(top panel of Figure 2)

## new cases of 30 provinces in China
covallprofd=smooth.basis(covday,chnallpromat,daybasis77)$fd
covallprofd$fdnames=list("Date","Chinese Mainland Provinces","Number of Confirmed cases")
##smooth curve of confirmed cases of 30 provinces

procasevarfd=var.fd(covallprofd)
procasevarmat <- eval.bifd(daytime,daytime,procasevarfd)
persp(procasevarmat,theta=45,xlab="Date(Jan 23 to Apr 8)", ylab="Date(Jan 23 to Apr 8)", zlab="Variance",col="lightblue")
par(xaxt = 'n')
par(yaxt = 'n')
contour(daytime,daytime,procasevarmat,xlab="Date(Jan 23 to Apr 8)",ylab="Date(Jan 23 to Apr 8)",lwd=2,labcex=1)
par(xaxt = 's')
par(yaxt = 's')
axis(1, at = seq(0,75, by = 15), labels = c("1/23", "2/07", "2/22", "3/08", "3/23", "4/07"))
axis(2, at = seq(0,75, by = 15), labels = c("1/23", "2/07", "2/22", "3/08", "3/23", "4/07"))
##variance of confirmed cases of 30 provinces (bottom panel of Figure 2)

###Hubei death figure
covhbcdfd=smooth.basis(covday,hbcdmat,daybasis77)$fd
covhbcdfd$fdnames=list("Date","Hubei cities","Number of Death cases")
##smooth curve of death cases of 16 hubei cities

hbdeathvarfd=var.fd(covhbcdfd)
hbdeathvarmat <- eval.bifd(daytime,daytime,hbdeathvarfd)
persp(hbdeathvarmat,theta=45,xlab="Date(Jan 23 to Apr 8)", ylab="Date(Jan 23 to Apr 8)", zlab="Variance",col="lightblue")
par(xaxt = 'n')
par(yaxt = 'n')
contour(daytime,daytime,hbdeathvarmat,xlab="Date(Jan 23 to Apr 8)",ylab="Date(Jan 23 to Apr 8)",lwd=2,labcex=1)
par(xaxt = 's')
par(yaxt = 's')
axis(1, at = seq(0,75, by = 15), labels = c("1/23", "2/07", "2/22", "3/08", "3/23", "4/07"))
axis(2, at = seq(0,75, by = 15), labels = c("1/23", "2/07", "2/22", "3/08", "3/23", "4/07"))
##variance of death cases of 16 cities in Hubei provinces (top panel of Figure 10)

### 30 Provinces death cases
covprocdfd=smooth.basis(covday,prodmat,daybasis77)$fd
covprocdfd$fdnames=list("Date","Chinese Mainland Provinces","Number of Death cases")
##smooth curve of death cases of 30 provinces

prodeathvarfd=var.fd(covprocdfd)
prodeathvarmat <- eval.bifd(daytime,daytime,prodeathvarfd)
persp(prodeathvarmat,theta=45,xlab="Date(Jan 23 to Apr 8)", ylab="Date(Jan 23 to Apr 8)", zlab="Variance",col="lightblue")
par(xaxt = 'n')
par(yaxt = 'n')
contour(daytime,daytime,prodeathvarmat,xlab="Day(Jan 23 to Apr 8)",ylab="Day (Jan 23 to Apr 8)",lwd=2,labcex=1)
par(xaxt = 's')
par(yaxt = 's')
axis(1, at = seq(0,75, by = 15), labels = c("1/23", "2/07", "2/22", "3/08", "3/23", "4/07"))
axis(2, at = seq(0,75, by = 15), labels = c("1/23", "2/07", "2/22", "3/08", "3/23", "4/07"))
##variance of death cases in 30 provinces (bottom panel of Figure 10)



#covariance between confirmed and death in 16 cities
hbcdcor=var.fd(hbcityfd,covhbcdfd)
hbcdcormat<-eval.bifd(daytime,daytime,hbcdcor)
persp(hbcdcormat,theta=45,xlab="Days(Jan 23 to Apr 8)", ylab="Days(Jan 23 to Apr 8)", zlab="Variance",col="lightblue")
par(xaxt = 'n')
par(yaxt = 'n')
contour(daytime,daytime,hbcdcormat,xlab="Day(Jan 23 to Apr 8)",ylab="Day (Jan 23 to Apr 8)",lwd=2,labcex=1)
par(xaxt = 's')
par(yaxt = 's')
axis(1, at = seq(0,75, by = 15), labels = c("1/23", "2/07", "2/22", "3/08", "3/23", "4/07"))
axis(2, at = seq(0,75, by = 15), labels = c("1/23", "2/07", "2/22", "3/08", "3/23", "4/07"))
##Top panel of Figure 11

#covariance between confirmed and death in 30 provinces
procdcor=var.fd(covallprofd,covprocdfd)
procdcormat<-eval.bifd(daytime,daytime,procdcor)
persp(procdcormat,theta=45,xlab="Days(Jan 23 to Apr 8)", ylab="Days(Jan 23 to Apr 8)", zlab="Variance",col="lightblue")
par(xaxt = 'n')
par(yaxt = 'n')
contour(daytime,daytime,procdcormat,xlab="Day(Jan 23 to Apr 8)",ylab="Day (Jan 23 to Apr 8)",lwd=2,labcex=1)
par(xaxt = 's')
par(yaxt = 's')
axis(1, at = seq(0,75, by = 15), labels = c("1/23", "2/07", "2/22", "3/08", "3/23", "4/07"))
axis(2, at = seq(0,75, by = 15), labels = c("1/23", "2/07", "2/22", "3/08", "3/23", "4/07"))
##Bottom panel of Figure 11


Lfd<-vec2Lfd(c(0,(2*pi/77)^2,0),c(0,77))
fdPar<-fdPar(daybasis77,Lfd,lambda=1e5)

## fpa for new cases of 16 citys in Hubei 
op<-par(mfrow=c(1,2))
hbcitypacobj<-pca.fd(hbcityfd,nharm=2,fdPar) 
plot.pca.fd(hbcitypacobj,cex.main=0.9)
hbcitypacobj$varprop
hbcitypacobj$values
## principal components analysis of confirmed cases of 16 cities in Hubei 
##(Figure 3)


#pca for 30 provinces
chnallpropacobj<-pca.fd(covallprofd,nharm=2,fdPar) 
plot.pca.fd(chnallpropacobj,cex.main=0.9)
##principal components analysis of confirmed cases of 30 provinces 
##(Figure 4)

## fpa for death cases of 16 cities in Hubei 
hbcdpacobj<-pca.fd(covhbcdfd,nharm=2,fdPar) 
plot.pca.fd(hbcdpacobj,cex.main=0.9)
## principal components analysis of death cases of 16 cities in Hubei 
##(Figure 12)

## fpa for death cases of 30 provinces
chnprodpacobj<-pca.fd(covprocdfd,nharm=2,fdPar) 
plot.pca.fd(chnprodpacobj,cex.main=0.9)
## principal components analysis of death cases of 30 provinces 
##(Figure 13)




op<-par(mfrow=c(1,2))
#FCCA for Wuhan
cca.hb<-cca.fd(hbcityfd,covhbcdfd,ncan=2,fdPar,fdPar)
cca.hb$ccacorr
##functional canonical correlation analysis between confirmed and death cases in 16 cities in Hubei
par(xaxt = 'n')
plot(cca.hb$ccawtfd1[1],ylab = "Canonical weight function value")
par(xaxt = 's')
axis(1, at = seq(0,75, by = 15), labels = c("1/23", "2/07", "2/22", "3/08", "3/23", "4/07"))
par(xaxt = 'n')
plot(cca.hb$ccawtfd1[2],ylab = "Canonical weight function value")
par(xaxt = 's')
axis(1, at = seq(0,75, by = 15), labels = c("1/23", "2/07", "2/22", "3/08", "3/23", "4/07"))
##the first pair of canonical functions
##Left panel of Figure 5
data.hbcity<-data.frame(City=hbcity,case_weight=cca.hb$ccavar1[,1],death_weight=cca.hb$ccavar2[,1])
ggplot(data.hbcity, aes(x = case_weight, y =death_weight)) +geom_point()+labs(x='Confirmed case canonical weight',y='Death case canonical weight')+geom_text(aes(label=City),size=4,vjust = 0, nudge_y = 0.2,check_overlap = TRUE)
##the scores of the first pair of canonical variables against each other of 16 cities in Hubei (top panel of Figure 6)
##Top panel Figure 6


#FCCA for 30 provinces
cca.pro<-cca.fd(covallprofd,covprocdfd,ncan=2,fdPar,fdPar)
cca.pro$ccacorr
##functional canonical correlation analysis between confirmed and death cases of 30 provinces
par(xaxt = 'n')
plot(cca.pro$ccawtfd1[1],ylab = "Canonical weight function value")
par(xaxt = 's')
axis(1, at = seq(0,75, by = 15), labels = c("1/23", "2/07", "2/22", "3/08", "3/23", "4/07"))
par(xaxt = 'n')
plot(cca.pro$ccawtfd1[2],ylab = "Canonical weight function value")
par(xaxt = 's')
axis(1, at = seq(0,75, by = 15), labels = c("1/23", "2/07", "2/22", "3/08", "3/23", "4/07"))
##functional canonical correlation analysis between confirmed and death cases of 30 provinces
##Right panel of Figure 5

data.pro<-data.frame(Province=chnpro,case_weight=cca.pro$ccavar1[,1],death_weight=cca.pro$ccavar2[,1])
ggplot(data.pro, aes(x = case_weight, y =death_weight)) +geom_point()+labs(x='Confirmed Case canonical weight',y='Death case canonical weight')+geom_text(aes(label=Province),size=4,vjust = 0, nudge_y = 0.02,check_overlap = TRUE)
##the scores of the first pair of canonical variables against each other of 30 provinces
##Bottom panel of Figure 6



#functional cluster analysis for 16 cities in Hubei
fclus.city.id<-matrix(0,1232,1)
for(i in 1:16){
  fclus.city.id[(77*(i-1)+1):(77*i),]=i
}
fclus.city.day<-matrix(0,1232,1)
for(i in 1:16){
  fclus.city.day[(77*(i-1)+1):(77*i),]=1:77
}
fclus.city.cov<-matrix(hbcitymat,1232,1)
# load data to analyze
Files2<-MakeFPCAInputs(fclus.city.id,fclus.city.day,fclus.city.cov)
city.clust<-FClust(Files2$Ly,Files2$Lt,k=3)
city.clust$cluster
#functional cluster analysis for 16 cities in Hubei with cluster number 3 (Figure 8)

#functional cluster analysis for 30 provinces
fclus.id<-matrix(0,2310,1)
for(i in 1:30){
  fclus.id[(77*(i-1)+1):(77*i),]=i
}
fclus.day<-matrix(0,2310,1)
for(i in 1:30){
  fclus.day[(77*(i-1)+1):(77*i),]=1:77
}
fclus.cov<-matrix(chnallpromat,2310,1)
# load data to analyze
Files1<-MakeFPCAInputs(fclus.id,fclus.day,fclus.cov)
pro.clust<-FClust(Files1$Ly,Files1$Lt,k=4)
pro.clust$cluster
## functional cluster analysis for 30 provinces with cluster number 4 (Figure 9)



