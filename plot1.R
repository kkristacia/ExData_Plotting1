## Calculating how much memory is required 1.6GB/num

# package used
library(data.table)

# loading only data from specific dates
# readings are taken every min so for 2 days there are 2880 data points
electric <- fread("household_power_consumption.txt", skip = "1/2/2007", nrows = 2880, na.strings = "?")

# checking and converting data variables
electric
electric <- cbind(electric, paste(electric$V1, electric$V2))

names(electric) <- c("Date", "Time", "Global_active_power", 
                     "Global_reactive_power", "Voltage", "Global_intensity", 
                     "Sub_metering_1", "Sub_metering_2", "Sub_metering_3", "datetime")


# converting to date/time class
electric$datetime <- as.POSIXct(strptime(electric$datetime, format = "%d/%m/%Y %H:%M:%S"))
class(electric$datetime)

# plot histogram of Global Active Power
hist(electric$Global_active_power, col = "red", 
     xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

### exporting to png
# 1. Open png file
png("plot1.png", width = 480, height = 480)
# 2. Create the plot
hist(electric$Global_active_power, col = "red", 
     xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
# 3. Close the file
dev.off()
