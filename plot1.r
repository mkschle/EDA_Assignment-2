download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "NEI_data.zip")

unzip("NEI_data.zip")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#Using the base plotting system, make a plot showing the total PM2.5 emission from 
#all sources for each of the years 1999, 2002, 2005, and 2008.
library(dplyr)
TotalEmissions=NEI %>% group_by(year) %>% summarise(Emissions = sum (Emissions))
png(filename = "plot1.png")
barplot(TotalEmissions$Emissions, names.arg = TotalEmissions$year,
        xlab = "Year", ylab = "Tons of PM2.5")
dev.off()
