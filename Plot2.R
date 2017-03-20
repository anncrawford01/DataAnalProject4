##Plot2.R
## emissions https://www.epa.gov/air-emissions-inventories
## documentation of data https://www.epa.gov/air-emissions-inventories/national-emissions-inventory-nei
## Have total emissions from PM2.5 decreased in Baltimore City, Maryland, fips =24510
## from 1999-2008
## remove all variables except functions
## http://stackoverflow.com/questions/8305754/remove-all-variables-except-functions
rm(list = setdiff(ls(), lsf.str()))

# This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/source_Classification_Code.rds")
# NEI has 6,497,651 observations with 6 columns
#Needs to be reduced or analyzed with better tools.
# get the total Emissions for Each year
library(plyr)
##table(NEI$year)
## number of observations per year
##1999        2002           2005      2008 
##1,108,469   1,698,677   1,713,850   1,976,655 

## check for any missing  values
##sapply(NEI, function(x) sum(is.na(x)))

### more observations in 2008 so need to get the same readings across years, fips, type, pollutant
##Emissions1999 <- subset(NEI, year == 1999)

NEIBaltimore <- subset(NEI, fips == "24510")

# Calculate totals of all Emissions for each year
TotalPollution <- ddply(NEIBaltimore, .(year), summarise,
             totalemit = sum(Emissions, na.rm = TRUE))
# Plot a line chart of the result
with( TotalPollution, plot( totalemit ~ year, type = "l", xlab = "Year", ylab = "Total PM2.5 Emissions (tons)" , main = "Total PM25 Baltimore ") )



