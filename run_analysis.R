run_analysis <- function() {
    ## read train and test data sets  
    X.train <- read.table("Data/train/X_train.txt") 
    X.test <- read.table("Data/test/X_test.txt") 
    
    ## read the features list to use for 
    ## descriptive column naming of the data sets  
    features <- read.table("Data/features.txt")
    feature.name <- features[,2] 
    
    ## clean up the 'names' list a bit
    ## trim; replace "-" by "." 
    ## I use dots in variable names following Google style guide 
    ## rather than Coursera recommendation. 
    ## https://google-styleguide.googlecode.com/svn/trunk/Rguide.xml 
    library(stringr) 
    feature.name <- str_trim(feature.name) 
    feature.name <- gsub("-", ".", feature.name)
    
    ## apply to column names of the data sets 
    names(X.train) <- feature.name
    names(X.test) <- feature.name 
    
    ## read the activity lists as well as the label list 
    y.train <- read.table("Data/train/y_train.txt") 
    y.test <- read.table("Data/test/y_test.txt") 
    activity.label <- read.table("Data/activity_labels.txt")
    
    ## add the labels to the activity lists 
    library(plyr) 
    y.train <- join(y.train, activity.label, by = "V1")
    y.test <- join(y.test, activity.label, by = "V1") 
    
    ## label the columns meaningfully 
    label <- c("activity.number", "activity.name")
    names(y.train) <- label 
    names(y.test) <- label 
    
    ## read the subject lists; label column descriptively  
    subject.train <- read.table("Data/train/subject_train.txt") 
    subject.test <- read.table("Data/test/subject_test.txt")
    names(subject.train) <- "subject" 
    names(subject.test) <- "subject" 
    
    ## merge the activity lists and the subject lists 
    ## to the main data sets 
    X.train <- cbind(subject.train, y.train, X.train)
    X.test <- cbind(subject.test, y.test, X.test) 
    
    ## merge train and test data sets 
    data <- rbind(X.train, X.test) 
    
    ## Extract only the measurements on the mean and 
    ## standard deviation for each measurement
    ## retain first 3 columns; they have data on subject and activity 
    column.name <- c(names(data)[1:3], names(data)[grep("mean()|std()", names(data))])  
    select.data <- data[, column.name] 
    
    ## aggregate means for each subject <--> activty combination (180 = 30 subjects * 6 activities)
    col.name <- names(select.data)[4:82] 
    tidy.data <- aggregate(select.data[col.name], 
                             by = select.data[c("subject", "activity.name")], 
                             FUN = mean) 
    write.table(tidy.data, "tidy_data.txt", sep = ",")
    
}