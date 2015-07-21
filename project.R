# Practical Machine Learning Project
#
# by pkturbo

# load libraries
library(caret)

# this file is for training and testing my model
train.Data <- read.csv(file = 'pml-training.csv',stringsAsFactors = FALSE,
                       na.strings = c("NA","#DIV/0!",""))
train.Data$classe <- as.factor(train.Data$classe)

# filter out NAs, DIV/0, blank columns
temp.Data <- train.Data[train.Data$new_window == "no",seq(7,160)]
bad <- logical(154)
cs <- colSums(temp.Data[,-154])
bad <- complete.cases(cs)
bad[154] <- FALSE
train.Data2 <- temp.Data[,c(1:5,31:43,54:62,96,107:118,134,145:154)]


# create training and testing data sets
inTraining <- createDataPartition(y = train.Data2$classe,p = 0.7,list = FALSE)
training <- train.Data2[inTraining,]
testing <- train.Data2[-inTraining,]

# preprocess and train a random forest model
# using smaller test set due to memory constraints
modFit <- train(classe ~ .,data=testing,method="rf",
                preProcess=c("center","scale"),prox=TRUE)
save(modFit,file='modFitRf.Rdata')
modFit

pred <- predict(modFit,data=training)
table(pred,testing$classe)




pml_write_files = function(x) {
        n = length(x)
        for (i in 1:n) {
                filename = paste0("problem_id_",i,".txt")
                write.table(
                        x[i],file = filename,quote = FALSE,row.names = FALSE,col.names = FALSE
                )
        }
}