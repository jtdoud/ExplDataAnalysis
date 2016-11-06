
# Title:        JHU EDA Final Assignment - Plot 4
# Author:       Tucker Doud
# Date:         Nov 6, 2016
# Data Source:  RDS file 'summarySCC_PM25.rds' in wd()

# Load data and tools -------------------------------------------------
library(dplyr)
library(ggplot2)
setwd("~/GitHub/ExplDataAnalysis/Assignment2") #Change to your own working directory!
dat <- readRDS("summarySCC_PM25.rds")
codes <- readRDS("Source_Classification_Code.rds")

# Make plot -----------------------------------------------------------

# Index of SCC codes with the term "coal" in the EI.Sector field
i <- as.character(codes[which(grepl("coal", x = codes$EI.Sector, ignore.case = T) == T), 1])

# What is Included above?
# filter(codes, SCC %in% i) %>%
#     distinct(EI.Sector)

tmp <- filter(dat, SCC %in% i) %>%
    group_by(year) %>%
    summarise(TotEmission = sum(Emissions))

png(filename = "Plot4.png", width = 20, height = 15, units = "cm", res = 300)
ggplot(tmp, aes(x = year, y = TotEmission)) +
    geom_bar(stat = "identity", fill = "navy") +
    scale_x_continuous(breaks = unique(tmp$year)) +
    xlab(NULL) + ylab("PM2.5 Emission (tons)") +
    ggtitle("Total PM2.5 Emission by Year (EI.Sector = Coal)")
dev.off()
