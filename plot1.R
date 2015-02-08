### Author	: Jdata Scientist
### Date	: 7 February 2015	 

plot1 <- function() {
	library(datasets)
	library(data.table)
	
	### Read file	
	hpc <- data.table(read.table("./household_power_consumption.txt", header = TRUE, sep = ';', na.strings = '?', 
		colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")))
	
	hpc[,Date2:=as.Date(hpc$Date, "%d/%m/%Y")]
	
	hpc2 <- hpc[hpc$Date2=="2007-02-01" | hpc$Date2=="2007-02-02",]
	hpc2[,tsc:=paste(hpc2$Date, hpc2$Time, sep = " ")]

	### Plot graph
	par(oma=c(5,2,1,1), bg = "white")
	hist(hpc2$Global_active_power,xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red")
	
	### Save graph to a file
	dev.copy(png, filename = "./plot1.png", width = 480, height = 480, bg = "white")
	dev.off()
	dev.off()
}