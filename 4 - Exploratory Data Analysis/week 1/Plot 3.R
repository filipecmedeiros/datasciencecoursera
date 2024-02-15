source("./Project 1.R")

png("plot3.png", width=480, height=480)

# Plot 3
plot(data$DateTime, data$Sub_metering_1, type="l", xlab="", xaxt="n", 
     ylab="Energy sub metering")
lines(data$DateTime, data$Sub_metering_2,col="red")
lines(data$DateTime, data$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), 
       c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), 
       lwd=c(1,1))
axis.POSIXct(1, df$DateTime, format = "%a", at=append(unique(
    as.Date(data$DateTime)), as.Date(max(data$DateTime))+1))
dev.off()
