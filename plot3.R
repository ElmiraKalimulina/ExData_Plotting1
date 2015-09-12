## Getting full data
data_full <- read.csv("./Data/household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y")

## Get subset between specified  dates
data <- subset(data_full, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
# remove temporary dataset with full data
rm(data_full)#remove object with full list

## Converting dates
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

par(mar=c(5,5,5,6)) 

# Plot 3
with(data, {
    plot(Sub_metering_1~Datetime, type="l",
         ylab="Energy sub metering", xlab="")
    lines(Sub_metering_2~Datetime,col='Red')
    lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),xjust=0,cex=0.7)

# Saving to file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()