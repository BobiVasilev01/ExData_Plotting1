# Set the locale to English to ensure weekday names are in English
Sys.setlocale("LC_TIME", "en_US.UTF-8")

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
filtered_data$Sub_metering_1 <- as.numeric(filtered_data$Sub_metering_1)
filtered_data$Sub_metering_2 <- as.numeric(filtered_data$Sub_metering_2)
filtered_data$Sub_metering_3 <- as.numeric(filtered_data$Sub_metering_3)

# Create the plot
plot(filtered_data$Datetime, filtered_data$Sub_metering_1, type = "l", 
     xlab = "", ylab = "Energy sub metering", main = "", col = "black")

# Add Sub_metering_2 as a red line
lines(filtered_data$Datetime, filtered_data$Sub_metering_2, col = "red")

# Add Sub_metering_3 as a blue line
lines(filtered_data$Datetime, filtered_data$Sub_metering_3, col = "blue")

# Add a legend to the top-right corner
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1)
