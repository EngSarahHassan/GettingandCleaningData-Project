#---------------------------------------------------------------
#1-Merges the training and the test sets to create one data set
#---------------------------------------------------------------
#Set files pather
datasetdir= "data/UCI HAR Dataset"

x_train_file = paste0(datasetdir,"/train/X_train.txt")
y_train_file = paste0(datasetdir,"/train/y_train.txt")
x_test_file = paste0(datasetdir,"/test/X_test.txt")
y_test_file = paste0(datasetdir,"/test/y_test.txt")

#Load files into memory        
x_train_tbl<-read.table(x_train_file )
y_train_tbl<-read.table(y_train_file )
x_test_tbl<-read.table(x_test_file )
y_test_tbl<-read.table(y_test_file )
        
#Merge train and test data

x<-rbind(x_train_tbl,x_test_tbl)
y<-rbind(y_train_tbl,y_test_tbl)
#---------------------------------------------------------------
#2-Extracts only the measurements on the mean and standard deviation for each measurement
#---------------------------------------------------------------
# Read features names file
features_names_file<-paste0(datasetdir,"/features.txt")
features_names<-read.csv(features_names_file,sep = " ",header = FALSE,stringsAsFactors = FALSE)
features_names<-features_names[,2]# get only names vector
# Get indeces of mean/std features
mean_std_measures_indices<-which(grepl("mean",features_names)|grepl("std",features_names))
# Subset the dataset by the requested measures
x_mean_std<-x[,mean_std_measures_indices]
#---------------------------------------------------------------
#3-Uses descriptive activity names to name the activities in the data set
#---------------------------------------------------------------
#Read activities names
activities_names_file<-paste0(datasetdir,"/activity_labels.txt")
activities_names<-read.csv(activities_names_file,sep = " ",header = FALSE,col.names = c("activity_number","activity_name"))
#Add names of activities to y
y<-merge(y,activities_names,by.x = "V1",by.y = "activity_number")
#Keep only the activitie name
y<-y[[2]]
#---------------------------------------------------------------
#4-Appropriately labels the data set with descriptive variable names
#---------------------------------------------------------------
names(x_mean_std)<-features_names[mean_std_measures_indices]
#---------------------------------------------------------------
#5-From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
#---------------------------------------------------------------
#Load subjects train and test files and merge them into one file
subjects_train_file = paste0(datasetdir,"/train/subject_train.txt")
subjects_test_file = paste0(datasetdir,"/test/subject_test.txt")
subjects_train<-read.csv(subjects_train_file,header = FALSE,col.names = "subjectnumber" )
subjects_test<-read.csv(subjects_test_file,header = FALSE,col.names = "subjectnumber" )
subjects<-rbind(subjects_train,subjects_test)
#add subjects and activities columns to the x dataset to use them for group by
x_tidy<-cbind(y,subjects,x_mean_std)
#Get the average group by subjects and activities
x_tidy<-dplyr::group_by(x_tidy,y,subjectnumber)
x_tidy<-dplyr::summarise_all(x_tidy,mean)
x_tidy<-as.data.frame(x_tidy)
#--------------------------------------------------------------
#Store tidy data table:
out_file_path<-paste0(datasetdir,"/x_tidy.txt")
write.table(x_tidy,file = out_file_path,row.names = FALSE)