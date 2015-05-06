# plot1.R

## function to read the data from the source and cache it for subsequent calls
read_data <- function() {
    
    if (!file.exists("subset.csv")) {
        # the first execution needs to download the file...
        library(downloader)
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download(fileUrl, "dataset.zip", mode = "wb")
        DF <- read.csv(unz("dataset.zip","household_power_consumption.txt"), sep = ";", na.strings = "?")
        
        # ... filter the two requested dates ...        
        DF <- DF[as.character(DF$Date) == "1/2/2007" | as.character(DF$Date) == "2/2/2007", ]
        
        # ... add a new field concatenating date and time
        DF$DateTime <- paste(DF$Date, DF$Time)
        
        #... and write the results for next execution
        write.csv(DF, "subset.csv")    
    }
    
    # read the data again even if it has just being created to make sure format is consistent
    DF <- read.csv("subset.csv")
    
    # convert date and time strings according to format
    DF$Date <- as.Date(DF2$Date, format="%d/%m/%Y")
    DF$DateTime <- strptime(DF$DateTime, format = "%d/%m/%Y %H:%M:%S")
}

read_data()
png("plot1.png", width = 480, height = 480, units = "px")
hist(DF$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red")
dev.off()
