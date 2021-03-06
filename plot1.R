library(readr)
library(dplyr)
library(lubridate)

if (!file.exists("./data")) {
    dir.create("./data")
}
if (!file.exists("./data/household_power_consumption.zip")) {
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url, destfile = "./data/household_power_consumption.zip")
}
if (!file.exists("./data/household_power_consumption.txt")) {
    unzip("./data/household_power_consumption.zip", exdir = "./data")
}

# Load data
data <- read_csv2("./data/household_power_consumption.txt", na = "?")

# Convert data to appropiate types
data$Date <- dmy(data$Date)
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.integer(data$Voltage)
data$Global_intensity <- as.numeric(data$Global_intensity)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

# Filter data
data <- data %>% filter(Date == "2007-02-01" | Date == "2007-02-02")

# Plot data
png("plot1.png", 480, 480)
hist(data$Global_active_power, col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()
