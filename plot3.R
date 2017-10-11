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

#plotdata <-mutate( plotdata ,Day=as.character(wday(dmy(Date), label = TRUE)))

# Create a Plot 3
png(file="plot3.png",width = 480, height = 480, units = "px")

with(plotdata, plot(DateTime,Sub_metering_1, type="l",ylab="Energy Submetering",xlab = ""))
with(plotdata, lines(DateTime,Sub_metering_2,type="l", col="Red"))
with(plotdata, lines(DateTime,Sub_metering_3,type="l", col="Blue"))
legend("topright", lty =1,col=c("Black","Red","Blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#Close the device
dev.off()
