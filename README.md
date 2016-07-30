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


