## ----setup, echo=FALSE---------------------------------------------------
knitr::opts_knit$set(root.dir = normalizePath('../'))
knitr::opts_chunk$set(fig.width=10, fig.height=5, cache=FALSE, echo=TRUE, warning=FALSE, message=FALSE, error=FALSE)

## ------------------------------------------------------------------------
library(ggplot2)
library(dplyr)
library(raw)

## ------------------------------------------------------------------------
data(NFL)
NFL <- NFL %>% 
  mutate(Win = ifelse(Outcome == "W", 1, 0))

plt <- ggplot(NFL, aes(ThisTeamPassYards, Win)) + geom_point(alpha = 0.6) + geom_jitter(width = 0, height = .3)
plt + geom_hline(yintercept = 0.5)

## ------------------------------------------------------------------------
plt <- plt + geom_smooth(method = "glm", method.args = list(family = "binomial"))
plt + geom_hline(yintercept = 0.5)

## ------------------------------------------------------------------------
NFL <- NFL %>% 
  mutate(ThisTeamPassPct = ThisTeamPassYards / ThisTeamTotalYards)

plt <- ggplot(NFL, aes(ThisTeamPassPct, Win)) + geom_point() + geom_jitter(width = 0, height = .2)
plt + geom_hline(yintercept = 0.5)

## ------------------------------------------------------------------------
plt <- plt + geom_smooth(method = "glm", method.args = list(family = "binomial"))
plt + geom_hline(yintercept = 0.5)

## ------------------------------------------------------------------------
dfStations <- read.csv("./data/stations.csv")
dfEdges <- read.csv("./data/edges.csv")
dfRoutes <- read.csv("./data/Routes.csv")

## ------------------------------------------------------------------------
dfStations <- dfStations %>% 
  mutate(zoneFactor = as.factor(zone))

## ------------------------------------------------------------------------
plot(dfStations$longitude, dfStations$latitude, pch = 20)

## ------------------------------------------------------------------------
plt <- ggplot(dfStations, aes(longitude, latitude, col = zoneFactor)) + geom_point()
plt

## ------------------------------------------------------------------------
dfNamedEdges <- merge(dfStations, dfEdges)

