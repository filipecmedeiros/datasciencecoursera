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


