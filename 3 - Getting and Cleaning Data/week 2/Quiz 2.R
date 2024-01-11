
# Questions 2 and 3

acs <- read.csv("./getdata_data_ss06pid.csv")

head(acs)
install.packages("sqldf")


library("sqldf")
sqldf("select pwgtp1 from acs where AGEP < 50")

unique(acs$AGEP)

sqldf("select distinct AGEP from acs")

# Question 4

con <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(con)
close(con)

nchar(htmlCode[10])
nchar(htmlCode[20])
nchar(htmlCode[30])
nchar(htmlCode[100])

# Question 5


help(read.fwf)
df <- read.fwf("./getdata_wksst8110.for", skip=4, widths=c(12, 7, 4, 9, 4, 9, 4, 9, 4))
head(df)

sum(df$V4)

# install.packages("readr")
# library(readr)

# df <- read_fwf(
#    file="./getdata_wksst8110.for",   
#    skip=4,
#    fwf_widths(c(12, 7, 4, 9, 4, 9, 4, 9, 4)))

# sum(df$X4)
