# Set the locale to English to ensure weekday names are in English
Sys.setlocale("LC_TIME", "en_US.UTF-8")

# Save the plot as a PNG file
png("plot4.png", width = 480, height = 480)

# Read data and filter for specific dates
file_path <- "household_power_consumption.txt"
data <- read.table(file_path, sep = ";", header = TRUE, na.strings = "?", 
                   stringsAsFactors = FALSE)

# Convert Date and Time columns to a datetime format
data$Datetime <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

# Convert Date to Date type and filter for 2007-02-01 and 2007-02-02
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
filtered_data <- subset(data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

# Ensure numeric values for plotting
filtered_data$Global_active_power <- as.numeric(filtered_data$Global_active_power)
filtered_data$Voltage <- as.numeric(filtered_data$Voltage)
filtered_data$Sub_metering_1 <- as.numeric(filtered_data$Sub_metering_1)
filtered_data$Sub_metering_2 <- as.numeric(filtered_data$Sub_metering_2)
filtered_data$Sub_metering_3 <- as.numeric(filtered_data$Sub_metering_3)

# Set up the plotting area for a 2x2 grid
par(mfrow = c(2, 2))

# Plot Global Active Power
plot(filtered_data$Datetime, filtered_data$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power (kilowatts)", 
     main = "", col = "black")

# Plot Voltage
plot(filtered_data$Datetime, filtered_data$Voltage, type = "l", 
     xlab = "Datetime", ylab = "Voltage", main = "", col = "black")

# Plot Sub Metering (3 lines in one plot)
plot(filtered_data$Datetime, filtered_data$Sub_metering_1, type = "l", 
     xlab = "", ylab = "Energy sub metering", main = "", col = "black")
lines(filtered_data$Datetime, filtered_data$Sub_metering_2, col = "red")
lines(filtered_data$Datetime, filtered_data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1)

# Plot Global Reactive Power
plot(filtered_data$Datetime, filtered_data$Global_reactive_power, type = "l", 
     xlab = "Datetime", ylab = "Global Reactive Power", main = "", col = "black")

# Close the PNG device to save the plot
dev.off()
