
library("dplyr")
library("data.table")

# this script generate Plot 1 of WW1 project
# Before running this script please make sure the initial data set is in your working directory

# read data table
power<-read.table(file="household_power_consumption.txt",sep = ";",header=TRUE, stringsAsFactors=FALSE)
power<-as.data.table(power)

# filter data to the dates 2007-02-01 and 2007-02-02

spower <- filter(power, as.Date(Date, "%d/%m/%Y")>=as.Date("2007-02-01") & as.Date(Date, "%d/%m/%Y")<=as.Date("2007-02-02"))

#fullDate variables added to plot the date/time x axis
spower <- mutate(spower, fullDate = as.POSIXct(strptime(paste(Date,Time),"%d/%m/%Y %H:%M:%S")))
spower <- mutate(spower, Global_active_power  =as.numeric(Global_active_power))
spower <- mutate(spower, Global_reactive_power  =as.numeric(Global_reactive_power))

#Plot 1
png(file="plot1.png", width = 480, height = 480)
hist(spower$Global_active_power, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()

