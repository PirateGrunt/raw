## ------------------------------------------------------------------------
rootDir<-"../data-raw/"
clm_cnt <- read.csv(file=paste0(rootDir,"11_GLMs.csv"))

## ------------------------------------------------------------------------
dim(clm_cnt)
colnames(clm_cnt)
summary(clm_cnt)

apply(clm_cnt,2,table)

avg<-function(x) {
  data<-aggregate(clm_cnt[,"clm"],by=list(clm_cnt[,x]),FUN=mean)
  barplot(data[,2],main=x,xlab=x,ylab="Claim Count Averages")
}
avg(x="age")
avg(x="num_car")
avg(x="family_size")

cor(clm_cnt[,-1])

## ------------------------------------------------------------------------
poisson_reg <- glm(clm~ age+num_car+family_size,   data = clm_cnt,   family = poisson)
summary(poisson_reg)
coef(poisson_reg)
str(poisson_reg)
head(poisson_reg$residuals)
head(poisson_reg$fitted.values)
head(poisson_reg$data)

poisson_reg2 <- glm(clm~ age+num_car,   data = clm_cnt,   family = poisson)
summary(poisson_reg2)

## ------------------------------------------------------------------------
summary(clm_cnt$clm)
table(clm_cnt$clm)

## ------------------------------------------------------------------------
clm_cnt$clm_cap <- ifelse(clm_cnt$clm==0,0,1)
logistic_reg <- glm(clm_cap~ age+num_car+family_size,   data= clm_cnt,   family = binomial)
summary(logistic_reg)

## ------------------------------------------------------------------------
AIC(poisson_reg)
AIC(poisson_reg2)
AIC(logistic_reg)

## ----cars----------------------------------------------------------------
BIC(poisson_reg)
BIC(poisson_reg2)

BIC(logistic_reg)

