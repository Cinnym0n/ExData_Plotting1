plot4 <- function() {
## set working directory ########
wrkdir <- paste("/Users/Cindy/Data_Science/datasciencecoursera",
                "/ExplorData_repo/ExData_Plotting1", sep="")
setwd(wrkdir)

## Read in data ########
#getwd()        ##get working directory - gives directory you are currently in
#list.files()   ##list directories and files in current directory
# Create a subdirectory called "data" to work in (if it doesn't already exist)
if (!file.exists("./data")) { dir.create("./data") }

##Allow use of functions from packages [If needed: selected CRAN mirror USA(TN)]
install.packages("data.table")   # use fread to read in subset of data
library(data.table)
install.packages("dplyr")        # use to work with data table (not data frame)
library(dplyr)

## READ IN DATA
# Download the zip file into subdirectory data saving the download date/time
ploturl <- paste("https://d396qusza40orc.cloudfront.net",
                 "/exdata%2Fdata%2Fhousehold_power_consumption.zip", sep="")
download.file(ploturl, destfile="./data/powerconsump.zip", method="curl")
dateloaded <- date()

# Unzip the downloaded file into the data subdirectory. Unzipping this file
#   releases a file called: household_power_consumption.txt)
unzip("./data/powerconsump.zip", exdir="./data")  #exdir=where to put files

# read file into a data table using fread (to get datatable & automatically
#     detect sep, colClasses, & nrows; read.table makes a data frame)
# hpcdata = data table containing raw data from input file,
#           with each ? converted to NA
hpcdata <- fread("./data/household_power_consumption.txt", na.strings = "?")

## SUBSET DATA
# change Date column to date formatted variable (was character)
hpcdata$Date <- as.Date(hpcdata$Date, "%d/%m/%Y")

# hpcDate = only the rows with dates 2007-02-01 & 2007-02-01
date1 <- as.Date("2007-02-01", "%Y-%m-%d")
date2 <- as.Date("2007-02-02", "%Y-%m-%d")
hpcDate <- filter(hpcdata, Date == date1 | Date == date2 )

# extracts the date and time
datetime <- as.POSIXlt( strptime(
    paste(hpcDate$Date, hpcDate$Time), "%Y-%m-%d %H:%M:%S") )

names(hpcDate)
#[1] "Date"                  "Time"                  "Global_active_power"
#[4] "Global_reactive_power" "Voltage"               "Global_intensity"
#[7] "Sub_metering_1"        "Sub_metering_2"        "Sub_metering_3"

## CREATE PLOTS
# specify plots to be in 2 rows & 2 columns
par(mfcol = c(2, 2))

## 1ST PLOT of 4 (same as plot2.png, except no units on y axis)
# plot date/time vs Global Active Power as a line graph (type = l), with no
#    x axis label and the y axis label: Global Active Power
plot(datetime, hpcDate$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power")

## 2ND PLOT of 4 (same as plot3.png, except no border on legend)
# start a new plot feild (plot), but don't plot points yet (type = "n),
#    label the y axis: Energy sub meeting, no x laxis label
plot (datetime, hpcDate$Sub_metering_1, type = "n",
      ylab = "Energy sub meeting", xlab="")

# add lines to the plot field
#   black Sub_metering_1, red Sub_metering_2, & blue Sub_metering_3
lines(datetime, hpcDate$Sub_metering_1, col = "black")
lines(datetime, hpcDate$Sub_metering_2, col = "red")
lines(datetime, hpcDate$Sub_metering_3, col = "blue")

# add legend in top right corner of graph, with solid lines (lty=1) and the
#   names of the variables in the plot (without table name "hcpDate$"),
#   but no border around the legend (bty = "n")
legend("topright", col = c("black", "red", "blue"), lty = 1, bty = "n",
       legend = c("Sub_metering_1 ", "Sub_metering_2 ", "Sub_metering_3 "))

## 3RD PLOT of 4
plot(datetime, hpcDate$Voltage, type = "l", ylab = "Voltage")

## 4TH PLOT of 4
plot(datetime, hpcDate$Global_reactive_power, type = "l",
     ylab = "Global_reactive_power")

# copy all 4 plots to a png file
# default size for a png file is: width = 480, height = 480, units = px (pixels)
dev.copy(png, file="plot4.png")
dev.off()

}