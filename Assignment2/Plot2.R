
# Title:        JHU EDA Final Assignment - Plot 2
# Author:       Tucker Doud
# Date:         Nov 5, 2011
# Data Source:  RDS file 'summarySCC_PM25.rds' in wd()

# Load data and tools -------------------------------------------------
library(dplyr)
setwd("~/GitHub/ExplDataAnalysis/Assignment2") #Change to your own working directory!
dat <- readRDS("summarySCC_PM25.rds")

# Make plot -----------------------------------------------------------
tmp <- filter (dat, fips == "24510") %>%
    group_by(year) %>%
    summarise(TotEmission = sum(Emissions))

png(filename = "Plot2.png", width = 20, height = 15, units = "cm", res = 300)
barplot(height = tmp$TotEmission, names.arg = tmp$year, col = "navy",
        border = NA, main = "Total PM2.5 Emission by Year (Baltimore City)",
        ylab = "PM2.5 Emission (tons)", cex.axis = 0.8)
dev.off()
