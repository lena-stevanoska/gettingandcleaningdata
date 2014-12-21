
The resulting file was created with:

write.table(finaldata,"finaldata.txt",row.name=FALSE)

#How to review data
To review the data please use the following commands:

data <- read.table("finaldata.txt", header = TRUE) 
View(data)

This two lines of code were taken from the following location https://class.coursera.org/getdata-016/forum/thread?thread_id=50

#How to run the script
To run the script use the following:

source("run_analysis.R")

It will display the finaldata dataset (which is the resulting dataset of all the transformations) in a nice tabulated output.