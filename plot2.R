### Author	: Jdata Scientist
### Date	: 8 February 2015	 	

plot2 <- function() {
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
	par(oma=c(5,2,1,1), bg = "white")
	plot(hpc2$TimeStamp, hpc2$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")
	
	### Save graph to a file
	dev.copy(png, filename = "./plot2.png", width = 480, height = 480, bg = "white")
	dev.off()
	dev.off()	
}