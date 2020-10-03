library(dplyr)
library(lubridate)
setwd("C:/Users/julia/OneDrive/Escritorio/Rprogramming/EDAcourseproject1")
household <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

filtered_by_date <- household %>% mutate(
    Date = dmy(Date)) %>%
    filter(Date >= "2007-02-01", Date <= "2007-02-02")

for (i in 1:nrow(filtered_by_date)) {
    filtered_by_date$Time[i] <- paste(filtered_by_date$Date[i], filtered_by_date$Time[i], collapse = " ")
}

filtered_by_date <- filtered_by_date %>% mutate(Time = ymd_hms(Time),
                                                Global_active_power = as.numeric(Global_active_power),
                                                Global_reactive_power = as.numeric(Global_reactive_power),
                                                Voltage = as.numeric(Voltage),
                                                Global_intensity = as.numeric(Global_intensity),
                                                Sub_metering_1 = as.numeric(Sub_metering_1),
                                                Sub_metering_2 = as.numeric(Sub_metering_2))

# Send plot to png file by opening the png graphic device
png(filename = "plot3.png", width = 480, height = 480)

# Plot 3
with(filtered_by_date,
     plot(Time,
          Sub_metering_1,
          type="n",
          ylab = "Energy sub metering",
          xlab=""))

# Add legend
with(filtered_by_date,
     lines(Time,
           Sub_metering_1, col="black"))
with(filtered_by_date,
     lines(Time,
           Sub_metering_2, col="red"))
with(filtered_by_date,
     lines(Time,
           Sub_metering_3, col="blue"))

legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"),
       lty = 1)

# Close graphic device
dev.off()