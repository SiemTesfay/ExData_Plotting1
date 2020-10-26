#Plot 1
hist(data$Global_active_power, 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowats)",
     ylab = "Frequency",
     col = "red")
dev.copy(png, file= "PLOT-1.png", width=480, height=480) # copy plot to png
dev.off()
