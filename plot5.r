#How have emissions from motor vehicle sources changed from 
#1999–2008 in Baltimore City?
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "NEI_data.zip")

unzip("NEI_data.zip")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#Using the base plotting system, make a plot showing the total PM2.5 emission from 
#all sources for each of the years 1999, 2002, 2005, and 2008.
library(dplyr)
#Mobile sources include all vehicles with gas/diesel power engines-land, water, train, etc.
SCC.mv = SCC %>% 
  filter(SCC.Level.One == "Mobile Sources")
NEI.mv = NEI %>%
  filter(SCC %in% SCC.mv$SCC) %>%
  filter(fips == "24510")
ggplot(data=NEI.mv) +
  geom_bar(aes(x=factor(year), weight=Emissions)) +
  xlab("Year") +
  ylab("Tons") +
  ggtitle("Baltimore City Motor Vehicle Emissions")
ggsave(filename = "plot5.png")  
