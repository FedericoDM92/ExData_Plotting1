# Load data frame
power_consumption <- read.csv('household_power_consumption.txt' , sep = ";")
temp <- data.frame(apply(power_consumption, 2, as.numeric))
consumption <-cbind(power_consumption[1:2], temp[3:9])
rm(power_consumption,temp)

# Select subset to plot
toplot <- subset(consumption, Date == '1/2/2007' | Date =='2/2/2007')

# Set device
png(filename = 'plot1.png', width = 480, height = 480)

#Create Hist
hist(toplot$Global_active_power, col = 'red', xlab = 'Global Active Power (kilowatts)',main = 'Global Active Power')

dev.off()
