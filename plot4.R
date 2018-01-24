## add libraries

library(ggplot2)
library(plyr)
library(dplyr)
library(lubridate)
  
  
## check if file exists and unzip the file

fileurl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if (!file.exists('household_power_consumption.txt')){
  download.file(fileurl,destfile='./household_power_consumption.zip', method= "curl")
  unzip("household_power_consumption.zip", exdir = getwd())

}


## load data into table

consumption <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")

print(head(consumption))

consumption$dt <-strptime(paste(consumption$Date, consumption$Time), "%d/%m/%Y %H:%M:%S")
consumption$Date <- as.Date(consumption$Date, "%d/%m/%Y")
valid_range <- subset(consumption, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

png("plot4.png",width=480,height=480,units="px",bg="white")

par(mfrow=c(2,2))

par(mar=c(4,4,4,4))

plot(valid_range$dt, valid_range$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

plot(valid_range$dt, valid_range$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

plot(valid_range$dt, valid_range$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")

points(valid_range$dt, valid_range$Sub_metering_2, type = "l", col = "red")

points(valid_range$dt, valid_range$Sub_metering_3, type = "l", col = "blue")

legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", cex = 0.8)

plot(valid_range$dt, valid_range$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")


dev.off()
