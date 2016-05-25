rm(list=ls())
library(dplyr)
# Download the file, extract it and read it into a table. To work with dplyr, set it as a tbl_df.
if (!file.exists("hpc.zip")){
  download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile =  "hpc.zip", method = "curl")
}
if (!file.exists("household_power_consumption.txt")) { 
  unzip("hpc.zip")
}

hpc  <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE, na.strings = "?")
hpc <- tbl_df(hpc)

# Subset only for the dates we need.

hpc$Date <- as.Date(as.character(hpc$Date), format = "%d/%m/%Y")

hpc <- subset(hpc, Date >= as.Date("2007/02/01"))
hpc <- subset(hpc, Date <= as.Date("2007/02/02"))
hpc$Date <- as.POSIXct(paste(hpc$Date, hpc$Time), format="%Y-%m-%d %H:%M:%S")

# Run the Plot
with(hpc, plot(Date, c(Sub_metering_1), ylab = "Energy sub metering", xlab = "", type = "l"))
with(hpc, points(Date, Sub_metering_2, col = "Red", type = "l"))
with(hpc, points(Date, Sub_metering_3, col = "Blue", type = "l"))
legend("topright", lty = c(1, 1, 1), col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.8)

# Save the plot as PNG

dev.copy(png, file = "plot3.png")
dev.off()

