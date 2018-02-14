# Of the four types of sources indicated by the  
# (point, nonpoint, onroad, nonroad) variable, which of these four 
# sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? Use the ggplot2 
# plotting system to make a plot answer this question
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "NEI_data.zip")

unzip("NEI_data.zip")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#Using the base plotting system, make a plot showing the total PM2.5 emission from 
#all sources for each of the years 1999, 2002, 2005, and 2008.
library(dplyr)
library(ggplot2)
Baltimore = NEI %>%
  filter(fips == "24510")
ggplot(data=Baltimore) +
  geom_bar(aes(x=factor(year), weight=Emissions)) +
  facet_wrap(~type) +
  xlab("Year") +
  ylab("Tons") +
  ggtitle("Emissions in Baltimore")
ggsave(filename = "plot3.png")
