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
par(mfrow = c(1,1), mar = c(6,2,3,2), oma = c(0,0,0,0))
#Plot 1
hist(data$Global_active_power, 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowats)",
     ylab = "Frequency",
     col = "red")
dev.copy(png, file= "PLOT-1.png", width=480, height=480) # copy plot to png
dev.off()

#Plot 2
plot(data$Global_active_power ~ data$dateTime, 
     type = "l",
     xlab = '',
     ylab = "Global Active Power (kilowats)")
dev.copy(png, file= "PLOT-2.png", width=480, height=480) # copy plot to png
dev.off()

#plot 3

with(data, {
  plot(data$Sub_metering_1 ~ data$dateTime, col = "black", type = "l",
       xlab = " ",
       ylab = "Energy Sub Metering")
  lines(data$Sub_metering_2 ~ data$dateTime, col = "red")
  lines(data$Sub_metering_3 ~ data$dateTime, col = "blue")
  legend("topright", 
         col = c("black", "red", "blue"),
         lwd = c(1,1,1),
         c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})
dev.copy(png, file= "PLOT-3.png", width=480, height=480) # copy plot to png
dev.off()

#Plot 4
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,0,0))

with(data, {
  plot(data$Global_active_power ~ data$dateTime, 
       col = "black", type = "l",
       xlab = " ",
       ylab = "Global Active Power")
  
  plot(data$Voltage ~ data$dateTime,
       xlab = "dateTime",
       col = "black", type = "l",
       ylab = "Voltage(volt)")
  
  plot(data$Sub_metering_1 ~ data$dateTime, col = "black", type = "l",
       xlab = " ",
       ylab = "Energy Sub Metering")
  lines(data$Sub_metering_2 ~ data$dateTime, col = "red")
  lines(data$Sub_metering_3 ~ data$dateTime, col = "blue")
  legend("topright", 
         col = c("black", "red", "blue"),
        lty = 1, lwd = 2, bty = "n", 
         c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(data$Global_reactive_power ~ data$dateTime, 
       col = "black", type = "l",
       xlab = " ",
       ylab = "Global Reactive Power (Kilowatts")
})
dev.copy(png, file= "PLOT-4.png", width=480, height=480) # copy plot to png
dev.off()
