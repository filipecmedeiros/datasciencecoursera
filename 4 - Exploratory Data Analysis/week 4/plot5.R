source("./Project 2.R")

# Filter by coal combustion
head(SCC)
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehicles_scc <- SCC[vehicles, ]
head(vehicles_scc)

data <- NEI %>% filter(SCC %in% vehicles_scc$SCC & fips == "24510")
head(data)


#install.packages("ggplot2")
library("ggplot2")

png("plot5.png", width=480, height=480)

ggplot(data,aes(factor(year),Emissions)) + geom_bar(stat="identity") +
    labs(x="Year", y=expression("Emissions")) + 
    labs(title=expression("Vehicles Emissions"))

dev.off()
