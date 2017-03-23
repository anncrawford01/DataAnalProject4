## Plot2.R
## Have total emissions from PM2.5 decreased in Baltimore City, Maryland, fips =24510
## Ann Crawford
## 3/22/2017
## Coursera Exploratory Data Analysis 
##
## emissions https://www.epa.gov/air-emissions-inventories
## documentation of data https://www.epa.gov/air-emissions-inventories/national-emissions-inventory-nei

## from 1999-2008
## remove all variables except functions
## http://stackoverflow.com/questions/8305754/remove-all-variables-except-functions
rm(list = setdiff(ls(), lsf.str()))

# This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/source_Classification_Code.rds")
# NEI has 6,497,651 observations with 6 columns
##table(NEI$year)
## number of observations per year
##1999        2002           2005      2008 
##1,108,469   1,698,677   1,713,850   1,976,655 

# get the total Emissions for Each year
library(plyr)
## check for any missing  values
##sapply(NEI, function(x) sum(is.na(x)))

## Get Emissions for Baltimore
NEIBaltimore <- subset(NEI, fips == "24510")

# Calculate totals of all Emissions for each year
TotalPollution <- ddply(NEIBaltimore, .(year), summarise,
             totalemit = sum(Emissions, na.rm = TRUE))

## http://www.statmethods.net/graphs/bar.html
with(TotalPollution , barplot(totalemit, pch = 10, xlab = "Year" , ylab = "Total PM2.5 Emissions (tons)" ,
                              main = "Total PM2.5 Baltimore ", names.arg = year
))

dev.copy(png, file = "plot2.png")   ## copy to png file
dev.off()


