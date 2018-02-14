#Compare emissions from motor vehicle sources in Baltimore City with 
#emissions from motor vehicle sources in Los Angeles County, 
#California #(). Which city has seen greater changes over time in 
#motor vehicle emissions?
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
  filter(SCC.Level.One == "Mobile Sources") %>%
  filter(grepl("Gas|Diesel", EI.Sector))
NEI.mv = NEI %>%
  filter(SCC %in% SCC.mv$SCC) %>%
  filter(fips == "24510" | fips == "06037") %>% # baltimore or LA
  left_join(SCC.mv) %>%
  mutate(city = ifelse(fips == "24510", "Baltimore", "LA"))

ggplot(data=NEI.mv) +
  geom_bar(aes(x=factor(year), weight=Emissions, fill = EI.Sector)) +
  facet_wrap(~city, scales = "free_y") + 
  xlab("Year") +
  ylab("Tons") +
  ggtitle("LA and Baltimore Motor Vehicle Emissions")
ggsave(filename = "plot6.png")  
