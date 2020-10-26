#1. DOwnloading data 
rawDataDir <- "/Users/Falcon/Desktop/Coursera/Explanatory Data Analysis"
rawDataUrl <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
rawDataFilename <- "rawData.zip"
rawDataDFn <- paste(rawDataDir, "/", "rawData.zip", sep = "")
dataDir <- "/Users/Falcon/Desktop/Coursera/Explanatory Data Analysis/data"

#Creating direcory and unziping file
if (!file.exists(rawDataDir)) {
  dir.create(rawDataDir)
  download.file(url = rawDataUrl, destfile = rawDataDFn)
}
if (!file.exists(dataDir)) {
  dir.create(dataDir)
  unzip(zipfile = rawDataDFn, exdir = dataDir)
}
#Readin the data
data <- read.table("/Users/Falcon/Desktop/Coursera/Explanatory Data Analysis/data/household_power_consumption.txt"
                           , sep =";", dec = ".", header = T, na.strings = "?")
# Formating date to Date type
class(data$Date) #is factor at first
data$Date <- as.Date(data$Date, "%d/%m/%Y")

## Subsetting data set from Feb. 1, 2007 to Feb. 2, 2007
data <- subset(data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
dim(data) #checking rows

## Removing NA
data <- data[complete.cases(data),]
dim(data)

# combining data and time column
dateTime <- paste(data$Date, data$Time)

#Naming the vector
dateTime <- setNames(dateTime, "DateTime")

## Remove Date and Time column
data <- data[ ,!(names(data) %in% c("Date","Time"))]

## Add DateTime column
data <- cbind(dateTime, data)

## Format dateTime Column
data$dateTime <- as.POSIXct(dateTime)
head(data)

#Plot 2
plot(data$Global_active_power ~ data$dateTime, 
     type = "l",
     xlab = '',
     ylab = "Global Active Power (kilowats)")
dev.copy(png, file= "PLOT-2.png", width=480, height=480) # copy plot to png
dev.off()
