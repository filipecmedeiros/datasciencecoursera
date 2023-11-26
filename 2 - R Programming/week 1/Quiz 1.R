class(x<-4)

class(c(4, TRUE))

x <- c(1,3,5)
y <- c(3,2,10)
rbind(x,y)

x <- list(2, "a", "b", TRUE)
class(x[[1]])


x <- 1:4
y <- 2:3
x+y
class(x+y)

x <- c(3,5,1,10,12,6)
x[x < 6] <- 0


data <- read.csv(file="r programming/hw1_data.csv")
data


data[47, "Ozone"]

bad <- is.na(data[,"Ozone"])
nrow(data[bad,])

mean(data[!bad,"Ozone"])


df <- data[complete.cases(data),]

mean(df[df[, "Ozone"] > 31 & df[, "Temp"] > 90, "Solar.R"])

mean(data[data[,"Month"] == 6, "Temp"])

max(df[df[,"Month"] == 5, "Ozone"])
