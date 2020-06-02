data <- read.table("./household_power_consumption.txt", sep = ";", 
                   col.names = c("Date","Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
                   na.strings = "?", 
                   colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), 
                   nrows = 10000, 
                   skip = 62000)
library(dplyr)
library(lubridate)

#turn Date column into Date format
data <- data %>% mutate(Date=as.Date(Date,format="%d/%m/%Y")) 

#filters to the days we want 
data <- data %>% filter(between(Date, as.Date("2007-02-01", format = "%Y-%m-%d"), 
                                as.Date("2007-02-02", format = "%Y-%m-%d")))

#creates a new column, "Instant", selects onlt the necessary columns
data <- data %>% mutate(Instant = ymd_hms(paste(Date,Time))) 

#creates the frame
par(mfrow = c(2,2), mar = c(4,4,2,3))

#plot 1
with(data, plot(Instant, Global_active_power, type = "l", 
                ylab = "Global Active Power (kilowatts)", xlab = "" ))

#plot 2
with(data, plot(Instant, Voltage, type = "l", ylab = "Voltage", xlab = "datetime", col = "black"))

#plot 3
with(data, plot(Instant, Sub_metering_1, type = "l", 
                ylab = "Global Active Power (kilowatts)", 
                xlab = "", 
                col = "black"))
with(data, points(Instant, Sub_metering_2, type = "l", ylab = "", xlab = "", col = "red"))
with(data, points(Instant, Sub_metering_3, type = "l", ylab = "", xlab = "", col = "blue"))
legend("topright", lwd = 2, col = c("black", "red", "blue"),  bty = "n", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#plot 4
with(data, plot(Instant, Global_reactive_power, type = "l", 
                ylab = "Global_reactive_power", xlab = "datetime", col = "black"))

#creates a PNG
dev.copy(png, file = "plot4.png")
dev.off()