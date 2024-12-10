# Read data and filter for specific dates
file_path <- "household_power_consumption.txt"
data <- read.table(file_path, sep = ";", header = TRUE, na.strings = "?", 
                   stringsAsFactors = FALSE)

# Convert Date column to Date type and filter
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
filtered_data <- subset(data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

# Ensure 'Global_active_power' is numeric
filtered_data$Global_active_power <- as.numeric(filtered_data$Global_active_power)

# Remove NA values
filtered_data <- na.omit(filtered_data)

# Create the histogram using the plot function
hist(filtered_data$Global_active_power,
     breaks = 30,  # Adjust number of bins
     col = "red",  # Set bar color to red
     border = "black",  # Set bar border to black
     main = "Global Active Power Distribution (2007-02-01 and 2007-02-02)",  # Title
     xlab = "Global Active Power (kilowatts)",  # X-axis label
     ylab = "Frequency",  # Y-axis label
     las = 1,  # Rotate axis labels for readability
     bg = "white")  # Set background color to white
