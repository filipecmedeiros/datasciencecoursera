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

corr <- function(directory, threshold = 0){
    files <- list.files(directory, pattern = ".csv")
    #print(files)
    cr <- c()
    for (file in files){
        df_aux <- read.csv(paste(directory, file, sep=""))
        df_aux <- df_aux[complete.cases(df_aux), ]
        if (nrow(df_aux)>threshold){
            cr <- c(cr, cor(df_aux$sulfate, df_aux$nitrate))
        }
    }
    
    cr
}

