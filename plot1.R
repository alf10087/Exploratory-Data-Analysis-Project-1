rm(list=ls())
library(dplyr)

# Download the file, extract it and read it into a table. To work with dplyr, set it as a tbl_df.
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile =  "hpc.zip", method = "curl")
unzip("hpc.zip")

hpc  <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE, na.strings = "?")
hpc <- tbl_df(hpc)

# Subset only for the dates we need.

hpc$Date <- as.Date(as.character(hpc$Date), format = "%d/%m/%Y")
hpc <- subset(hpc, Date >= as.Date("2007/02/01"))
hpc <- subset(hpc, Date <= as.Date("2007/02/02"))

# Run the Plot
with(hpc, hist(Global_active_power, col = "Red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power"))

# Save the plot as PNG

dev.copy(png, file = "plot1.png")
dev.off()
