CREATE DATABASE FitBitDevicesData;

USE FitBitDevicesData;

-- Trying parse data into correct format, and find data in incorrect format

UPDATE dailyActivity_merged 
SET ActivityDate = CONVERT(nvarchar(50), TRY_CAST(ActivityDate AS date), 111)
WHERE ISDATE(ActivityDate) = 1;

SELECT ActivityDate
FROM dailyActivity_merged
WHERE TRY_CAST(ActivityDate AS date) IS NULL;

ALTER TABLE dailyActivity_merged
ALTER COLUMN ActivityDate date NOT NULL;

SELECT TotalSteps
FROM dailyActivity_merged
WHERE TRY_CAST(TotalSteps AS int) IS NULL;

ALTER TABLE dailyActivity_merged
ALTER COLUMN TotalSteps int NOT NULL;

SELECT TotalDistance
FROM dailyActivity_merged
WHERE TRY_CAST(TotalDistance AS float) IS NULL;

ALTER TABLE dailyActivity_merged
ALTER COLUMN TotalDistance float NOT NULL;

SELECT TrackerDistance
FROM dailyActivity_merged
WHERE TRY_CAST(TrackerDistance AS float) IS NULL;

ALTER TABLE dailyActivity_merged
ALTER COLUMN TrackerDistance float NOT NULL;

SELECT LoggedActivitiesDistance
FROM dailyActivity_merged
WHERE TRY_CAST(LoggedActivitiesDistance AS float) IS NULL;

ALTER TABLE dailyActivity_merged
ALTER COLUMN LoggedActivitiesDistance float NOT NULL;

SELECT VeryActiveDistance
FROM dailyActivity_merged
WHERE TRY_CAST(VeryActiveDistance AS float) IS NULL;

ALTER TABLE dailyActivity_merged
ALTER COLUMN VeryActiveDistance float NOT NULL;

SELECT ModeratelyActiveDistance
FROM dailyActivity_merged
WHERE TRY_CAST(ModeratelyActiveDistance AS float) IS NULL;

ALTER TABLE dailyActivity_merged
ALTER COLUMN ModeratelyActiveDistance float NOT NULL;

SELECT LightActiveDistance
FROM dailyActivity_merged
WHERE TRY_CAST(LightActiveDistance AS float) IS NULL;

ALTER TABLE dailyActivity_merged
ALTER COLUMN LightActiveDistance float NOT NULL;

SELECT SedentaryActiveDistance
FROM dailyActivity_merged
WHERE TRY_CAST(SedentaryActiveDistance AS float) IS NULL;

ALTER TABLE dailyActivity_merged
ALTER COLUMN SedentaryActiveDistance float NOT NULL;

SELECT VeryActiveMinutes
FROM dailyActivity_merged
WHERE TRY_CAST(VeryActiveMinutes AS int) IS NULL;

ALTER TABLE dailyActivity_merged
ALTER COLUMN VeryActiveMinutes int NOT NULL;

SELECT FairlyActiveMinutes
FROM dailyActivity_merged
WHERE TRY_CAST(FairlyActiveMinutes AS int) IS NULL;

ALTER TABLE dailyActivity_merged
ALTER COLUMN FairlyActiveMinutes int NOT NULL;

SELECT LightlyActiveMinutes
FROM dailyActivity_merged
WHERE TRY_CAST(LightlyActiveMinutes AS int) IS NULL;

ALTER TABLE dailyActivity_merged
ALTER COLUMN LightlyActiveMinutes int NOT NULL;

SELECT SedentaryMinutes
FROM dailyActivity_merged
WHERE TRY_CAST(SedentaryMinutes AS int) IS NULL;

ALTER TABLE dailyActivity_merged
ALTER COLUMN SedentaryMinutes int NOT NULL;

SELECT Calories
FROM dailyActivity_merged
WHERE TRY_CAST(Calories AS int) IS NULL;


ALTER TABLE dailyActivity_merged
ALTER COLUMN Calories int NOT NULL;

-- Searching for and deleting nulls 

SELECT *
FROM dailyActivity_merged
WHERE Id IS NULL 
	OR ActivityDate IS NULL
	OR TotalSteps IS NULL
	OR TotalDistance IS NULL
	OR TrackerDistance IS NULL
	OR LoggedActivitiesDistance IS NULL
	OR VeryActiveDistance IS NULL
	OR ModeratelyActiveDistance IS NULL
	OR LightActiveDistance IS NULL
	OR SedentaryActiveDistance IS NULL
	OR VeryActiveDistance IS NULL
	OR FairlyActiveMinutes IS NULL
	OR LightlyActiveMinutes IS NULL
	OR SedentaryMinutes IS NULL
	OR Calories IS NULL

-- Searching for outliers 

SELECT * 
FROM dailyActivity_merged
WHERE TotalSteps = 0;

