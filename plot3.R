
library("dplyr")
library("data.table")

# this script generate Plot 3 of WW1 project
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

#plot 3
png(file="plot3.png", width = 480, height = 480)
with(spower, plot(fullDate,Sub_metering_1,type= "l", col="black",ylab = "Energy sub metering", xlab=""))
with(spower, lines(fullDate,Sub_metering_2,type= "l", col="red"))
with(spower, lines(fullDate,Sub_metering_3,type= "l", col="blue"))

legend("topright", legend = names(spower)[7:9], lty = c(1,1,1), col = c("black","red","blue"))

dev.off()

