# Load data frame
power_consumption <- read.csv('household_power_consumption.txt' , sep = ";")
temp <- data.frame(apply(power_consumption, 2, as.numeric))
consumption <-cbind(power_consumption[1:2], temp[3:9])
rm(power_consumption,temp)

# Select subset to plot
toplot <- subset(consumption, Date == '1/2/2007' | Date =='2/2/2007')

# Convert the time and date
toplot$Date <- as.Date(toplot$Date, format="%d/%m/%Y")
toplot$Time <- strptime(toplot$Time, format="%H:%M:%S")
toplot[1:1440,"Time"] <- format(toplot[1:1440,"Time"],"2007-02-01 %H:%M:%S")
toplot[1441:2880,"Time"] <- format(toplot[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

# Set device
png(filename = 'plot2.png', width = 480, height = 480)

# Plot
plot(toplot$Time,toplot$Global_active_power, type = 'l', xlab = '', ylab = 'Global Active Power (kilowatts)')

dev.off()