########################################### 
library(dplyr) 
library(lubridate)

# PART 1: DOWNLOAD  & READ DATA 


# download zip file containing data if it hasn't already been downloaded 
dataurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" 
filename <- "exdata_data_household_power_consumption.zip" 


if (!file.exists(filename)) { 
  download.file(dataurl, filename, mode = "wb") 
} 


# unzip zip file containing data if data directory doesn't already exist 
datapath <- "exdata_data_household_power_consumption" 
if (!file.exists(datapath)) { 
  unzip(filename) 
} 
# Read the file
hpower<- read.table("household_power_consumption.txt",sep = ";",na.strings = "?",header = TRUE,stringsAsFactors = FALSE) 

#Create a data which is required for Exploratory Analysis
plotdata <- filter(hpower,dmy(Date)>="2007-02-01" & dmy(Date)<="2007-02-02")

# Create a Plot 1 
png(file="plot1.png",width = 480, height = 480, units = "px")
hist(plotdata$Global_active_power, col="Red" ,xlab = "Global Active Power(kilowatts)",main="Global Active Power")

#Close the device
dev.off()
