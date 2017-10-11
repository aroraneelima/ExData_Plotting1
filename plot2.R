########################################### 
library(dplyr) 
library(lubridate)
library(lattice)

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

#Create a dataset which is required for Exploratory Analysis
plotdata <- filter(hpower,dmy(Date)>="2007-02-01" & dmy(Date)<="2007-02-02")

#Create Date Time Variable from Date & Time columns
plotdata$DateTime <-dmy_hms(paste(plotdata$Date,plotdata$Time))

# Create a Plot 2
png(file="plot2.png",width = 480, height = 480, units = "px")
with(plotdata, 
     plot(DateTime,
          Global_active_power,
          type="l",
          ylab="Global Active Power (kilowatts)"))

#Close the device
dev.off()
