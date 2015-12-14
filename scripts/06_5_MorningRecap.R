## ------------------------------------------------------------------------
  num<-10000;  ml<-5;  sdl<-2
  x1<-rlnorm(num,meanlog=ml,sdlog=sdl)
  q1<-quantile(x1,probs=seq(from=.1,to=.9,by=.1))
  mySummary<-c(min(x1),max(x1),mean(x1),sd(x1),q1)
  names(mySummary)[1:4]<-c("Min","Max","Mean","SD")
  mySummary

## ------------------------------------------------------------------------
y1<-log(x1)
(m1<-mean(y1))
(s1<-sd(y1))

## ------------------------------------------------------------------------
hist(y1,freq=FALSE)

## ------------------------------------------------------------------------
qqnorm(y1)

## ------------------------------------------------------------------------
  suppressWarnings(library(Lahman)); data(Teams)

## ------------------------------------------------------------------------
  data1<-Teams[Teams$yearID>1979,c("yearID","teamID","W","attendance")]
  head(data1)

## ------------------------------------------------------------------------
  atl<-data1[data1$teamID=="ATL",]
  plot(x=atl$W,y=atl$attendance,pch=19,xlab="Wins",ylab="Attendance")
  title(main="Atlanta \n 1980-2104")

## ------------------------------------------------------------------------
data1920<-Teams[Teams$yearID > 1919 & Teams$yearID<1930 
                & Teams$lgID=="NL",c("yearID","teamID","W")]
head(data1920)

## ------------------------------------------------------------------------
  totalWins<-aggregate(W~teamID,data=data1920,FUN=sum)
  dim(totalWins)
  totalWins

## ------------------------------------------------------------------------
data(iris)
boxplot(Sepal.Length~Species,data=iris,xlab="Species")
title(main="Sepal Length of Iris Species")

## ------------------------------------------------------------------------
plot(x=iris$Petal.Length,y=iris$Petal.Width,pch=19,cex=.5,
     bty="l",xlab="Petal Length",ylab="Petal Width",
     col=as.numeric(iris$Species))
legend("topleft",fill=palette()[1:3],
       legend=levels(iris$Species),bty="n")

