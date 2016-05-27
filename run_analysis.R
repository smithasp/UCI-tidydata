library(dplyr)

## read in the data
xtrain <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
xtest <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")

## feature list
features <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")

## checking for NAs
any(is.na(xtrain))
any(is.na(xtest))

## make the feature names more readable by replacing unnecessary patterns.
fea1 <- sub("-",".",features$V2) 
fea1 <- sub("\\(\\)-*",".",fea1)
fea1 <- sub(",","_",fea1)
fea1 <- sub("Acc","Acceleration",fea1)

features$V2 <- fea1

## combine the data, test and train
x.test.train <- bind_rows(xtest,xtrain)

## update the column names
colnames(x.test.train) <- features$V2

## combine the subject data from test and train
subject.test <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
subject.train <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
subject <- bind_rows(subject.test,subject.train)

## combine the activity data from test and train
activity.test <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
activity.train <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
activity <- bind_rows(activity.test,activity.train)

## convert the activity variable into a factor variable
activity$V1 <- factor(activity$V1,levels = 1:6,labels = c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"))
colnames(activity) <- "activity"
colnames(subject) <- "subject"

## add subject and activity info to x.test.train
x.test.train <- bind_cols(subject,activity,x.test.train)

## extract the columns whose name contains 'mean' or 'std' into a new data frame, x.test.train.sub
mean.std.cols <- grep("mean|std",colnames(x.test.train),value = FALSE)
x.test.train.sub <- x.test.train[,mean.std.cols]

## update the data frame with subject and activity info
x.test.train.sub <- bind_cols(subject, activity, x.test.train.sub)

## create the summary data frame 
x.test.train.summary <- x.test.train.sub %>% group_by(activity,subject) %>% summarise_each(funs(mean))


