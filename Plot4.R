##Plot 1
## emissions https://www.epa.gov/air-emissions-inventories
## documentation of data https://www.epa.gov/air-emissions-inventories/national-emissions-inventory-nei

##Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

## fips  first two digits are for the State and the last three identify the County
## https://catalog.data.gov/dataset/fips-state-codes
## grammar of graphics data to asesthetic
## geom, coordin, data, asestheics
## Dependencies
##library(plyr)
##install.packages("ggplot2")

##library(ggplot2)
## remove all variables except functions
## http://stackoverflow.com/questions/8305754/remove-all-variables-except-functions
rm(list = setdiff(ls(), lsf.str()))


# This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/source_Classification_Code.rds")
# NEI has 6,497,651 observations with 6 columns

#SCC explains the source of emissions. 
# get coal sector
coalSector <- SCC[grep("coal", SCC$EI.Sector, ignore.case = TRUE),] 
coalCombustion <- coalSector[grep("combustion", coalSector$SCC.Level.One, ignore.case = TRUE),]
##table(coalCombustion$SCC.Level.One)   ## this shows two level one values External Combustion Boilers  and Stationary Source Fuel Combustion
coalCombustionEmission <-merge(coalCombustion, NEI, by.x = "SCC", by.y = "SCC")

## this shows a max of 14274.48, min = 0 and median = 70.75 - it is very skewed 
## summary(coalCombustionEmission)


## using facets
qplot( year, Emissions, data = coalCombustionEmission ,xlab = "Year" , ylab = "Total PM2.5 Emissions (tons)" , main = "U.S. Coal Combustion Emissions",
    facets = SCC.Level.One~. , geom="point")
qplot( fips, Emissions, data = coalCombustionEmission ,xlab = "state" , ylab = "Total PM2.5 Emissions (tons)" , main = "U.S. Coal Combustion Emissions",
       facets = SCC.Level.One~. , geom="point")


