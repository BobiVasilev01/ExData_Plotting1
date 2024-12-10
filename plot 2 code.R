# Read data and filter for specific dates
file_path <- "household_power_consumption.txt"
data <- read.table(file_path, sep = ";", header = TRUE, na.strings = "?", 
                   stringsAsFactors = FALSE)

# Convert Date and Time columns to a datetime format
data$Datetime <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

# Convert Date to Date type and filter for 2007-02-01 and 2007-02-02
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
filtered_data <- subset(data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

# Ensure 'Global_active_power' is numeric
filtered_data$Global_active_power <- as.numeric(filtered_data$Global_active_power)

# Remove NA values
filtered_data <- na.omit(filtered_data)

# Plot the time series
plot(filtered_data$Datetime, filtered_data$Global_active_power, 
     type = "l",  # Line plot
     xlab = "",  # No label for x-axis
     ylab = "Global Active Power (kilowatts)",  # Label for y-axis
     xaxt = "n",  # Disable default x-axis
     main = "")  # No main title

# Custom x-axis labels (Thu, Fri, Sat)
axis(1, at = seq(from = min(filtered_data$Datetime), to = max(filtered_data$Datetime), by = "1 day"), 
     labels = format(seq(from = min(filtered_data$Datetime), to = max(filtered_data$Datetime), by = "1 day"), "%a"))
