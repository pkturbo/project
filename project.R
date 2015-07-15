# Practical Machine Learning Project
#
# by pkturbo

# load libraries
library(caret)

# train a random forest model

# this file is for training and testing your model
train.Data <- read.csv(file='pml-training.csv')

# create training and testing data sets
inTraining <- createDataPartition(y=train.Data$classe,p=0.7,list=FALSE)
training <- train.Data[inTraining,]
testing <- train.Data[-inTraining,]

# explore the data set
featurePlot(training[,-160],training$classe)

# preprocess the training data
preObj <- preProcess(training[,-classe],method="knnImpute")

modFit <- train(classe ~ .,data=training,)
modFit