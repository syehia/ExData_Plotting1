
library("dplyr")
library("data.table")

# this script generate Plot 4 of WW1 project
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



#plot 4

png(file="plot4.png", width = 480, height = 480)

par(mfrow = c(2,2))

#Plot top left
with(spower, plot(fullDate,Global_active_power,type= "l", xlab = "", ylab = "Global Active Power"))

#plot top right
with(spower, plot(fullDate,Voltage,type= "l", xlab = "datetime", ylab = "Voltage"))

#plot bottom left
with(spower, plot(fullDate,Sub_metering_1,type= "l", col="black",ylab = "Energy sub metering", xlab=""))
with(spower, lines(fullDate,Sub_metering_2,type= "l", col="red"))
with(spower, lines(fullDate,Sub_metering_3,type= "l", col="blue"))

legend("topright", legend = names(spower)[7:9], lty = c(1,1,1), col = c("black","red","blue"), bty="n")

#plot bottom right
with(spower, plot(fullDate,Global_reactive_power,type= "l", xlab = "datetime"))

dev.off()