library(dplyr)
## reading in assign1 file
ass <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              ass)
ass <- unzip(ass)
data <- read.csv(ass, header = T, sep = ";", na.strings = "?")
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
ass1 <- data %>% filter(Date=="2007-02-01"| Date=="2007-02-02")
ass1[,3:9] <- as.data.frame(lapply(ass1[,3:9], as.numeric))
ass1 <- mutate(ass1, datetime= as.POSIXct(paste(Date, Time)))
## plot 2 "Global Active Power 
with(ass1, plot(Global_active_power~datetime, 
                ylab = "Global Active Power (kilowatts)", type="l"))
dev.copy(png, file = "plot2.png")
dev.off()
