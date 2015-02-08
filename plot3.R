### Author	: Jdata Scientist
### Date	: 8 February 2015	 	

plot3 <- function() {
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

	### Plot graph
	par(oma=c(2,2,1,1), bg = "white")
	with(hpc2, plot(TimeStamp, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l"))
	lines(hpc2$TimeStamp, hpc2$Sub_metering_2, col = "red")
	lines(hpc2$TimeStamp, hpc2$Sub_metering_3, col = "blue")
	legend("topright", legend = c("Sub_metering_1 ", "Sub_metering_2 ", "Sub_metering_3 "), lwd=2, lty=c(1,1,1), col = c("black", "red", "blue"))

	### Save graph to a file
	dev.copy(png, filename = "./plot3.png", width = 480, height = 480, bg = "white")
	dev.off()
	dev.off()
}