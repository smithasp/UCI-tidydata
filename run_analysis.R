library(dplyr)

xtrain <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
xtest <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")

features <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")

any(is.na(xtrain))
any(is.na(xtest))

fea1 <- sub("-",".",features$V2) 
fea1 <- sub("\\(\\)-*",".",fea1)
fea1 <- sub(",","_",fea1)
fea1 <- sub("Acc","Acceleration",fea1)

features$V2 <- fea1

x.test.train <- bind_rows(xtest,xtrain)
colnames(x.test.train) <- features$V2

subject.test <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
subject.train <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
subject <- bind_rows(subject.test,subject.train)

activity.test <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
activity.train <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
activity <- bind_rows(activity.test,activity.train)

activity$V1 <- factor(activity$V1,levels = 1:6,labels = c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"))
colnames(activity) <- "activity"
colnames(subject) <- "subject"

x.test.train <- bind_cols(subject,activity,x.test.train)

mean.std.cols <- grep("mean|std",colnames(x.test.train),value = FALSE)
x.test.train.sub <- x.test.train[,mean.std.cols]
x.test.train.sub <- bind_cols(subject, activity, x.test.train.sub)

x.test.train.summary <- x.test.train.sub %>% group_by(activity,subject) %>% summarise_each(funs(mean))


