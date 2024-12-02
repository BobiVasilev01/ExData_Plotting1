# Load the dataset
data <- read.table("electric_power.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)

# Convert 'Date' column to Date format
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# Combine 'Date' and 'Time' to create a datetime column in POSIXct format
data$Datetime <- as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")

# Filter data for the dates 2007-02-01 and 2007-02-02
filtered_data <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")

# Replace "?" with NA and convert numeric columns
filtered_data$Global_active_power <- as.numeric(replace(filtered_data$Global_active_power, filtered_data$Global_active_power == "?", NA))
filtered_data$Voltage <- as.numeric(replace(filtered_data$Voltage, filtered_data$Voltage == "?", NA))
filtered_data$Global_reactive_power <- as.numeric(replace(filtered_data$Global_reactive_power, filtered_data$Global_reactive_power == "?", NA))
filtered_data$Sub_metering_1 <- as.numeric(replace(filtered_data$Sub_metering_1, filtered_data$Sub_metering_1 == "?", NA))
filtered_data$Sub_metering_2 <- as.numeric(replace(filtered_data$Sub_metering_2, filtered_data$Sub_metering_2 == "?", NA))
filtered_data$Sub_metering_3 <- as.numeric(replace(filtered_data$Sub_metering_3, filtered_data$Sub_metering_3 == "?", NA))

# Open a PNG device for plotting
png("plot4.png", width = 480, height = 480)

# Set up a 2x2 plotting layout
par(mfrow = c(2, 2))

# Plot 1: Global Active Power
plot(filtered_data$Datetime, filtered_data$Global_active_power, type = "l", 
     xlab = "", ylab = "Global Active Power", col = "black")

# Plot 2: Voltage
plot(filtered_data$Datetime, filtered_data$Voltage, type = "l", 
     xlab = "datetime", ylab = "Voltage", col = "black")

# Plot 3: Energy Sub Metering
plot(filtered_data$Datetime, filtered_data$Sub_metering_1, type = "l", 
     xlab = "", ylab = "Energy sub metering", col = "black")
lines(filtered_data$Datetime, filtered_data$Sub_metering_2, col = "red")
lines(filtered_data$Datetime, filtered_data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1, bty = "n", cex = 0.8)

# Plot 4: Global Reactive Power
plot(filtered_data$Datetime, filtered_data$Global_reactive_power, type = "l", 
     xlab = "datetime", ylab = "Global Reactive Power", col = "black")

# Close the PNG device
dev.off()