-- I assumed that people who didn't do any step during the day are in special situation as they didn't wear device for whole day for example
-- so i decided to delete this records as outliers

DELETE FROM dailyActivity_merged
WHERE TotalSteps = 0;

SELECT *
FROM dailyActivity_merged
WHERE VeryActiveMinutes + FairlyActiveMinutes + LightlyActiveMinutes + SedentaryMinutes > 1440

SELECT MIN(ActivityDate), MAX(ActivityDate)
FROM dailyActivity_merged

SELECT MIN(TotalDistance) AS TotalDistanceMin, MAX(TotalDistance) AS TotalDistanceMax, MIN(TrackerDistance) AS TrackerDistanceMax, MAX(TrackerDistance) AS TrackerDistanceMax,
	MIN(LoggedActivitiesDistance) AS LoggedActivitiesDistanceMin, MAX(LoggedActivitiesDistance) AS LoggedActivitiesDistanceMax, MIN(VeryActiveDistance) AS VeryActiveDistanceMin, MAX(VeryActiveDistance) AS VeryActiveDistanceMax,
	MIN(ModeratelyActiveDistance) AS ModeratelyActiveDistanceMin, MAX(ModeratelyActiveDistance) AS ModeratelyActiveDistanceMax, MIN(LightActiveDistance) AS LightActiveDistanceMin, MAX(LightActiveDistance) AS LightActiveDistanceMax,
	MIN(SedentaryActiveDistance) AS SedentaryActiveDistanceMin, MAX(SedentaryActiveDistance) AS SedentaryActiveDistanceMax, MIN(VeryActiveMinutes) AS VeryActiveMinutesMin, MAX(VeryActiveMinutes) AS VeryActiveMinutesMax,
	MIN(FairlyActiveMinutes) AS FairlyActiveMinutesMin, MAX(FairlyActiveMinutes) AS FairlyActiveMinutesMax, MIN(LightlyActiveMinutes) AS LightlyActiveMinutesMin, MAX(LightlyActiveMinutes) AS LightlyActiveMinutesMax,
	MIN(SedentaryMinutes) AS SedentaryMinutesMin, MAX(SedentaryMinutes) AS SedentaryMinutesMax, MIN(Calories) AS CaloriesMin, MAX(Calories) AS CaloriesMax
FROM dailyActivity_merged

SELECT * 
FROM dailyActivity_merged
WHERE Calories = 52;

DELETE FROM dailyActivity_merged
WHERE Calories = 52;

SELECT * 
FROM dailyActivity_merged
WHERE Calories = 257;

DELETE FROM dailyActivity_merged
WHERE Calories = 257;

SELECT * 
FROM dailyActivity_merged
ORDER BY Calories

DELETE FROM dailyActivity_merged
WHERE Calories = 403;

SELECT * 
FROM dailyActivity_merged
ORDER BY TotalSteps


DELETE FROM dailyActivity_merged
WHERE TotalSteps <= 100;

-- Adding second table to clean data within it

SELECT * 
FROM sleepDay_merged

-- Formatting data type to have one consistent date type

UPDATE sleepDay_merged 
SET SleepDay = CONVERT(nvarchar(50), TRY_CAST(SleepDay AS date), 111)
WHERE ISDATE(SleepDay) = 1;

SELECT SleepDay
FROM sleepDay_merged
WHERE TRY_CAST(SleepDay AS date) IS NULL;

ALTER TABLE sleepDay_merged
ALTER COLUMN SleepDay date NOT NULL;

SELECT d.Id, ActivityDate, TotalSteps, Calories, TotalMinutesAsleep, TotalTimeInBed
FROM dailyActivity_merged AS d
JOIN sleepDay_merged AS s
	ON d.Id = s.Id
	AND d.ActivityDate = s.SleepDay

-- Analyzing correlation between users average calories burnt and average total steps

SELECT Id, AVG(TotalSteps) AS AverageTotalSteps, AVG(Calories) AS AverageCalories
FROM dailyActivity_merged
GROUP BY Id
ORDER BY AverageTotalSteps DESC

-- Analyzing correlation between users average calories burnt and average total minutes asleep

SELECT d.Id, AVG(TotalTimeInBed) AS AverageTotalTimeInBed, AVG(Calories) AS AverageCalories
FROM dailyActivity_merged AS d
JOIN sleepDay_merged AS s
	ON d.Id = s.Id
	AND d.ActivityDate = s.SleepDay
GROUP BY d.Id
ORDER BY AverageTotalTimeInBed DESC

-- Saving cleaned table for trends analyzis 

SELECT Id, ActivityDate, VeryActiveMinutes, FairlyActiveMinutes, LightlyActiveMinutes, SedentaryMinutes, Calories
FROM dailyActivity_merged