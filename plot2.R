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

#filters to the days we want and only the columns that are needed
data <- data %>% filter(between(Date, as.Date("2007-02-01", format = "%Y-%m-%d"), 
                                as.Date("2007-02-02", format = "%Y-%m-%d"))) %>%
        select(Date, Time, Global_active_power)

#creates a new column, "Instant"
data <- data %>% mutate(Instant = ymd_hms(paste(Date,Time)))

#plots the data
with(data, plot(Instant, Global_active_power, type = "l", 
                ylab = "Global Active Power (kilowatts)", xlab = "" ))

#creates a PNG
dev.copy(png, file = "plot2.png")
dev.off()