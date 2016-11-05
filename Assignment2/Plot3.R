
# Title:        JHU EDA Final Assignment - Plot 3
# Author:       Tucker Doud
# Date:         Nov 5, 2011
# Data Source:  RDS file 'summarySCC_PM25.rds' in wd()

# Load data and tools -------------------------------------------------
library(dplyr)
library(ggplot2)
setwd("~/GitHub/ExplDataAnalysis/Assignment2") #Change to your own working directory!
dat <- readRDS("summarySCC_PM25.rds")

# Make plot -----------------------------------------------------------
tmp <- filter (dat, fips == "24510") %>%
    group_by(year, type) %>%
    summarise(TotEmission = sum(Emissions))

png(filename = "Plot3.png", width = 20, height = 15, units = "cm", res = 300)
ggplot(tmp, aes(x = year, y = TotEmission, color = type)) +
    geom_line(size = 1.5) +
    scale_x_continuous(breaks = unique(tmp$year)) +
    xlab(NULL) + ylab("PM2.5 Emission (tons)") +
    ggtitle("Total PM2.5 Emission by Year (Baltimore City)")
dev.off()
