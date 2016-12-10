#read the data
data <- read.table("household_power_consumption.txt", header = T, sep = ';',
na.strings="?", nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')

#change the date format
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

#get a subset of data related to two days in February
data_Feb <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")

datetime <- paste(as.Date(data_Feb$Date), data_Feb$Time)
data_Feb$Datetime <- as.POSIXct(datetime)

#3 plots in one graph
with(data_Feb, {
    plot(Sub_metering_1~Datetime, type="l",
         ylab="Global Active Power (kilowatts)", xlab="")
    lines(Sub_metering_2~Datetime,col='Red')
    lines(Sub_metering_3~Datetime,col='Blue')
})

#copy the graph into the png file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()