# Question 1

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url, destfile = "./2006_housing.csv", method = "curl")
doc_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf"
download.file(doc_url, destfile = "./2006_housing_metadata.pdf", method="curl")

## Reading files
df <- read.csv("2006_housing.csv")
head(df)

agricultureLogical <- df$ACR >= 3 & df$AGS >= 6
which(agricultureLogical) 

# Question 2

jpg_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(jpg_url, destfile = "./photo.jpg", method="curl")

install.packages("jpeg")
library(jpeg)

img <- readJPEG("./photo.jpg", native = TRUE)

quantile(img, probs = c(0.3,0.8))

# Question 3

install.packages("dplyr")
library(dplyr)

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(url, destfile = "./GDP.csv", method = "curl")


## Reading files
gdp <- read.csv("./getdata_data_GDP.csv", skip=4, nrows=231)
head(gdp)
dim(gdp)

## Renaming data set
gdp <- gdp %>% rename(CountryCode = X, Ranking = X.1, Country = X.3,
                      GDP = X.4) %>% select(CountryCode, Ranking, Country,
                                            GDP) %>% filter(complete.cases(.)) %>% mutate(
                                                GDP = as.numeric(gsub(",", "", GDP)),
                                                Ranking = as.numeric(Ranking))

head(gdp)
tail(gdp)
dim(gdp)

gdp[complete.cases(gdp),]

## Reading other file
ed_stats <- read.csv("./getdata_data_EDSTATS_Country.csv")
head(ed_stats)
tail(ed_stats)
dim(ed_stats)

## Merging data
df <- merge(gdp, ed_stats, by="CountryCode")
head(df)
tail(df)
dim(df)


## Sorting
f <- df %>% select (Country, Ranking) %>% arrange(desc(Ranking))
f

# Question 4

df %>% filter(Income.Group == 'High income: OECD') %>% mutate(ranking_mean = mean(Ranking)) %>% select(ranking_mean)

df %>% filter(Income.Group == 'High income: nonOECD') %>% mutate(ranking_mean = mean(Ranking)) %>% select(ranking_mean)


# Question 5

# Calculate quantiles using quantile function
breaks <- quantile(df$Ranking, probs = seq(0, 1, 0.2), na.rm = TRUE)

# Cut the Ranking variable into quantiles
df <- df %>%
    mutate(quantileGDP = cut(Ranking, breaks = breaks, include.lowest = TRUE))

# Filter and count for "Lower middle income" group
result <- df %>%
    filter(Income.Group == "Lower middle income") %>%
    group_by(quantileGDP) %>%
    summarize(N = n())

# View the result
print(result)
