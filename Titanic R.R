oldDirPath <- getwd()
library(caTools)
library(Amelia)
library(ggplot2)

set.seed(1)

setwd("E:/OneDrive/Hult/Big Data Analytics/Assignment/Individual Paper/Titanic Data")
rawData <- read.csv("train1.csv", stringsAsFactors = TRUE)

missmap(rawData, main = "Missing Value: Age", col = c('red', 'black'))
ggplot(rawData, aes(Survived)) + geom_bar(aes(fill=factor(Survived)))+ggtitle("Survived vs Not-Survived")
ggplot(rawData, aes(Pclass)) + geom_bar(aes(fill=factor(Pclass)))+ggtitle("Passengers in various classes")









setwd(oldDirPath)