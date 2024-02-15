source("./Project 1.R")

png("plot4.png", width=480, height=480)

# Plot 4
par(mfrow=c(2,2))

# Plot 4.1
plot(data$DateTime, data$Global_active_power, type="l", xlab="", xaxt="n", 
     ylab="Global Active Power")
axis.POSIXct(1, df$DateTime, format = "%a", at=append(unique(
    as.Date(data$DateTime)), as.Date(max(data$DateTime))+1))

# Plot 4.2
plot(data$DateTime, data$Voltage, type="l", xlab="datetime", xaxt="n", 
     ylab="Voltage")
axis.POSIXct(1, df$DateTime, format = "%a", at=append(unique(
    as.Date(data$DateTime)), as.Date(max(data$DateTime))+1))

# Plot 4.3
plot(data$DateTime, data$Sub_metering_1, type="l", xlab="", xaxt="n", 
     ylab="Energy sub metering")
lines(data$DateTime, data$Sub_metering_2, col="red")
lines(data$DateTime, data$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), 
       c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "), lty=c(1,1),
       bty="n", cex=.5)
axis.POSIXct(1, df$DateTime, format = "%a", at=append(unique(
    as.Date(data$DateTime)), as.Date(max(data$DateTime))+1))

# Plot 4.4
plot(data$DateTime, data$Global_reactive_power, type="l", xlab="datetime", 
     xaxt="n", ylab="Global_reactive_power")
axis.POSIXct(1, df$DateTime, format = "%a", at=append(unique(
    as.Date(data$DateTime)), as.Date(max(data$DateTime))+1))

dev.off()
