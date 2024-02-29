#install.packages("dplyr")
library(dplyr)

## Download dataset
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
dataset <- "national_emissions_inventory"
zip_file <- paste("./", dataset, ".zip", sep="")
download.file(url, destfile = zip_file, method = "curl")

## Unzip
unzip(zip_file, exdir="./")

## Read dataset
NEI <- readRDS("./summarySCC_PM25.rds")
head(NEI)

SCC <- readRDS("./Source_Classification_Code.rds")
head(SCC)

## Cleanning and filtering dataset
summary(NEI)
head(NEI)
