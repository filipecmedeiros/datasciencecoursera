source("./Project 1.R")

png("plot1.png", width=480, height=480)

# Plot 1
hist(data$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()
