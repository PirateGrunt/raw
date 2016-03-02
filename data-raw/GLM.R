library(dplyr)
set.seed(1234)

Age <- c(sample(15:44, 120, replace=TRUE)
         ,sample(45:74, 120, replace=TRUE))

Cars <- c(rpois(130, 0.3)+1
             , rpois(90, 0.4)+1
             , rpois(20, 0.7)+1)

FamilySize<-c(rpois(30, 0.3) + 1
               , rpois(100, 0.4) + 1
               , rpois(110, 0.7) + 1)

AutoGLM <- data.frame(Age, Cars, FamilySize)

AutoGLM <- AutoGLM %>% 
  mutate(Log = -Age/20 + Cars + FamilySize + rnorm(240, mean=0, sd=0.1)) %>% 
  mutate(P = 1 / (1 + exp(-Log)))

AutoGLM$ClaimCount <- rbinom(240, 1, AutoGLM$P)
zeroCounts <- which(AutoGLM$ClaimCount == 0)
AutoGLM$ClaimCount[sample(zeroCounts, 5)] <- 2

save(list="AutoGLM", file = "./data/AutoGLM.rda", compress = "xz")
