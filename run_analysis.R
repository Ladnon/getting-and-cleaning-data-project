####loading required libraries
library(dplyr)

#### Creating the "test" dataset
        
        ####Creating the names for the "test" dataframe
myNames <- read.table("/Users/Martin/Desktop/R Programming Assignments/codeQuest/UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)

        ####Adding the Activity column(y_test.txt) name and selecting only the row of myNames containing the names, eliminating the index column

myNames <- c("subject","activity", myNames[,2])

        ####Reading and merging the X_test.txt and y_test.txt file

Xset <- read.table("/Users/Martin/Desktop/R Programming Assignments/codeQuest/UCI HAR Dataset/test/X_test.txt", stringsAsFactors = FALSE)
Yset <- read.table("/Users/Martin/Desktop/R Programming Assignments/codeQuest/UCI HAR Dataset/test/y_test.txt", stringsAsFactors = FALSE)
subjectSet <- read.table("/Users/Martin/Desktop/R Programming Assignments/codeQuest/UCI HAR Dataset/test/subject_test.txt", stringsAsFactors = FALSE)        
        ####Merging the two files(of the "test" folder) into one dataset and adding names.

mainX <- cbind(subjectSet,Yset,Xset)
names(mainX) <- myNames

####Creating the names for the "train" dataframe

        ####Reading and merging the X_train.txt and y_train.txt file

Xset <- read.table("/Users/Martin/Desktop/R Programming Assignments/codeQuest/UCI HAR Dataset/train/X_train.txt", stringsAsFactors = FALSE)
Yset <- read.table("/Users/Martin/Desktop/R Programming Assignments/codeQuest/UCI HAR Dataset/train/y_train.txt", stringsAsFactors = FALSE)
subjectSet <- read.table("/Users/Martin/Desktop/R Programming Assignments/codeQuest/UCI HAR Dataset/train/subject_train.txt", stringsAsFactors = FALSE)        

####Merging the two files(of the "train" folder) into one dataset and adding names.

mainY <- cbind(subjectSet,Yset, Xset)
names(mainY) <- myNames

####Merging "test" and "train" to one dataset
completeSet <- rbind(mainX, mainY)

####Creating two indices, with to indicate columns containing "[Mm]ean" or "[St]td" and activity
        ####NOTE: I have chosen to include ALL the means here, including the occurrences
        ####within other columns than the typical mean() columns. The wording in the 
        ####assignment is ambiguous in my understanding, I have thereore chosen to include
        ####rather than passing grepl the "mean()"/"std()" with the (fixed argument as true) argument to select only the more typical
        ####mean column names.
primaryIndex <- grepl("[Mm]ean()", names(completeSet))
secondaryIdex <- grepl("[Ss]td()", names(completeSet))
####Assigning index 1 & 2 as true to includ subject and activitiy columns
primaryIndex[1] <- TRUE
primaryIndex[2] <- TRUE
####Merging the three indices to one index with all TRUE values
for(i in 1:length(primaryIndex)){
        if(secondaryIdex[i] == TRUE){
                primaryIndex[i] <- TRUE
        }
}

####Selecting the subset of completeSet containing "mean" or "std"
meanSubset <- completeSet[,primaryIndex]



####Tidying column names
        ####All column names to lower case
newNames <- names(meanSubset)
newNames <- tolower(newNames)
        ####Substituting -mean with mean and -std with standarddeviation, also
        ####removing parentheses
newNames <- gsub('-mean', 'mean', newNames)
newNames <- gsub('-std', 'standarddeviation',newNames)
newNames <- gsub('[-()]', '', newNames)


        ####Adding the tidied column names to data frame
names(meanSubset) <- newNames

        ####Adding Type of activity
for(i in 1:nrow(meanSubset)){
        if(as.numeric(meanSubset$activity[i]) == "1"){
                meanSubset$activity[i] <- "walking"
        }
        if((meanSubset$activity[i] == "2") == TRUE){
                meanSubset$activity[i] <- "walking_upstairs"
        }
        if((meanSubset$activity[i] == "3") == TRUE){
                meanSubset$activity[i] <- "walking_downstairs"
        }
        if((meanSubset$activity[i] == "4") == TRUE){
                meanSubset$activity[i] <- "sitting"
        }
        if((meanSubset$activity[i] == "5") == TRUE){
                meanSubset$activity[i] <- "standing"
        }
        if((meanSubset$activity[i] == "6") == TRUE){
                meanSubset$activity[i] <- "laying"
        }
}
####Creating vector for each condition(walking, sitting, ect.) This is done by filtering 
####each activity to a new dataframe, removing the first two(character) columns, 
####calculating the means of each.

dplyrVersion <- tbl_df(meanSubset)
standing <- filter(dplyrVersion, activity == "standing")
standing <- standing[,3:ncol(standing)]
standing <- colMeans(standing, na.rm = TRUE)

sitting <- filter(dplyrVersion, activity == "sitting")
sitting <- sitting[,3:ncol(sitting)]
sitting <- colMeans(sitting,na.rm = TRUE)

laying <- filter(dplyrVersion, activity == "laying")
laying <- laying[,3:ncol(laying)]
laying <- colMeans(laying,na.rm = TRUE)

walking <- filter(dplyrVersion, activity == "walking")
walking <- walking[,3:ncol(walking)]
walking <- colMeans(walking,na.rm = TRUE)

walking_downstairs <- filter(dplyrVersion, activity == "walking_downstairs")
walking_downstairs <- walking_downstairs[,3:ncol(walking_downstairs)]
walking_downstairs <- colMeans(walking_downstairs,na.rm = TRUE)

walking_upstairs <- filter(dplyrVersion, activity == "walking_upstairs")
walking_upstairs <- walking_upstairs[,3:ncol(walking_upstairs)]
walking_upstairs <- colMeans(walking_upstairs,na.rm = TRUE)

####Merging the mean values of each of the activities together and adding a column with
###the activity specified.

tidyActivity <- rbind(standing, sitting, laying, walking, walking_downstairs, walking_upstairs)
activity <- c("standing","sitting", "laying", "walking", "walking_downstairs", "walking_upstairs")
tidyActivity <- as.data.frame(tidyActivity)
tidyActivity <- cbind(activity, tidyActivity)
####Converting the activity column from factor to character string, since I can't see
####factors being helpful in this context.
tidyActivity$activity <- as.character(tidyActivity$activity)

####Adding names to tidyActivity and tidySubjects
tidyNames <- newNames[2:length(newNames)]
names(tidyActivity) <- tidyNames

####Creating a separate dataset organised based on subjects
tidySubjects <- data.frame()
        ####Extracting, all the rows containing the relevant subject
        ####number and merging them together in one 'tidySubject' set
for(i in 1:30){
        subject <- filter(dplyrVersion, subject == (i))
        subject <- colMeans(subject[,3:88],na.rm = TRUE)
        tidySubjects <- rbind(tidySubjects, subject)
}

        ####Adding a row specifying the subject in for each row
subjectIndex <- 1:30
tidySubjects <- cbind(subjectIndex, tidySubjects)
        ####Adding names to the tidySubjects dataset.
####Merging to one tidydataset called 'tidySet'
tidySet <- rbind(tidySubjects,tidyActivity)

####Adding names to tidySet
tidyNames[1] <- "activity/subjects"
names(tidySet) <- tidyNames

print("This script has now produced two dataset, one called 'meanSubset' 
which is based on the original data set selected on the basis of columns containing 
the words 'mean' and 'std', the other one is called 'tidySet', this in all of the
mean values based on subjects and activities.")
