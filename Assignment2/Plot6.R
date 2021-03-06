
# Title:        JHU EDA Final Assignment - Plot 6
# Author:       Tucker Doud
# Date:         Nov 10, 2016
# Data Source:  RDS file 'summarySCC_PM25.rds' in wd()

# Load data and tools -------------------------------------------------
library(dplyr)
library(ggplot2)
setwd("~/GitHub/ExplDataAnalysis/Assignment2") #Change to your own working directory!
dat <- readRDS("summarySCC_PM25.rds")
codes <- readRDS("Source_Classification_Code.rds")

# Make plot -----------------------------------------------------------

# Index of SCC codes with the term "vehicles" in the EI.Sector field
i <- as.character(codes[which(grepl("vehicles", x = codes$EI.Sector, ignore.case = T) == T), 1])

# What is Included above?
filter(codes, SCC %in% i) %>%
    distinct(EI.Sector)

tmp <- filter(dat, SCC %in% i, fips %in% c("24510", "06037")) %>%
    group_by(year, fips) %>%
    summarise(TotEmission = sum(Emissions)) %>%
    mutate(label = if_else(fips == "24510", "Baltimore City", "LA County"))

png(filename = "Plot6.png", width = 20, height = 15, units = "cm", res = 300)
ggplot(tmp, aes(x = year, y = TotEmission)) +
    geom_bar(stat = "identity", fill = "navy") +
    facet_wrap(~label, nrow = 2, scales = "free") +
    scale_x_continuous(breaks = unique(tmp$year)) +
    xlab(NULL) + ylab("PM2.5 Emission (tons)") +
    ggtitle("Total PM2.5 Emission (EI.Sector = Vehicles)")
dev.off()
