#Have total emissions from PM2.5 decreased in the Baltimore City, 
#Maryland () from 1999 to 2008? Use the base plotting system to 
#make a plot answering this question.
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "NEI_data.zip")

unzip("NEI_data.zip")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#Using the base plotting system, make a plot showing the total PM2.5 emission from 
#all sources for each of the years 1999, 2002, 2005, and 2008.
library(dplyr)
Baltimore = NEI %>%
  filter(fips == "24510") %>%
  group_by(year) %>%
  summarise(Emissions = sum (Emissions))
png(filename = "plot2.png")
barplot(Baltimore$Emissions, names.arg = Baltimore$year,
        xlab = "Year", ylab = "Tons of PM2.5", main="Total Baltimore Emissions")
dev.off()
