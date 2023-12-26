best <- function(state, outcome) {
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
    mortality_col <- paste("Lower.Mortality.Estimate...Hospital.30.Day.Death..Mortality..Rates.from.",
                           sub(" ", ".",tools::toTitleCase(outcome)), sep = "")
    
    # Use suppressWarnings to ignore NAs introduced by coercion
    suppressWarnings({
        ## Convert mortality rates to numeric
        subset_data[[mortality_col]] <- as.numeric(subset_data[[mortality_col]])
    })
    
    # Sort hospitals based on mortality rates and hospital's name
    sorted_data <- subset_data[order(subset_data[[mortality_col]],
                                     subset_data[["Hospital.Name"]]), ]
    
    # Get the index of the hospital with the lowest rate
    min_index <- which.min(sorted_data[[mortality_col]])
    
    # Get the name of the hospital with the lowest mortality rate
    hospital_name <- sorted_data$Hospital.Name[min_index]
    
    # Return hospital name in that state with lowest 30-day death
    return(hospital_name)
}


#Testing

best("TX", "heart attack")
best("TX", "heart failure")
best("MD", "heart attack")
best("MD", "pneumonia")
best("BB", "heart attack")
best("NY", "hert attack")



