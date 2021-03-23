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



#### multiple plots
par(mfcol= c(2,2))

# first plot
plot(electric$datetime, electric$Global_active_power, type = "l", 
     ylab = "Global Active Power (kilowatts)", xlab ="")

# second plot
plot(electric$datetime, electric$Sub_metering_1, type = "l", 
     ylab = "Energy sub metering", xlab ="")
points(electric$datetime, electric$Sub_metering_2, col="red", type = "l")
points(electric$datetime, electric$Sub_metering_3, col="blue", type = "l")
legend("topright", lty=1, col= c("black", "red", "blue"), 
      legend= c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# third plot
plot(electric$datetime, electric$Voltage, type = "l", 
     ylab = "Voltage", xlab ="datetime")

# fourth plot
plot(electric$datetime, electric$Global_reactive_power, type = "l", 
     ylab = "Global_reactive_power", xlab ="datetime")



### exporting to png
# 1. Open png file
png("plot4.png", width = 480, height = 480)
# 2. Create the plot
par(mfcol= c(2,2))
plot(electric$datetime, electric$Global_active_power, type = "l", 
     ylab = "Global Active Power (kilowatts)", xlab ="")
plot(electric$datetime, electric$Sub_metering_1, type = "l", 
     ylab = "Energy sub metering", xlab ="")
points(electric$datetime, electric$Sub_metering_2, col="red", type = "l")
points(electric$datetime, electric$Sub_metering_3, col="blue", type = "l")
legend("topright", lty=1, col= c("black", "red", "blue"), 
       legend= c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(electric$datetime, electric$Voltage, type = "l", 
     ylab = "Voltage", xlab ="datetime")
plot(electric$datetime, electric$Global_reactive_power, type = "l", 
     ylab = "Global_reactive_power", xlab ="datetime")

# 3. Close the file
dev.off()

#### alternative using with ####
# 1. Open png file
png("plot5.png", width = 480, height = 480)
# 2. Create the plot
par(mfcol= c(2,2))
with(electric, {
     plot(datetime, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab ="")
     plot(datetime, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab ="")
     points(datetime, Sub_metering_2, col="red", type = "l")
     points(datetime, Sub_metering_3, col="blue", type = "l")
     legend("topright", lty=1, col= c("black", "red", "blue"),legend= c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
     plot(datetime, Voltage, type = "l",ylab = "Voltage", xlab ="datetime")
     plot(datetime, Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab ="datetime")
} )

# 3. Close the file
dev.off()
