#Getting the data
if(!file.exists("./data")){dir.create("./data")}

#Data URL:
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./Data/Dataset.zip")

#Unzip dataset
unzip(zipfile = "./data/Dataset.zip", exdir = "./data")

# Create one R script called run_analysis.R that does the following.
#1.Merges the training and the test sets to create one data set.

#Read training tables
x_train<-read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train<-read.table("./data/UCI HAR Dataset/train/subject_train.txt")

#Read test tables
x_test<-read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test<-read.table("./data/UCI HAR Dataset/test/subject_test.txt")

#Read feature vector
features<-read.table("./data/UCI HAR Dataset/features.txt")

#Read activity labels
activityLabels<-read.table("./data/UCI HAR Dataset/activity_labels.txt")

#Assign column names
colnames(x_train)<-features[,2]
colnames(y_train)<-"activityId"
colnames(subject_train)<-"subjectId"

colnames(x_test)<-features[,2]
colnames(y_test)<-"activityId"
colnames(subject_test)<-"subjectId"

colnames(activityLabels)<-c("activityId", "activityType")

#Merge tables
merge_train<-cbind(y_train,subject_train, x_train)
merge_test<-cbind(y_test, subject_test, x_test)
all_tables<-rbind(merge_train, merge_test)

#dim(all_tables) should be 10299  563

#2.Extracts only the measurements on the mean and standard deviation for each measurement.
mean_std<-all_tables %>% select(subjectId, activityId, contains("mean"), contains("std"))

#3.Uses descriptive activity names to name the activities in the data set
mean_std$activityId<-activityLabels[mean_std$activityId,2]

#4.Appropriately labels the data set with descriptive variable names.
names(mean_std)[2]="activity"
names(mean_std)<-gsub("Acc","Accelerometer", names(mean_std))
names(mean_std)<-gsub("tBody","TimeBody", names(mean_std))
names(mean_std)<-gsub("BodyBody","Body", names(mean_std))
names(mean_std)<-gsub("Mag","Magnitude", names(mean_std))
names(mean_std)<-gsub("^t","Time", names(mean_std))
names(mean_std)<-gsub("^f","Frequency", names(mean_std))
names(mean_std)<-gsub("-mean()","Mean", names(mean_std),ignore.case = TRUE)
names(mean_std)<-gsub("-std()","STD", names(mean_std), ignore.case = TRUE)
names(mean_std)<-gsub("-freq()","Frequency", names(mean_std), ignore.case = TRUE)
names(mean_std)<-gsub("angle","Angle", names(mean_std))
names(mean_std)<-gsub("gravity","Gravity", names(mean_std))
names(mean_std)<-gsub("Gyro","Gyroscope", names(mean_std))

#5.From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
final_tidydata<-mean_std %>%
        group_by(subjectId, activity) %>%
        summarise_all(funs(mean))
write.table(final_tidydata,"final_tidydata.txt",row.names = FALSE)





