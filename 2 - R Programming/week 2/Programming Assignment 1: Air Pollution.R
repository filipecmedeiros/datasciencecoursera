pollutantmean <- function(directory, pollutant, id=1:332){
    
    df <- NULL
    for (i in id){
        file_path = paste(directory, "/", sprintf("%03d", i), ".csv",  sep = "")
        #print(file_path)
        df_aux = read.csv(file_path)
        df <- rbind(df, df_aux)
    }
    
    mean(df[!is.na(df[pollutant]), pollutant])
}


complete <- function(directory, id=1:332){
    df <- data.frame(id=integer(), nobs=integer())
    for (i in id){
        file_path = paste(directory, "/", sprintf("%03d", i), ".csv",  sep = "")
        #print(file_path)
        df_aux = read.csv(file_path)
        df_aux <- df_aux[complete.cases(df_aux), ]
        
        row <- data.frame(id=i, nobs=nrow(df_aux))
        df <- rbind(df, row)
    }
    
    df
}