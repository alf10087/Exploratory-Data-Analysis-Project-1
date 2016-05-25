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
with(hpc, plot(Date, Global_active_power, ylab = "Global Active Power (kilowatts)", xlab = "", type = "l"))

# Save the plot as PNG

dev.copy(png, file = "plot2.png")
dev.off()

