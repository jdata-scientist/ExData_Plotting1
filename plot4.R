### Author	: Jdata Scientist
### Date	: 8 February 2015	 	

plot4 <- function() {
	library(datasets)
	library(data.table)
	library(lubridate)
	
	### Read file	
	hpc <- data.table(read.table("./household_power_consumption.txt", header = TRUE, sep = ';', na.strings = '?', 
		colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")))
	
	hpc[,Date2:=as.Date(hpc$Date, "%d/%m/%Y")]
	
	hpc2 <- hpc[hpc$Date2=="2007-02-01" | hpc$Date2=="2007-02-02",]
	hpc2[,ts:=paste(hpc2$Date, hpc2$Time, sep = " ")]
	hpc2$TimeStamp <- as.POSIXct(strptime(hpc2$ts, "%d/%m/%Y %H:%M:%S"))

	### Plot 4 Graphs
	par(oma=c(3,2,1,1), bg = "white", mfrow = c(2, 2), cex = 0.70)
	with(hpc2, {
		plot(TimeStamp, Global_active_power, xlab = "", ylab = "Global Active Power", type = "l")
		
		plot(TimeStamp, Voltage, xlab = "datetime", ylab = "Voltage", type = "l")
		
		with(hpc2, plot(TimeStamp, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l"))
		lines(hpc2$TimeStamp, hpc2$Sub_metering_2, col = "red")
		lines(hpc2$TimeStamp, hpc2$Sub_metering_3, col = "blue")
		legend("topright", legend = c("Sub_metering_1  ", "Sub_metering_2  ", "Sub_metering_3  "), lwd=2, lty=c(1,1,1), col = c("black", "red", "blue"), bty = "n")
		
		plot(TimeStamp, Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l", ylim=c(0.0, 0.5))
	})

	### Save mutiple graphs to a png file
	dev.copy(png, filename = "./plot4.png", width = 480, height = 480, bg = "white")
	dev.off()
	dev.off()
}