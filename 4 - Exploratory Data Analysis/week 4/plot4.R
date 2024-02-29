source("./Project 2.R")

# Filter by coal combustion
head(SCC)
combustion <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coal <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE)

combustion_coal <- SCC[combustion & coal, ]
head(combustion_coal)

data <- NEI %>% filter(SCC %in% combustion_coal$SCC)
head(data)


#install.packages("ggplot2")
library("ggplot2")

png("plot4.png", width=480, height=480)

ggplot(data,aes(x = factor(year),y = Emissions)) + geom_bar(stat="identity") +
    labs(x="year", y=expression("Emissions")) + 
    labs(title=expression("Coal Combustion Emissions by year"))

dev.off()



