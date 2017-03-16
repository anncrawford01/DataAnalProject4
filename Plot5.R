##Plot 1
## emissions https://www.epa.gov/air-emissions-inventories
## documentation of data https://www.epa.gov/air-emissions-inventories/national-emissions-inventory-nei

##How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

## grammar of graphics data to asesthetic
## geom, coordin, data, asestheics
## Dependencies
##library(plyr)
##install.packages("ggplot2")

##library(ggplot2)

# This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/source_Classification_Code.rds")
# NEI has 6,497,651 observations with 6 columns

# get the total Emissions for Each year

table(NEI$year)
## number of observations per year
##1999        2002           2005      2008 
##1,108,469   1,698,677   1,713,850   1,976,655 

## check for any missing  values
sapply(NEI, function(x) sum(is.na(x)))

NEIBaltimore <- subset(NEI, fips == "24510")   ##im = 2096    7

# Calculate totals of all Emissions for each year
TotalPollution <- ddply(NEIBaltimore, .(year, type), summarise,
             totalemit = sum(Emissions, na.rm = TRUE))
TotalPollution$Type <-as.factor(TotalPollution$type)
# Plot a line chart of the result
qplot(year, totalemit, data = TotalPollution, ylab = "Total PM2.5 Emissions (tons)" , main = "Total PM25 Baltimore by Type" ,
      color = Type, geom = "line")
## using facets
qplot(year, totalemit, data = TotalPollution, ylab = "Total PM2.5 Emissions (tons)" , main = "Total PM25 Baltimore by Type",
      facets = Type~. , geom = "line")
## using smooth and actual points
NEIBaltimore$Type <-as.factor(NEIBaltimore$type)
qplot(year, Emissions, data = NEIBaltimore, ylab = "Total PM2.5 Emissions (tons)" , main = "Total PM25 Baltimore by Type",
      facets = Type~. , alpha = .1) ### , geom_Smooth(method = "m"))


