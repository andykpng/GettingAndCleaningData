run_analysis <- function() {
  #Read all data into memory
  features <- read.table("UCI/features.txt")
  activity_labels <- read.table("UCI/activity_labels.txt")
  subject_train <- read.table("UCI/train/subject_train.txt")
  X_train <- read.table("UCI/train/X_train.txt")
  Y_train <- read.table("UCI/train/Y_train.txt")
  subject_test <- read.table("UCI/test/subject_test.txt")
  X_test <- read.table("UCI/test/X_test.txt")
  Y_test <- read.table("UCI/test/Y_test.txt")
  #Match column names with features
  colnames(X_train) <- features[,2]
  colnames(X_test) <- features[,2]
  #Subset columns with mean and std
  subset_X_train <- X_train[, grep("mean\\(\\)|std|Mean", colnames(X_train))]
  subset_X_test <- X_test[, grep("mean\\(\\)|std|Mean", colnames(X_test))]
  #Rename the column name in subject
  colnames(subject_train) <- "subject_id"
  colnames(subject_test) <- "subject_id"
  #Create new data frame to match activity id with activity name
  new_Y_train <- data.frame(activity = activity_labels[match(Y_train$V1, activity_labels$V1), 2])
  new_Y_test <- data.frame(activity = activity_labels[match(Y_test$V1, activity_labels$V1), 2])
  #Bind data with X, Activity, and subject, also create a first column to distinguish Train and Test data
  combine_train <- cbind(Type = "Train", subject_train, new_Y_train, subset_X_train)
  combine_test <- cbind(Type = "Test", subject_test, new_Y_test, subset_X_test)
  #Bind train and test data
  combined_data <- rbind(combine_train, combine_test)
  #Write out combined data
  write.table(combined_data, "cleaned_data.txt")
  #Use reshape2 package to reshape data
  library(reshape2)
  #Melt data according to subject_id and activity
  dataMelt <- melt(combined_data, id = c("subject_id", "activity"), measure.vars = c(names(combined_data[,-(1:3)])))
  #Cast data according to subject_id and activity and aggregate the variables mean
  mean_data <- dcast(dataMelt, subject_id + activity ~ variable, mean)                   
  #Write out subject and activity mean data
  write.table(mean_data, "subject_activity_mean.txt")
}