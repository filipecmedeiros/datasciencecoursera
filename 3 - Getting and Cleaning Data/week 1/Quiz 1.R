
# Question 1 and 2

## Download files
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url, destfile = "./2006_housing.csv", method = "curl")
doc_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf"
download.file(doc_url, destfile = "./2006_housing_metadata.pdf", method="curl")

## Reading files
df <- read.csv("2006_housing.csv")
head(df)

nrow(df)

## Question 1
missing <- is.na(df$VAL)
df <- df[!missing,]
nrow(df)
nrow(df[df$VAL >= 24,])




## Question 2
df$FES


# Question 3

## Download file
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(url, destfile = "./NGAP.xlsx", method="curl")

## Reading file
## install.packages('xlsx')
library(xlsx)
colIndex <- 7:15
rowIndex <- 18:23
dat <- read.xlsx("NGAP.xlsx", sheetIndex=1, header=TRUE, 
                 colIndex = colIndex, rowIndex = rowIndex)
dat

sum(dat$Zip*dat$Ext,na.rm=T)

# Question 4

## Download file

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(url, destfile = "./baltimore_restaurants.xml", method="curl")

## Reading file
## install.packages('XML')
library(XML)
doc <- xmlTreeParse("baltimore_restaurants.xml", useInternal=TRUE)

rootNode <- xmlRoot(doc)

print(rootNode)

sum(xpathSApply(rootNode, "//zipcode", xmlValue ) == "21231")


# Question 5

## Download file
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(url, destfile = "./2006_microdata_housing.csv", method="curl")

## Read file
## install.packages('data.table')
library(data.table)
DT <- fread("2006_microdata_housing.csv")

## Average by sex
DT[,mean(pwgtp15),by=SEX]






