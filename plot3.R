# Create folder where the dataset will be placed -check if it does not exist yet
# Name folder as 'data' 
if(!file.exists("./data"))
  dir.create("./data")

# Download the zip file from the given URL if UCI HAR Dataset does not exist
# Save it to datasets.zip
# Unzip file
if (!file.exists("./data/datasets.zip")) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl, destfile = "./data/datasets.zip")
  unzip("./data/datasets.zip", exdir = "./data")
}

# Read data and create subset (with dates 1/2/2007 and 2/2/2007)
powerData <- read.table("./data/household_power_consumption.txt", header = T, sep = ";", na.strings = "?")
powerData$Date <- as.Date(powerData$Date, format="%d/%m/%Y")
powerSub <- subset(powerData, subset = (Date == "2007-02-01" | Date == "2007-02-02"))

# Convert dates and times
dateTime <- paste(as.Date(powerSub$Date), powerSub$Time)
powerSub$dateTime <- as.POSIXct(dateTime)

# Create Plot 3
plot(powerSub$Sub_metering_1~powerSub$dateTime, type="l", ylab="Energy sub metering", xlab="")
lines(powerSub$Sub_metering_2~powerSub$dateTime,col="red")
lines(powerSub$Sub_metering_3~powerSub$dateTime,col="blue")

legend("topright", col=c("black", "red", "blue"), lty=1, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.75)

# Save to file plot3.png
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()