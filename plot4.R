# read data
data <- read.table("household_power_consumption.txt", header = T, sep = ';',
na.strings="?", nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')

#change the date format
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

#get a subset of the data related to two days in February
data_Feb <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")

datetime <- paste(as.Date(data_Feb$Date), data_Feb$Time)
data_Feb$Datetime <- as.POSIXct(datetime)

#set up four plots in the same graph 
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

plot(data_Feb$Global_active_power~data_Feb$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab = "")

plot(data_Feb$Voltage~data_Feb$Datetime, type="l",
     ylab="Voltage(volt)", xlab = "")

with(data_Feb, {
    plot(Sub_metering_1~Datetime, type="l",
         ylab="Global Active Power (kilowatts)", xlab="")
    lines(Sub_metering_2~Datetime,col='Red')
    lines(Sub_metering_3~Datetime,col='Blue')
})

legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
        legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(data_Feb$Global_reactive_power~data_Feb$Datetime, type="l", 
ylab="Global Rective Power (kilowatts)",xlab="")

#copy the graph into png file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()