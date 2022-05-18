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
## making plot 1 named Global Active Power
hist(ass1$Global_active_power, xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power", col = "red")
## Copy my plot to a PNG file
dev.copy(png, file = "plot1.png")
dev.off()



