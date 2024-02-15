#install.packages("dplyr")
library(dplyr)


## Download dataset
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dataset <- "household_power_consumption"
zip_file <- paste("./", dataset, ".zip", sep="")
download.file(url, destfile = zip_file, method = "curl")

## Unzip
unzip(zip_file, exdir="./")
file_name <- paste(dataset, ".txt", sep="")


## Read dataset
df <- read.csv(file_name, sep=";", header=TRUE, na.strings="?")
dim(df)
summary(df)

## Cleanning and filtering dataset
df$DateTime <- paste(df$Date, df$Time)
df$DateTime <- strptime(df$DateTime, "%d/%m/%Y %H:%M:%S")
data <- df %>% select(-c("Date", "Time")) %>% filter(DateTime >= strptime(
        "2007/02/01 00:00:00", "%Y/%m/%d %H:%M:%S") & DateTime < strptime(
        "2007/02/03 00:00:00", "%Y/%m/%d %H:%M:%S"))

summary(data)
head(data)


# Plot 1
#hist(data[, "Global_active_power"], main="Global Active Power", 
#     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
