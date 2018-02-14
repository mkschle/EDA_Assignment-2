#Across the United States, how have emissions from coal combustion-related sources changed 
#from 1999–2008?
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "NEI_data.zip")

unzip("NEI_data.zip")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#Using the base plotting system, make a plot showing the total PM2.5 emission from 
#all sources for each of the years 1999, 2002, 2005, and 2008.
library(dplyr)
SCC.coal = SCC %>% 
  filter(EI.Sector == "Fuel Comb - Comm/Institutional - Coal")
NEI.coal = NEI %>%
  filter(SCC %in% SCC.coal$SCC)
ggplot(data=NEI.coal) +
  geom_bar(aes(x=factor(year), weight=Emissions)) +
  xlab("Year") +
  ylab("Tons") +
  ggtitle("Total Coal Combustion related emissions")
  ggsave(filename = "plot4.png")
  
  
