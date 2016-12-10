# read the data
data <- read.table("household_power_consumption.txt", header = T, sep = ';',
na.strings="?", nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')

#change the data format
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

#get the subset of the data related to two days in February
data_Feb <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")

datetime <- paste(as.Date(data_Feb$Date), data_Feb$Time)
data_Feb$Datetime <- as.POSIXct(datetime)

#plot
plot(data_Feb$Global_active_power~data_Feb$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab = "")

#copy the plot into a png file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()