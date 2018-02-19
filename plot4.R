### figure 4 plot
### multiple plots of data from 1st February 2007 to 2nd February 2007 inclusive

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
rm(powerconsumption) ### save some memory

### do various plots, save to file 'plot4.png'
png(filename='plot4.png', width=480, height=480)

### set up a 2 x 2 collection of plots
par(mfcol=c(2,2))

### first plot, Global_active_power with time
with(twodaypowerconsumption, plot(realtime,Global_active_power,type='l',xlab='',ylab='Global Active Power (kilowatts)'))

### second plot, Sub metering (1,2,3) with time
with(twodaypowerconsumption, plot(realtime,Sub_metering_1,type='n',xlab='',ylab='Energy sub metering'))
with(twodaypowerconsumption, lines(realtime,Sub_metering_1,col='black'))
with(twodaypowerconsumption, lines(realtime,Sub_metering_2,col='red'))
with(twodaypowerconsumption, lines(realtime,Sub_metering_3,col='blue'))
legend("topright", pch = '-', col = c('black', 'red', 'blue'), legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))

### third plot, Voltage with time
with(twodaypowerconsumption, plot(realtime,Voltage,type='l',xlab='datetime',ylab='Voltage'))

### fourth plot, Global_reactive_power with time
with(twodaypowerconsumption, plot(realtime,Global_reactive_power,type='l',xlab='datetime',ylab='Global_reactive_power'))


dev.off()
