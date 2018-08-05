oldDirPath <- getwd()
library(caTools)
library(Amelia)
library(ggplot2)
library(dplyr)


set.seed(7)

## Function to fix missing age value, equal mean of passenger's age in each class

fillInAge <- function(age, class){
  fillAge <- age
  for(i in 1:length(age)){
    if(is.na(age[i])){
      if(class[i] == 1){
        fillAge[i] <- 37    #Average of fist class passenger is 37
      } else if(class[i] == 2){
        fillAge[i] <- 29    #Average of fist class passenger is 29
      }
      else {
        fillAge[i] <- 24 
      }
    }else {
      fillAge[i] <- age[i]
    }
  } 
  return(fillAge)
}



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


## Fix the missing age value in the rawData

fixed.age <- fillInAge(rawData$Age, rawData$Pclass)
rawData$Age <- fixed.age


# Make Survived, Pclass, Parch, SibSp factor of the dataset
rawData$Survived <- factor(rawData$Survived)
rawData$Pclass <- factor(rawData$Pclass)
rawData$Parch <- factor(rawData$Parch)
rawData$SibSp <- factor(rawData$SibSp)

#Clean the data
usableData <- select(rawData, -PassengerId, -Name, -Ticket, -Cabin)

# Divide the dataset in subsets of train and test
sample <- sample.split(usableData$Survived, SplitRatio = 0.7)
train <- subset(usableData, sample == TRUE)
test <- subset(usableData, sample == FALSE)

#Train the GLM model
model.GLM <- glm(Survived ~., family = binomial(link = 'logit'), data = train)

summary(model.GLM) 

#Predict result for Test dataset
predicted <- predict(model.GLM, test, type  ='response')
predicted <- ifelse(predicted>0.5, 1, 0)

#Calculate Accuracy of the Model
accuracy <- 1 - mean(predicted != test$Survived)
print(paste("Accuracy: ",  toString(accuracy)))

#Set the working directory as original
setwd(oldDirPath)