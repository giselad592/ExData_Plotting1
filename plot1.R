data <- read.table("./household_power_consumption.txt", sep = ";", 
                   col.names = c("Date","Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
                   na.strings = "?", 
                   colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), 
                   nrows = 10000, 
                   skip = 62000)
library(dplyr)

#turn Date column into Date format
data <- data %>% mutate(Date=as.Date(Date,format="%d/%m/%Y")) 

#filters to the days we want
data <- data %>% filter(between(Date, as.Date("2007-02-01", format = "%Y-%m-%d"), 
                                as.Date("2007-02-02", format = "%Y-%m-%d")))

#creates histogram
hist(data$Global_active_power, 
     freq = TRUE, 
     col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)"
)

#creates a PNG
dev.copy(png, file = "plot1.png")
dev.off()