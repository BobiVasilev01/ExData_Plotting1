# Load necessary libraries
library(ggplot2)

# Read the dataset from the .txt file using ';' as the separator
data <- read.table("electric_power.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)

# Convert 'Date' column to Date format
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# Combine 'Date' and 'Time' to create a datetime column in POSIXct format
data$Datetime <- as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")

# Filter data for the dates 2007-02-01 and 2007-02-02
filtered_data <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")

# Replace "?" with NA in the sub-metering columns and convert them to numeric
filtered_data$Sub_metering_1[filtered_data$Sub_metering_1 == "?"] <- NA
filtered_data$Sub_metering_2[filtered_data$Sub_metering_2 == "?"] <- NA
filtered_data$Sub_metering_3[filtered_data$Sub_metering_3 == "?"] <- NA

filtered_data$Sub_metering_1 <- as.numeric(filtered_data$Sub_metering_1)
filtered_data$Sub_metering_2 <- as.numeric(filtered_data$Sub_metering_2)
filtered_data$Sub_metering_3 <- as.numeric(filtered_data$Sub_metering_3)

# Create the plot with three lines (Sub_metering_1, Sub_metering_2, Sub_metering_3)
plot <- ggplot(filtered_data, aes(x = Datetime)) +
  geom_line(aes(y = Sub_metering_1, color = "Sub_metering_1")) +
  geom_line(aes(y = Sub_metering_2, color = "Sub_metering_2")) +
  geom_line(aes(y = Sub_metering_3, color = "Sub_metering_3")) +
  labs(title = "Energy Sub Metering", 
       x = NULL, 
       y = "Energy sub metering") +
  scale_color_manual(values = c("black", "red", "blue"), 
                     labels = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) +
  theme_minimal(base_size = 15) +  # Minimal theme with larger text
  theme(
    axis.title.y = element_text(size = 14),
    axis.text = element_text(size = 12),
    plot.title = element_text(size = 16, face = "bold"),
    legend.title = element_blank(),  # Remove legend title
    legend.position = "top"
  ) +
  scale_x_datetime(date_labels = "%a", date_breaks = "1 day")  # Format x-axis as days of the week

# Save the plot as plot3.png with 480x480 pixels
ggsave("plot3.png", plot = plot, width = 480/72, height = 480/72, dpi = 72)  # 480x480 in pixels
