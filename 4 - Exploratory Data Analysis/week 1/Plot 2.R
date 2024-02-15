source("./Project 1.R")

png("plot2.png", width=480, height=480)

# Plot 2
plot(x=data$DateTime, y=data$Global_active_power, type="l", xlab="", xaxt="n",
     ylab="Global Active Power (kilowatts)")
axis.POSIXct(1, df$DateTime, format = "%a", at=append(unique(
    as.Date(data$DateTime)), as.Date(max(data$DateTime))+1))
dev.off()
      