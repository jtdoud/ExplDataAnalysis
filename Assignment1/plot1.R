
# Title:        JHU EDA Plots
# Author:       Tucker Doud
# Date:         Oct 23, 2016
# Data Source:  Text file in wd()

setwd("~/GitHub/ExplDataAnalysis") #Change to your own working directory!

# Get subset of datafile =============================================

d <- c("1/2/2007", "2/2/2007") #Dates to find
con <- file("household_power_consumption.txt") #connect to file

dateCol <- sapply(strsplit(readLines(con = con), split = ";"), "[", 1) #Get date col only
i <- min(which(dateCol %in% d)) #First row to load in
nr <- length(which(dateCol %in% d)) #Number of rows to load in

dat <- read.table(file = "household_power_consumption.txt",sep = ";",
                  skip = i-1, nrows = nr, stringsAsFactors = F)

n <- strsplit(readLines(con = con, n = 1), split = ";")[[1]] # Rename variables
names(dat) <- n
close(con = con); rm(d, dateCol, i, nr, n, con)

# Fix dates
tmp <- paste(dat$Date, dat$Time)
dat$Date_time <- strptime(x = tmp, format = "%d/%m/%Y %H:%M:%S")

# Plots =========================================================

# Plot 1
png(filename = "plot1.png")
hist(x = dat$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()