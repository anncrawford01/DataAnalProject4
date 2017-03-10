##Plot 1
## emissions https://www.epa.gov/air-emissions-inventories


# This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/source_Classification_Code.rds")
# NEI has 6,497,651 observations with 6 columns
#Needs to be reduced or analyzed with better tools.
# get the total Emissions for Each year
#library(plyr)
table(NEI$year)
## number of observations per year
##1999        2002           2005      2008 
##1,108,469   1,698,677   1,713,850   1,976,655 
## find missing sapply(NEI, function(x) sum(is.na(x)))
### more observations in 2008 so need to get the same readings across years, fips, type, pollutant
Emissions1999 <- subset(NEI, year == 1999)
Stdyear <- NEI[c(which(NEI$year == 1999)) ,] 

## this takes forever ddply(NEI, c("year", "Emissions"), total = sum(Emissions))