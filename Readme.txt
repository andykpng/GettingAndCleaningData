This readme file is to explain how the project was done

Project Goal
	To get and clean the motional data and create another dataset with summary to the mean with regard to the mean and subject id
	The data should be tidy and is ready for subsetting

Files
	the raw data are stored in UCI folder
	the script that generate the data is run_analysis.R with function run_analysis()
	the merged data is stored in cleaned_data.txt and the final average data is stored in subject_activity_mean.txt
	the code book is stored in codebook.txt
Looking at the data
	Since we do not need measurements other than mean and standard deviation, so the data in the Inertial Signal will be omit.
	1. There are 2947 rows of test data and 7352 rows of train data
	2. There are 561 features
	3. X data contains features measurement, Y data contains activity no. and subject contains the subject id
	4. features, activity can be match with files activity_labels.txt and features.txt

Merging data Process
	x_train and x_test
		1. The column names of x_Train and x_Test will be match with features.txt so that we know which column represent what
		2. subset the data with column names with mean and std. Also with a capital Mean for the angel data. But omit the mean frequency data
	subject_train and subject_test
		1. modify the column name to subject id
	Y_train and y_test
		1. in order to preserve the ordering of data, create a new data frame to match activity id to activity label
	merging the data
		1. join X, Y and subject data using cbind. Also create another column to distinguish the data from train and test

	As the column name of the features is short enough for easy reading and clearly explain the data involve, so no modification will be made to them.

Forming new mean subject, activity data
	I used reshape2 packages to reshape the data
	First, melt the data using subject_id and activity as the id and the rest as variables
	Then dcast the data according to subject_id+activity to the variables and aggregate the mean


