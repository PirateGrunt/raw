data(state)

dfState = as.data.frame(cbind(state.abb, state.name, state.x77, as.character(state.division), as.character(state.region)))
colnames(dfState)[1:2] = c("Postal", "Fullname")
colnames(dfState)[11:12] = c("Division", "Region")
dfState$Postal = tolower(dfState$Postal)
dfState$Fullname = tolower(dfState$Fullname)
dfState$NumPolicies = round(as.numeric(as.character(dfState$Population)) / 100, 0)
dfState$PolicyGrowth = as.numeric(as.character(dfState$Illiteracy)) / 100
dfState$Lambda = as.numeric(as.character(dfState$Murder))

rm(state.x77, state.abb, state.area, state.center, state.division, state.name, state.region)

PolicyYear = 2000:2010
df = expand.grid(list(Fullname = dfState$Fullname, PolicyYear = PolicyYear))

df = merge(df, dfState[, c("Postal", "Fullname", "NumPolicies", "PolicyGrowth", "Lambda")])

dfBase = df[df$PolicyYear == 2000, c("Fullname", "NumPolicies")]
colnames(dfBase)[2] = "BasePolicies"

df = merge(df, dfBase)

df$NumPolicies = round(df$BasePolicies * (1 + df$PolicyGrowth)^(df$PolicyYear - 2000), 0)
df$NumClaims = rpois(nrow(df), df$NumPolicies * df$Lambda)

df = merge(df, dfState[, c("Fullname", "Region")])

dfRegion = df[, c("Region", "PolicyYear", "NumPolicies", "NumClaims")]
library(reshape2)
mdf = melt(dfRegion, id.vars = c("Region", "PolicyYear"))
dfRegion = dcast(mdf, Region + PolicyYear ~ variable, sum)

setwd("~/GitHub/RPM2014/Data/")
write.csv(df, "StateData.csv")
write.csv(dfRegion, "RegionData.csv")
