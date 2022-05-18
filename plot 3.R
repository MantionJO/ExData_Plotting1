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
## making plot 3 Energy sub_metering
with(ass1, plot(Sub_metering_1~datetime, col= 1, type = "l",
                ylab = "Energy Sub metering"))
lines.default(ass1$Sub_metering_2~ass1$datetime, col="red")
lines.default(ass1$Sub_metering_3~ass1$datetime, col="blue")
legend("topright", lty = 1, lwd = 2, col = c(1,"red","blue"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
## Copy my plot to a PNG file
dev.copy(png, file = "plot3.png")
dev.off()
