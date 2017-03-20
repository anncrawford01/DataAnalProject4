##Plot 1
## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system,
### https://github.com/DataScienceSpecialization/courses/

## make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
## emissions https://www.epa.gov/air-emissions-inventories
## documentation of data https://www.epa.gov/air-emissions-inventories/national-emissions-inventory-nei


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

##summary(NEI$Emissions)
## Big variance in emission values.   - half the values are 0 ?
##Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
##0.0      0.0      0.0      3.4      0.1 647000.0 

## Big variance in emission values.   - half the values are 0 ?
##Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
##0.0      0.0      0.0      3.4      0.1 647000.0 

## check for any missing  values
##sapply(NEI, function(x) sum(is.na(x)))



### get positvie Emmissions
Emissions <- subset(NEI, Emissions > 0)


# Calculate totals of all Emissions for each year
TotalPollution <- ddply(NEI, .(year), summarise,
             totalemit = sum(Emissions, na.rm = TRUE))
# Plot a line chart of the result
with(TotalPollution , plot(totalemit ~ year, type = "l", xlab = "Year" , ylab = "Total PM2.5 Emissions (tons)" , main = "Total PM25 United States "
     ))



