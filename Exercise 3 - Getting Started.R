#Loading any and all packages I may need

library(readr)
library(dplyr)    
library(ggplot2)
library(sf)
library(terra)
library(lubridate)
install.packages("SimilarityMeasures")
library(SimilarityMeasures)
library(tidyr)
install.packages("ggpubr")
library(ggpubr)

#Importing dataset

caro60 <- read.csv("C:/Users/Steele/Desktop/PatternTrends/Week 3/Exercise 3/Exercise 3 - First draft/caro60.txt")

caro <- caro60

# Onto task 1

# TASK 1 - Segmentation Station

#Since our sampling window is only 1 minute, and we need to use a temporal window of 6 minutes, our window size is will have different positions. 3 minutes before, 2 minutes before, 3 minutes after, etc.

caro <- caro %>%
  mutate(
    nMinus3 = sqrt((lag(E,3)-E)^2+(lag(N,3)-N)^2),
    nMinus2 = sqrt((lag(E,2)-E)^2+(lag(N,2)-N)^2),
    nMinus1 = sqrt((lag(E,1)-E)^2+(lag(N,1)-N)^2),
    nPlus1  = sqrt((E-lead(E,1))^2+(N-lead(N,1))^2),
    nPlus2  = sqrt((E-lead(E,2))^2+(N-lead(N,2))^2),
    nPlus3  = sqrt((E-lead(E,3))^2+(N-lead(N,3))^2)
  )


caro <- caro %>%
  rowwise() %>%
  mutate(
    stepMean = mean(c(nMinus3, nMinus2, nMinus1,nPlus1,nPlus2,nPlus3))
  ) %>% ungroup()



