oldDirPath <- getwd()
library(caTools)
library(Amelia)
library(ggplot2)

set.seed(1)

# Read the data
setwd("E:/OneDrive/Hult/Big Data Analytics/Assignment/Individual Paper/Titanic Data")
rawData <- read.csv("train1.csv", stringsAsFactors = TRUE)

#Explore the data
# Distribution of survived vs not-survived
missmap(rawData, main = "Missing Value: Age", col = c('red', 'black'))

#Distribution of survived vs not-survived
ggplot(rawData, aes(Survived)) + geom_bar(aes(fill=factor(Survived)))+ggtitle("Survived vs Not-Survived")

#Distribution of number of passengers in various classes (class – I, II and III)
ggplot(rawData, aes(Pclass)) + geom_bar(aes(fill=factor(Pclass)))+ggtitle("Passengers in various classes")

# Distribution Male Passengers vs Female Passengers
ggplot(rawData, aes(Sex)) + geom_bar(aes(fill=factor(Sex)))+ggtitle("Count of Female & Male Passengers")

# Histogram of Passenger Age
ggplot(rawData, aes(Age)) + geom_histogram(bins = 20, alpha = 0.5, fill = 'blue')+ggtitle("Passenger Age Histogram")

# Histogram of Passenger Age
ggplot(rawData, aes(SibSp)) + geom_bar(fill = 'blue') +ggtitle("Passengers Sibling / Spouse count")

# Histogram of fare 
ggplot(rawData, aes(Fare)) + geom_histogram(fill = 'blue', color = 'black', alpha = 0.5) +ggtitle("Distrubution of fare (dollars)")









setwd(oldDirPath)