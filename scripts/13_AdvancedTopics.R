## ------------------------------------------------------------------------
assign("x",1)
x

## ------------------------------------------------------------------------
x<--3
x

## ------------------------------------------------------------------------
x<-1
eval(x)
eval("x")

eval(parse(text="x"))

## ------------------------------------------------------------------------
library(XML)
nflStandings<-"http://sports.yahoo.com/nfl/standings/"
nflTables <- readHTMLTable(nflStandings)

class(nflTables)

## ------------------------------------------------------------------------
length(nflTables)
sapply(nflTables,class)

## ------------------------------------------------------------------------
head(lapply(nflTables,dim))

## ------------------------------------------------------------------------
str(nflTables[[1]])
str(nflTables[[2]])

## ------------------------------------------------------------------------
nflTables[[2]][,1:7]

## ------------------------------------------------------------------------
division<-names(nflTables)[2:9]
conference<-c(rep("AFC",4),rep("NFC",5))

nflTables<-lapply(2:9,function(i) 
  cbind(conference[i],division[i],nflTables[[i]][,1:7]))

length(nflTables)

## ------------------------------------------------------------------------
nflTables[[1]]

## ------------------------------------------------------------------------
nflStandings<-do.call(rbind,nflTables)
names(nflStandings)[1:2]<-c("Conference","Division")
dim(nflStandings)
head(nflStandings)

## ------------------------------------------------------------------------
palette()
head(colors())

## ------------------------------------------------------------------------
set.seed(6345789)
numColors<-10
n1<-sample(1:length(colors()),replace=FALSE,
           size=numColors)
pie(rep(1,numColors),col=colors()[n1],
    labels=colors()[n1])
title(main="A Color Wheel")

## ------------------------------------------------------------------------
pie(rep(1,length(palette())),col=palette(),
    labels=palette())
title(main="Default")

## ----fig.width=3,fig.height=3--------------------------------------------
numColors<-8
pie(rep(1,numColors),col=rainbow(numColors),
    labels=rainbow(numColors))
title(main=paste("rainbow(",numColors,")",sep=""))
title(sub="Note that the names are in RGB")

## ----fig.width=4,fig.height=3--------------------------------------------
library(RColorBrewer)
display.brewer.pal(6,"RdBu")

## ----message=FALSE-------------------------------------------------------
library(dplyr)
library(nycflights13)
data(flights)

## ------------------------------------------------------------------------
class(flights)
dim(flights)

## ------------------------------------------------------------------------
flights

## ------------------------------------------------------------------------
library(Lahman)
class(Master)

## ------------------------------------------------------------------------
names(Master)
Master<-tbl_df(Master)
ruthTable<-filter(Master,nameLast=="Ruth")

## ------------------------------------------------------------------------
class(ruthTable)
ruthTable

## ------------------------------------------------------------------------
williamsTable<-filter(Master,nameLast=="Williams")
nrow(williamsTable)

## ------------------------------------------------------------------------
tedWilliams<-filter(williamsTable,nameFirst=="Ted")
tedWilliams

## ------------------------------------------------------------------------
tw<-filter(Master,nameFirst=="Ted" & nameLast=="Williams")
tw

## ------------------------------------------------------------------------
select(Master,playerID,nameLast,nameFirst,bats,throws)

## ------------------------------------------------------------------------
Master %>% tbl_df() %>%
      select(playerID,nameLast,nameFirst,bats,throws) %>%
      filter(nameLast=="Williams" & nameFirst=="Ted")

## ------------------------------------------------------------------------
tempBatting <- Batting %>% tbl_df %>% filter(yearID > 1999 & AB >599) %>%
  select(playerID,yearID,AB,H) %>% mutate(AVG=round(H/AB,3))
tempBatting

## ------------------------------------------------------------------------

inner_join(tempBatting,Master,by="playerID") %>%
  select(nameLast,nameFirst,yearID,AB,H,AVG) %>%
  arrange(desc(AVG))

## ------------------------------------------------------------------------
Master<-Master %>% tbl_df()
Pitching<-Pitching %>% tbl_df()
temp<-inner_join(Pitching,Master,by="playerID") %>%
 filter(yearID >1959 & yearID <=1969) %>%
  filter(throws=="L" & GS==0) %>%
  select(playerID,nameLast,nameFirst,G,IPouts,SO) %>%
  group_by(playerID,nameLast,nameFirst) %>% summarize(Seasons=n(),Games=sum(G),Outs=sum(IPouts),SO=sum(SO)) %>%
  mutate(SO_27=round((SO/Outs)*27,1)) %>%
  filter(Seasons>=5) %>% 
  select(nameLast,nameFirst,Seasons,Games,Outs,SO,SO_27)

## ------------------------------------------------------------------------
temp

