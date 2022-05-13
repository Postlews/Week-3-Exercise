<<<<<<< HEAD
##Loading any and all packages I may need
=======
#Loading any and all packages I may need
>>>>>>> 78597389f6b6b7481015edc18dcd7821d074725d

library(readr)
library(dplyr)    
library(ggplot2)
library(sf)
library(terra)
library(lubridate)
<<<<<<< HEAD
library(SimilarityMeasures)
library(tidyr)
library(ggpubr)

##Importing dataset
=======
install.packages("SimilarityMeasures")
library(SimilarityMeasures)
library(tidyr)
install.packages("ggpubr")
library(ggpubr)

#Importing dataset
>>>>>>> 78597389f6b6b7481015edc18dcd7821d074725d

caro60 <- read.csv("C:/Users/Steele/Desktop/PatternTrends/Week 3/Exercise 3/Exercise 3 - First draft/caro60.txt")

caro <- caro60

<<<<<<< HEAD
## Onto task 1

# TASK 1 - Segmentation Station

##Since our sampling window is only 1 minute, and we need to use a temporal window of 6 minutes, our window size is will have different positions. 3 minutes before, 2 minutes before, 3 minutes after, etc.
=======
# Onto task 1

# TASK 1 - Segmentation Station

#Since our sampling window is only 1 minute, and we need to use a temporal window of 6 minutes, our window size is will have different positions. 3 minutes before, 2 minutes before, 3 minutes after, etc.
>>>>>>> 78597389f6b6b7481015edc18dcd7821d074725d

caro <- caro %>%
  mutate(
    nMinus3 = sqrt((lag(E,3)-E)^2+(lag(N,3)-N)^2),
    nMinus2 = sqrt((lag(E,2)-E)^2+(lag(N,2)-N)^2),
    nMinus1 = sqrt((lag(E,1)-E)^2+(lag(N,1)-N)^2),
    nPlus1  = sqrt((E-lead(E,1))^2+(N-lead(N,1))^2),
    nPlus2  = sqrt((E-lead(E,2))^2+(N-lead(N,2))^2),
    nPlus3  = sqrt((E-lead(E,3))^2+(N-lead(N,3))^2)
  )

<<<<<<< HEAD
## Test github connection, push

#Task 2 - Specify and Apply Threshold "d"

## Attempting to calculate the mean distance for the rows
=======
>>>>>>> 78597389f6b6b7481015edc18dcd7821d074725d

caro <- caro %>%
  rowwise() %>%
  mutate(
    stepMean = mean(c(nMinus3, nMinus2, nMinus1,nPlus1,nPlus2,nPlus3))
  ) %>% ungroup()


<<<<<<< HEAD
##Exploring 

ggplot(data=caro, mapping = aes(x=stepMean))+ geom_histogram(binwidth = 0.5)



summary(caro)


## Stepmean of 6.951

## Our threshold for differentiating between stops and moves

caro <- caro %>% 
  ungroup() %>%
  mutate(static = stepMean < mean(stepMean, na.rm = TRUE))

#Task 3 - Visualizing segmented trajectories 

caro %>% 
  ggplot(aes(y=N, x=E) ) +
  geom_path()+ 
  geom_point(aes(colour=static)) + 
  coord_equal() 

###Beautiful 


# Task 4 - Segment-based analysis


rle_id <- function(vec){
  x <- rle(vec)$lengths
  as.factor(rep(seq_along(x), times=x))
}

## assigning IDs to subtrajectories

caro <- caro %>%
  mutate(segment_id = rle_id(static))


summary(caro)

caro %>%
  group_by(segment_id) %>%
  ggplot(aes(y=N, x=E,col=segment_id ) ) +
  geom_path()+ geom_point() + coord_equal() + 
  labs(title=" visualizing moving segments")



## Removing segments that are less then 5 minutes

caro5 <- caro

caro <- caro %>%
  group_by(segment_id) %>%
  mutate(
    segm_duration = as.integer(difftime(max(DatetimeUTC),min(DatetimeUTC), units="mins"))
  ) %>% 
  filter(segm_duration > 5)


caro5  %>%
  ggplot(aes(y=N, x=E,col=segment_id)) +
  geom_path()+ geom_point() + coord_equal()






=======
>>>>>>> 78597389f6b6b7481015edc18dcd7821d074725d

