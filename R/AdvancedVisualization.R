
## ------------------------------------------------------------------------
library(raw)
data(RegionExperience)
library(ggplot2)

basePlot <- ggplot(RegionExperience)
class(basePlot)


## ------------------------------------------------------------------------
basePlot <- basePlot + aes(x = PolicyYear, y = NumClaims, group=Region, color=Region, fill=Region)


## ------------------------------------------------------------------------
p <- basePlot + geom_line()
p


## ------------------------------------------------------------------------
p <- basePlot + geom_point()
p


## ------------------------------------------------------------------------
p <- basePlot + geom_point() + geom_line()
p


## ------------------------------------------------------------------------
p <- basePlot + geom_bar(stat="identity")
p


## ------------------------------------------------------------------------
p <- ggplot(RegionExperience, aes(x = PolicyYear, y = NumClaims, group=Region, color=Region)) + geom_line()
p


## ------------------------------------------------------------------------
p <- basePlot + geom_line() + facet_wrap(~ Region)
p


## ------------------------------------------------------------------------
data(StateExperience)
p = ggplot(StateExperience, aes(x = PolicyYear, y = NumClaims, color=Fullname)) + geom_point() + facet_wrap(~ Region)
p


## ----eval=FALSE----------------------------------------------------------
## p <- ggplot(subset(StateExperience, Region == "South"), aes(x = PolicyYear, y = NumClaims, label=Postal))
## p <- p + geom_point() + facet_wrap(~ Postal)
## p


## ------------------------------------------------------------------------
library(maps)
map('state')


## ------------------------------------------------------------------------
data(Hurricane)
 
dfKatrina = subset(Hurricane, Name == 'KATRINA')
dfKatrina = dfKatrina[dfKatrina$Year == max(dfKatrina$Year), ]

 
dfHugo = subset(Hurricane, Name == 'HUGO')
dfHugo = dfHugo[dfHugo$Year == max(dfHugo$Year), ]
 
dfDonna = Hurricane[Hurricane$Name == 'DONNA', ]
dfDonna = dfDonna[dfDonna$Year == max(dfDonna$Year), ]


## ------------------------------------------------------------------------
map('state')
points(dfKatrina$Longitude, dfKatrina$Latitude, pch=19, col = 'red')
points(dfHugo$Longitude, dfHugo$Latitude, pch = 19, col = 'blue')
points(dfDonna$Longitude, dfDonna$Latitude, pch = 19, col = 'green')


