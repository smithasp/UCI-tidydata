#Tidying Up the UCI HAR Dataset

##Script :run_analysis.R 

Function : create a tidy data set from the UCI data set and create a summary of each feature for each activity and subject.

The UCI dataset is assumed to be downloaded and available in the current working directory.

**Variables** used :

xtrain - data frame created from X_train.txt

xtest - data frame created from X_test.txt

features - data frame created from features.txt

subject.test - data frame created from subject_test.txt

subject.train - data frame created from subject_train.txt

activity.test - data frame created from activity_test.txt

activity.train - data frame created from activity_train.txt

subject - created by combining subject_test and subject_train

activity - created by combining activity_test and activity_train

x.test.train - created by combining xtest and xtrain.

mean.std.cols - a character vector used to hold the variable names from x.test.train whose name contains 'mean' or 'std'

x.test.train.sub - created by extracting only the variables with 'mean' or 'std' measurements from x.test.train.

x.test.train.summary - created from x.test.train.sub listing the mean value for each feature per activity and subject.


Details : The variable names from 'features' was examined for several patterns ( fea1 was used for this purpose) and were replaced by more readable alternatives before updating the column names of x.test.train. The activity is represented as a factor variable with 6 levels one for each activity. The group_by and summarise functions ( dplyr package) were used for generating the summary.The bind_rows function ( dplyr) was used to combine the data frames.

