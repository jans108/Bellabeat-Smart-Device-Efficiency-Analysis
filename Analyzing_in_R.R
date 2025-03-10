activityData <- read.csv("C:/Users/macie/OneDrive/Pulpit/Cousera Courses/Google Data Analyst Course/Capstone_Project/TableCreatedToAnalyze/DailyActivityCleaned.csv", sep = ";")

View(activityData)


head(activityData)

veryActiveCorrelation <- cor(activityData$Calories, activityData$VeryActiveMinutes, method = "pearson")

print(veryActiveCorrelation)

fairlyActiveCorrelation <- cor(activityData$Calories, activityData$FairlyActiveMinutes, method = "pearson")

print(fairlyActiveCorrelation)

lightlyActiveCorrelation <- cor(activityData$Calories, activityData$LightlyActiveMinutes, method = "pearson")

print(lightlyActiveCorrelation)

sedentaryCorrelation <- cor(activityData$Calories, activityData$SedentaryMinutes, method = "pearson")

print(sedentaryCorrelation)