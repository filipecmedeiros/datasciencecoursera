source("./Project 2.R")

# Filter by Baltimore
data <- NEI %>% filter(fips == "24510") %>% group_by(year) %>%
    summarize(emissions_by_year = sum(Emissions))

head(data)

png("plot2.png", width=480, height=480)

barplot(data$emissions_by_year, names = data$year, xlab = "Year", 
        ylab = "Emissions", main = "Emissions by year")

dev.off()
