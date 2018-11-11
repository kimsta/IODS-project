#Kim Ståhlberg
#09112018
#This file is for week two exercise

#Reading data into memory from a website
learning_2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header = T)

#Inspecting dimensions of data
dim(learning_2014)

# Access the dplyr library
library(dplyr)

# create column 'attitude' by scaling the column "Attitude"
learning_2014$attitude <- learning_2014$Attitude / 10

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(learning_2014, one_of(deep_questions))
learning_2014$deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(learning_2014, one_of(surface_questions))
learning_2014$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(learning_2014, one_of(strategic_questions))
learning_2014$stra <- rowMeans(strategic_columns)

# choose a handful of columns to keep
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")

# select the 'keep_columns' to create a new dataset
learning2014 <- select(learning_2014, one_of(keep_columns))

#Inspect new dataset
dim(learning2014)

#Change clomun names to lowercase and print them out
colnames(learning2014)[2]<- "age"
colnames(learning2014)[7]<- "points"
colnames(learning2014)

#Filter out rows where points < 1 and overwrite data
learning2014 <- filter(learning2014, points > 0)
dim(learning2014)

?write.csv

#Write a .csv file into working directory
write.table(learning2014, file = "learning.csv", col.names = c("gender", "age", "attitude", "deep", "stra", "surf", "points"), sep = ",", row.names = F)

#Test if the file can be raed and used as planned
testi2 <- read.csv("data/learning.csv", sep = ",", header = T)
dim(testi2)
testi2
