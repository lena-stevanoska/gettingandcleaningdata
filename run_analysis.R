#1.

xtrain<-read.table(".\\UCI HAR Dataset\\train\\X_train.txt")
ytrain<-read.table(".\\UCI HAR Dataset\\train\\Y_train.txt")
subjecttrain<-read.table(".\\UCI HAR Dataset\\train\\subject_train.txt")

colnames(subjecttrain)<-"Subject"
colnames(ytrain)<-"Act_code"

trainset<-cbind(subjecttrain,ytrain,xtrain)


xtest<-read.table(".\\UCI HAR Dataset\\test\\X_test.txt")
ytest<-read.table(".\\UCI HAR Dataset\\test\\Y_test.txt")
subjecttest<-read.table(".\\UCI HAR Dataset\\test\\subject_test.txt")

colnames(subjecttest)<-"Subject"
colnames(ytest)<-"Act_code"

testset<-cbind(subjecttest,ytest,xtest)

alltogether<-rbind(trainset,testset)

#2. Process the features to find only the one that are for mean and std

features<-read.table(".\\UCI HAR Dataset\\features.txt",stringsAsFactors=FALSE)

library(dplyr)
library(tidyr)
#Separate only the variables that contain mean() and std()
onlymeanstdfeatures<-filter(features,grepl("mean()|std()",V2))
#Remove the mean Frequency variables
onlymeanstdfeatures<-filter(onlymeanstdfeatures,!grepl("meanFreq()",V2))
#Get the codes for the features
codefeatures<-select(onlymeanstdfeatures,V1)
#Add the "V" in front to match the column names in the dataset
codename<-mutate(codefeatures,paste("V",V1,sep="",concate=""))
#Transform it in a vector that contains the column names for the mean() and std() features
codenamefeat<-codename[,2]
#Then make it in a comma separated strings to be used for extracting the columns from the complete dataset
searchfeatures<-dput(as.character(codenamefeat))
#Add the Subject and Act_code columns
searchfeatures<-c("Subject","Act_code",searchfeatures)
#Use it on the full dataset to get only the columns that are for mean() and std()
meanstddata<-alltogether[,colnames(alltogether) %in% searchfeatures]

#3. Transform the Activity codes in the Activity names, using the activity_labels.txt

require(sqldf)
activities<-read.table(".\\UCI HAR Dataset\\activity_labels.txt")
#Create a vector with the Activity labels using SQL to match the code values
acttry<-sqldf("select activities.V2 from meanstddata,activities where activities.V1=meanstddata.Act_code")
#Name the column descriptevly
colnames(acttry)<-"Activity"
#Add the column to the main dataset
meanstddata<-cbind(acttry,meanstddata)
#Remove the Act_code column and put the Subject column first
meanstddata<-select(meanstddata,Subject,Activity,V1:V543)


#4. Change the Labels of the dataset to descriptive names using the features.txt 

featurenames<-select(onlymeanstdfeatures,V2)
#Remove the special characters
fixednames<-gsub("[][!#$%()*,.:;<=>@^_`|~.{}-]", ".",featurenames$V2)
#Remove the doubling of the Body string in the name
fixednames<-sub('BodyBody',"Body",fixednames)
#apply the new column names
colnames(meanstddata)<-c("Subject","Activity",fixednames)

#5 Create a tody data that contains the mean of all the variables for a specific Subject and Activity

library(reshape2)
#Identifies the Subject and Activity columns as ID to group the data by them
molten = melt(meanstddata, id = c("Subject","Activity"), na.rm = TRUE)
#Calculates the mean on all other variables, group by Subject and Activity
finaldata<-dcast(molten, formula = Subject + Activity ~ variable, mean)

print("The tidy data is stored in a dataset named finaldata.")

View(finaldata)
