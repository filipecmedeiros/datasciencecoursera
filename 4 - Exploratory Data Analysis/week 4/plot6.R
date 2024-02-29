source("./Project 2.R")

# Filter by coal combustion
head(SCC)
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehicles_scc <- SCC[vehicles, ]
head(vehicles_scc)

data <- NEI %>% filter(SCC %in% vehicles_scc$SCC & fips %in% c("24510", "06037")) %>% 
    mutate(city = ifelse(fips == "24510", "Baltimore", ifelse(fips == "06037", "LA", NA)))
            
head(data)


#install.packages("ggplot2")
library("ggplot2")

png("plot6.png", width=480, height=480)

ggplot(data, aes(x=factor(year), y=Emissions, fill=city)) +
    geom_bar(aes(fill=year), stat="identity") +
    facet_grid(.~city) + labs(x="Year", y=expression("Emissions")) + 
    labs(title=expression("Vehicle Emissions"))

dev.off()



