rankhospital <- function(state, outcome, num) {
    # Read outcome data
    df <- read.csv("data/outcome-of-care-measures.csv", colClasses = "character")
    
    # Check that state and outcome are valid
    if (!(state %in% unique(df$State))){
        stop("invalid state")
    }
    if(!(outcome %in% c("heart attack", "heart failure", "pneumonia"))){
        stop("invalid outcome")
    }
    
    # Subset the data for the given state and outcome
    subset_data <- df[df$State == state, ]
    
    # Extract the column with mortality rates
    mortality_col <- paste("Hospital.30.Day.Death..Mortality..Rates.from.",
                           sub(" ", ".",tools::toTitleCase(outcome)), sep = "")
    
    
    # Use suppressWarnings to ignore NAs introduced by coercion
    suppressWarnings({
        ## Convert mortality rates to numeric
        subset_data[[mortality_col]] <- as.numeric(subset_data[[mortality_col]])
    })
    
    # Remove NAs
    subset_data <- subset_data[complete.cases(subset_data[, c("State", "Hospital.Name", mortality_col)]),]
    
    # Sort hospitals based on mortality rates and hospital's name
    sorted_data <- subset_data[order(subset_data[[mortality_col]],
                                     subset_data[["Hospital.Name"]]), ]
    
    # Rank hospitals
    sorted_data["Rank"] <- rank(sorted_data[mortality_col], ties.method= "first")
    
    # Set rank as index
    rownames(sorted_data) <- sorted_data$Rank
    
    if (is.numeric(num)) {
        # Get the name of the hospital with the lowest mortality rate
        hospital_name <- sorted_data$Hospital.Name[num]
    }
    else if (tolower(num) == "best") {
        # Get the hospital with the lowest mortality rate
        hospital_name <- sorted_data$Hospital.Name[1]
    } else if (tolower(num) == "worst") {
        # Get the hospital with the highest mortality rate
        hospital_name <- hospital_name <- sorted_data$Hospital.Name[max(sorted_data$Rank)]
    }
    
    #print(tail(sorted_data[,c("State", "Hospital.Name", mortality_col, "Rank")]))
    return(hospital_name)
}



# Testing
rankhospital("TX", "heart failure", 4)
rankhospital("TX", "heart failure", 1)
rankhospital("MD", "heart attack", "Worst")
rankhospital("MN", "heart attack", 5000)

