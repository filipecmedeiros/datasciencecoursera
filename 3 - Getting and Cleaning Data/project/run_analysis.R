library("data.table")
library("reshape2")
library("dplyr")


# Download data
if(!file.exists("./data")){dir.create("./data")}
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "./data/getdata_projectfiles_UCI HAR Dataset.zip", method = "curl")
unzip(zipfile = "dataFiles.zip")

# Load Features
activity_labels <- fread(file.path("./data/UCI HAR Dataset/activity_labels.txt"), 
                         col.names = c("classLabels", "activityName"))
features <- fread(file.path("./data/UCI HAR Dataset/features.txt"), 
                  col.names = c("index", "featureNames"))

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.

selected_features <- grep("(mean|std)\\(\\)", features$featureNames)
measurements <- features[selected_features, featureNames]
measurements <- gsub('[()]', '', measurements)

# Load train datasets
train <- fread(file.path("./data/UCI HAR Dataset/train/X_train.txt")
               )[, selected_features, with = FALSE]
setnames(train, colnames(train), measurements)
train_activities <- fread(file.path("./data/UCI HAR Dataset/train/Y_train.txt"), 
                          col.names = c("Activity"))
train_subjects <- fread(file.path("./data/UCI HAR Dataset/train/subject_train.txt"), 
                        col.names = c("SubjectNum"))
train <- cbind(train_subjects, train_activities, train)


# Load test datasets
test <- fread(file.path("./data/UCI HAR Dataset/test/X_test.txt")
              )[, selected_features, with = FALSE]
setnames(test, colnames(test), measurements)
test_activities <- fread(file.path("./data/UCI HAR Dataset/test/Y_test.txt"), 
                         col.names = c("Activity"))
test_subjects <- fread(file.path("./data/UCI HAR Dataset/test/subject_test.txt"),
                       col.names = c("SubjectNum"))
test <- cbind(test_subjects, test_activities, test)

# Merge datasets
df <- bind_rows(train, test)

# Convert classLabels to activityName
df$Activity <- factor(df$Activity, levels = activity_labels$classLabels,
                      labels = activity_labels$activityName)
getwd()
df$SubjectNum <- as.factor(df$SubjectNum)

# Reshape and aggregate
df <- df %>%
    group_by(SubjectNum, Activity) %>%
    summarise(across(.cols = everything(), .fns = mean))

# Write the dataframe to a file
write.table(df, "df.txt", row.name=FALSE)

print(df)

