---
title: "README"
author: "Martin Mason"
date: "28 July 2016"
output: html_document
---
####Important decisions made based on the instructions 
For most of the comments in the code itself should be explain the actual process.

I think the most important points are some more general decisions about the project.

Firstly, I have decided to include ALL columns that mention mean or std, not just the ones 
that are the results of a mean() or std() function, the assignment seems to ask for only the these columns but it was somewhat ambiguous to me and it seemed to me that the best option
in such as situation is to include all the variables as it would be easier for other 
users of the data downstream to deselect, or look away the columns that are not needed, rather than having to extract the additional columns later.

Another decision I made is to present the data as a very broad format, is was also unsure which way to go here. This makes is harder to view the data in RStudio but makes it easier to perform further R based operations on the dataset. I considered the variables as all the instances of mean and std and the cases(rows) the different subjects and activities, I would have preferred to create two separate datasets(one for activities and one for subjects) because they seem like different types of cases to me, but the assignment instructions specified one dataset, I therefore merged both into one dataset.


###How the script works
The script does the following:
1) Loads the required library, which is dplyr
2) Reads the names of the dataset into myNames it also adds an activity column to myNames
3) Reads the X_test, Y_test and activities and merges them into one dataset (mainX)
4) Adds names to the dataset mainX
5) Repeats the steps 3 and 4 for the training set(main/)
6) Merges mainX and mainY
7) Creates two logical vectors containing TRUE if mean or std appear.
8) Manually turn vector indices [1,2] to TRUE to include the subject and activity columns
9) Merges the two logical vectors to one, where TRUE in any of them becomes TRUE in the merged vector(primaryIndex)
10) Using the primaryIndex to select out all relevant columns adding the to the new dataset(mySubset)
11) Altering all columns names to lowercase
12) Adding the type of activity to a string instead of a number coding for activity
13) Grouping columns based on activity
14) Calculating colMeans of these groups and binding them together to tidyActivity
15) Grouping columns based on subjects, calculating colMeans on them and storing in dataset
called tidySubjects
16) Merging tidySubjects and tidyActivity into one set called tidySet
17) Adding names to tidySet







