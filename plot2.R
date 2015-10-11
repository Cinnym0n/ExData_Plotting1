plot2 <- function() {
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

## CREATE PLOT
# plot date/time vs Global Active Power as a line graph (type = l), with no
#    x axis label and the y axis label: Global Active Power (kilowatts)
plot(datetime, hpcDate$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power (kilowatts)")

# copy the line graph to a png file
# default size for a png file is: width = 480, height = 480, units = px (pixels)
dev.copy(png, file="plot2.png")
dev.off()

}

## to write plot directly to file (not copy screen display):
#png(filename = "plot2-no_units.png")
#plot(datetime, hpcDate$Global_active_power, type = "l",
#     xlab = "", ylab = "Global Active Power")
#dev.off()