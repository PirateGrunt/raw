## ------------------------------------------------------------------------
set.seed(1234)
N <- 30
df <- data.frame(Cohort = c(rep("F", N), rep("M", N))
                 , weight = c(rnorm(N, 150, 10), rnorm(N, 172, 10))
                 , height = c(rnorm(N, 64, 10), rnorm(N, 70, 10))
)

library(ggplot2)
basePlot <- ggplot(df)

## ------------------------------------------------------------------------
basePlot <- basePlot + aes(x = height, y = weight)

## ------------------------------------------------------------------------
basePlot <- basePlot + aes(color = Cohort)

## ------------------------------------------------------------------------
basePlot <- basePlot + geom_point()
basePlot

## ------------------------------------------------------------------------
plt <- ggplot(df, aes(x = height, y = weight, color = Cohort)) + geom_point()
plt

## ------------------------------------------------------------------------
ggplot(df, aes(x = height, y = weight, color = Cohort)) + geom_point() + geom_rug()
ggplot(df, aes(x = height, y = weight, color = Cohort)) + geom_point() + geom_density2d()

## ------------------------------------------------------------------------
plt <- ggplot(df, aes(x = height, y = weight, color = Cohort)) + geom_point() + facet_wrap(~ Cohort)
plt

## ------------------------------------------------------------------------
plt <- ggplot(df, aes(x = height, y = weight, color = Cohort)) + geom_point() + geom_smooth(method = "lm")
plt

## ------------------------------------------------------------------------
library(raw)
data("RegionExperience")
plt1 <- ggplot(RegionExperience, aes(x = PolicyYear, y = NumClaims)) + geom_point()
plt1

plt2 <- plt1 + aes(color = Region)
plt2

plt3 <- plt2 + stat_smooth(method = "lm")
plt3

RegionExperience$Frequency <- with(RegionExperience, NumClaims / NumPolicies)

plt4 <- ggplot(RegionExperience, aes(x = PolicyYear, y = Frequency, color = Region)) + geom_point() + geom_line() + stat_smooth(method = lm)
plt4

## ------------------------------------------------------------------------
data("StateExperience")
pltExtra <- ggplot(StateExperience, aes(x = PolicyYear, y = NumClaims, color = Postal)) + geom_point() + geom_line()
pltExtra + facet_wrap(~ Region)

## ------------------------------------------------------------------------
library(maps, quietly = TRUE, verbose = FALSE, warn.conflicts = FALSE)
map('state')

## ------------------------------------------------------------------------
library(raw)
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

## ----warning=FALSE-------------------------------------------------------
library(choroplethr)
library(choroplethrMaps)

mapData <- subset(StateExperience, PolicyYear == 2010)
mapData$value <- mapData$NumClaims
mapData$region <- mapData$Fullname
state_choropleth(mapData)

## ------------------------------------------------------------------------
states_map <- map_data("state")

plt <- ggplot(subset(StateExperience, PolicyYear == 2010), aes(map_id = Fullname))
plt <- plt + geom_map(aes(fill = NumClaims), color = "black", map = states_map)
plt <- plt + expand_limits(x = states_map$long, y = states_map$lat)
plt <- plt + coord_map()
plt

## ------------------------------------------------------------------------
plt <- ggplot(StateExperience, aes(map_id = Fullname))
plt <- plt + geom_map(aes(fill = NumClaims), color = "black", map = states_map)
plt <- plt + expand_limits(x = states_map$long, y = states_map$lat)
plt <- plt + facet_wrap( ~ PolicyYear)
plt <- plt + coord_map()
plt


