##Plot 1
## emissions https://www.epa.gov/air-emissions-inventories
## documentation of data https://www.epa.gov/air-emissions-inventories/national-emissions-inventory-nei

##Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

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

#SCC explains the source of emissions. 
# get coal sector
coalSector <- SCC[grep("coal", SCC$EI.Sector, ignore.case = TRUE),] 
coalCombustion <- coalSector[grep("combustion", coalSector$SCC.Level.One, ignore.case = TRUE),]
table(coalCombustion$SCC.Level.One)   ## this shows two level one values External Combustion Boilers  and Stationary Source Fuel Combustion
coalCombustionEmmission <-merge(coalCombustion, NEI, by.x = "SCC", by.y = "SCC")


# Calculate totals of all Emissions for each year
TotalPollution <- ddply(NEIBaltimore, .(year, type), summarise,
             totalemit = sum(Emissions, na.rm = TRUE))
TotalPollution$Type <-as.factor(TotalPollution$type)
# Plot a line chart of the result
 p <- ggplot(coalCombustionEmmission,  aes( Emissions) )
 p + geom_boxplot()  ##, ylab = "Total PM2.5 Emissions (tons)" ,xlab = "year"

      
## using facets
qplot( year, Emissions, data = coalCombustionEmmission, ylab = "Total PM2.5 Emissions (tons)" , main = "Total PM25 Baltimore by Type",
      facets = SCC.Level.One~. , geom="line")
## using smooth and actual points
NEIBaltimore$Type <-as.factor(NEIBaltimore$type)
qplot(year, Emissions, data = NEIBaltimore, ylab = "Total PM2.5 Emissions (tons)" , main = "Total PM25 Baltimore by Type",
      facets = Type~. , alpha = .1) ### , geom_Smooth(method = "m"))



