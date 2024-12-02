# Load necessary libraries
library(ggplot2)

# Read the dataset from the .txt file using ';' as the separator
data <- read.table("electric_power.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)

# Convert 'Date' column to Date format
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# Convert 'Time' to appropriate time format (if it's available in your data)
data$Time <- strptime(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")

# Filter data for the dates 2007-02-01 and 2007-02-02
filtered_data <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")

# Replace "?" with NA in Global_active_power and convert it to numeric
filtered_data$Global_active_power[filtered_data$Global_active_power == "?"] <- NA
filtered_data$Global_active_power <- as.numeric(filtered_data$Global_active_power)

# Create the bar plot with Global_active_power on the x-axis and Frequency on the y-axis
plot <- ggplot(filtered_data, aes(x = Global_active_power)) +
  geom_bar(fill = "red", color = "black") +  # Red bars with black outline
  labs(title = "Frequency of Global Active Power", 
       x = "Global Active Power (kilowatts)", 
       y = "Frequency") +
  theme_minimal(base_size = 15) +  # Minimal theme with larger text
  theme(
    axis.title = element_text(size = 16),  # Larger axis titles
    axis.text = element_text(size = 12),   # Larger axis labels
    plot.title = element_text(size = 18, face = "bold")  # Larger plot title
  )

# Save the plot as plot1.png with 480x480 pixels
ggsave("plot1.png", plot = plot, width = 480/72, height = 480/72, dpi = 72)  # 480x480 in pixels with 72 dpi
