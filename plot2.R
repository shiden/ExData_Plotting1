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

png("plot2.png",width=480,height=480,units="px",bg="white")



plot(valid_range$dt, valid_range$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

dev.off()

