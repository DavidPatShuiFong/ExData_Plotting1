### figure 2 plot
### time series of Global Active Power from 1st February 2007 to 2nd February 2007 inclusive

### This assignment uses data sourced from the UC Irvine Machine Learning Repository,
### Using the "Individual household electric power consumption Data Set"

### check if data file already present, if not, then download the file (which is a .zip archive)
### if .zip archive available, extract the data
if (!file.exists('household_power_consumption.txt')) {
  if (!file.exists('household_power_consumption.zip')) {
    if (download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",'household_power_consumption.zip')) {
      stop('Unable to download data file')
    }
  }
  unzip('household_power_consumption.zip')
}

### read power consumption data into 'powerconsumption'
### the data file uses ';' as separators, and usually indicates NA as '?'
powerconsumption <- read.table('household_power_consumption.txt',sep = ';',na.strings = '?',header = TRUE)

### first two columns are date and time-of-day, stored as strings. create a 'realtime' R-time column
powerconsumption$realtime <- strptime(paste(powerconsumption[,1],powerconsumption[,2]),'%d/%m/%Y %H:%M:%S')

### create a data subset from 1st February 2007 to 2nd February 2007 inclusive
twodaypowerconsumption <- subset(powerconsumption,as.Date(powerconsumption$realtime)>="2007-02-01" & as.Date(powerconsumption$realtime)<="2007-02-02")

### do the time series, and copy to file 'plot2.png'
with(twodaypowerconsumption, plot(realtime,Global_active_power,type='l',xlab='',ylab='Global Active Power (kilowatts)'))
dev.copy(png, width=480, height=480,file = 'plot2.png')
dev.off()
