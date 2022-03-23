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
png(filename = 'plot4.png', width = 480, height = 480)

# Plot
par(mfrow=c(2,2))
# 1
plot(toplot$Time,toplot$Global_active_power, type = 'l', xlab = '', ylab = 'Global Active Power (kilowatts)')
# 2
plot(toplot$Time,toplot$Voltage, type = 'l', xlab = 'datetime', ylab = 'Voltage')
# 3
plot(toplot$Time,toplot$Sub_metering_1, type = 'n', xlab = '', ylab = 'Energy sub metering')
with(toplot,lines(Time,Sub_metering_1, col='black'))
with(toplot,lines(Time,Sub_metering_2, col='red'))
with(toplot,lines(Time,Sub_metering_3, col='blue'))
legend('topright', lty = 1, col = c('black','red','blue'),legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))
# 4
plot(toplot$Time,toplot$Global_reactive_power, type = 'l', xlab = 'datetime', ylab = 'Global_reactive_power')

dev.off()