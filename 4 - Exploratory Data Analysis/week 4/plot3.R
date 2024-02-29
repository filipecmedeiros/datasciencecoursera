source("./Project 2.R")

# Filter by Baltimore
data <- NEI %>% filter(fips == "24510")

head(data)


#install.packages("ggplot2")
library("ggplot2")

png("plot3.png", width=480, height=480)

ggplot(data,aes(factor(year),Emissions,fill=type)) +
    geom_bar(stat="identity") + guides(fill=FALSE) + facet_grid(~type) + 
    labs(x="Year", y=expression("Emissions")) + 
    labs(title=expression("Emissions in Baltimore by Source Type"))

dev.off()
