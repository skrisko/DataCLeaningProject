## First the working directory is set to be in folder of Samsung
setwd("getdata_projectfiles_UCI HAR Dataset")
library(dplyr)

## Reading of all the usefull documents, X, y, suject to find who has made what.

feature <- read.table("UCI HAR Dataset/features.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

## Creation of two intermediary variables test and train that contain all the information needed, 
##activities done, subject and result. One is for the set of data Train and the other for the set Test
test <- cbind(X_test, y_test, subject_test)
train <- cbind(X_train, y_train, subject_train)

## From feature the name of the mesurement are extracted
name <- feature[,2]
name <- as.character(name)

## The column of the intermediary variables are renamed.
names(test) <- c(name, "activities", "subject")
names(train) <- c(name, "activities", "subject")

## The data from Train and Test are merged into one data
mergedData <- rbind(test, train)

## The list of the activities with mean and std are search to find witch column need to be keeped.
toKeep <- grep("mean", name)
toKeep2 <- grep("std", name)

## The activities column and the subject column are added to the column to keep
toKeep3 <- c(toKeep, toKeep2, 562, 563)

## The vector is sorted
toKeep3 <- sort(toKeep3)

## The data mean and std from all the variable are subsetted
subMergedData <- mergedData[toKeep3]

## The name of the variable that are knwo in place are extracted a second time
name2 <- names(subMergedData)

## There is some data that are labeled meanFreq that are not wanted. I haven't find a better way to 
## extract only the mean. I know it is not very pretty and efficient but it works. 
toRemove <- grep("meanFreq()", name2)

## The column with meanFreq() are removed
subMergedData <- subMergedData[-toRemove]

## A copy are made
second <- subMergedData

## The name of the activities are changed from nummer to label to have a tidy data set
subMergedData[,"activities"] <- sub("1","WALKING",subMergedData$activities)
subMergedData[,"activities"] <- sub("2","WALKING_UPSTAIRS",subMergedData$activities)
subMergedData[,"activities"] <- sub("3","WALKING_DOWNSTAIRS",subMergedData$activities)
subMergedData[,"activities"] <- sub("4","SITTING",subMergedData$activities)
subMergedData[,"activities"] <- sub("5","STANDING",subMergedData$activities)
subMergedData[,"activities"] <- sub("6","LAYING",subMergedData$activities)

## From the copy of the data set, a subset of each activities are created to 
## be able then to spit by subject
act1 <- subset(second, activities == 1)
act2 <- subset(second, activities == 2)
act3 <- subset(second, activities == 3)
act4 <- subset(second, activities == 4)
act5 <- subset(second, activities == 5)
act6 <- subset(second, activities == 6)

## The 6 subset are splitted by subject
s1 <- split(act1, act1$subject)
s2 <- split(act2, act2$subject)
s3 <- split(act3, act3$subject)
s4 <- split(act4, act4$subject)
s5 <- split(act5, act5$subject)
s6 <- split(act6, act6$subject)
 
## The mean of each colum are calculated
walkingMean <- sapply(s1,colMeans)
walking_upstairsMean <- sapply(s2,colMeans)
walking_downstairsMean <- sapply(s3,colMeans)
sittingMean <- sapply(s4,colMeans)
standingMean <- sapply(s5,colMeans)
layingMean <- sapply(s6,colMeans)

## The line of activities and subject are removed
walkingMean <- walkingMean[-c(67,68),]
walking_upstairsMean <- walking_upstairsMean[-c(67,68),]
walking_downstairsMean <- walking_downstairsMean[-c(67,68),]
sittingMean <- sittingMean[-c(67,68),]
standingMean <- standingMean[-c(67,68),]
layingMean <- layingMean[-c(67,68),]

## The mean of the 6 activities are merged together 
activitiesMean <- rbind(walkingMean, walking_upstairsMean, walking_downstairsMean, sittingMean, standingMean, layingMean)

## The data set of the mean of each variable for each subject and for each activities are writte in a 
## text file
write.table(activitiesMean, file = "activitiesMean.txt", row.names = FALSE)
