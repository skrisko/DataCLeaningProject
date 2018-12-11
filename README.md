# DataCLeaningProject

This project is part of the online formation Data CLeaning from coursera. The aim is to work with large data set, to merge them, clean them and extract some informations. 
This work is based on the work Human Activity Recognition Using Smartphones Dataset made in the Genoa University in Italy. 

## How the script work

Script write with R Studio version 3.5

OS: Windows version 10.0.17134.407

The first line of the script set the working directory. 

Then the different files that are needed to build the asked data set are readed. 

Two intermediaries variables are created, train and test. Where all the usefull information for each data set train and test are grouped into one data frame. 

Then the name of the mesurement are extracted from the file feature. In the two intermediary variables the column name are changed. 

At this point there is two data frame one for the dataset train and one for the data set test. Each one contain the mesurement of the different value from the studie 561 differents mesures. The train data frame contain 7352 observations from the different activities and subject, the test data frame contain 2947 observations. 

The two data frame are merged into one. 

Then from the name of the mesurement the mesure that interest us are extracted. More presisely the mean and standard deviation of each mesurement. 

In the activities column the number of the activities are change with the name of it. 

The dataset is then separated into 6 data frame one for each activities. This 6 data set are splitted by subject. This allow to calculated the mean of each mesure for each activity and each subject. 

Then the mean of each column are calculated. The result are cleaned from the line activity and subject. At this point the column are the subject, the line the differents mean of the mesurement. 

The 6 matrix merge into one. 

This matrix of the mean of each mesurement, by activities, by subject called activitiesMean are write into a text file with the function write.table. 

The matrix activitiesMean has 30 columns and 396 lines, 66 line pro activities.
