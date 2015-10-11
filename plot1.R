plot1 <- function() {
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

## CREATE PLOT
# create a red filled histogram with main title: Global Active Power,
#    and x axis label: Global Active Power (kilowatts)
hist(hpcDate$Global_active_power, main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", col="red")

# copy the histogram to a png file
# default size for a png file is: width = 480, height = 480, units = px (pixels)
dev.copy(png, file="plot1.png")
dev.off()
}