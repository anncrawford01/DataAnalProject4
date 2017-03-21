##Plot 5
## emissions https://www.epa.gov/air-emissions-inventories
## documentation of data https://www.epa.gov/air-emissions-inventories/national-emissions-inventory-nei

##How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

## grammar of graphics data to asesthetic
## geom, coordin, data, asestheics
## Dependencies
##library(plyr)
##install.packages("ggplot2")
##library(ggplot2)

## http://stackoverflow.com/questions/8305754/remove-all-variables-except-functions
rm(list = setdiff(ls(), lsf.str()))

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
##sapply(NEI, function(x) sum(is.na(x)))


Mobile <- SCC[grep("Mobile", SCC$EI.Sector),] 
Vehicle <- Mobile[grep("Vehicles", Mobile$SCC.Level.Two),] 
VehicleEmission <-merge(Vehicle, NEI, by = "SCC")

with(VehicleEmission, boxplot(log10(Emissions)~year) )

VehicleEmissionDiesel <-VehicleEmission[grep("Diesel")]

VehicleEmission <-transform(VehicleEmission, year = factor(year) )

# Calculate totals of all Emissions for each year
##TotalPollution <- ddply(VehicleEmission, .(year, type), summarise,
##            totalemit = sum(Emissions, na.rm = TRUE))
##TotalPollution$Type <-as.factor(VehicleEmission$SCC.Level.Two)

# Plot a line chart of the result
qplot(year, Emissions, data = VehicleEmission, ylab = "Total PM2.5 Emissions (tons)" , main =  "PM2.5 Vehicle Diesel and Gasloine ",
      color = SCC.Level.Two, geom = "point")


## using facets
qplot(year, Emissions, data = VehicleEmission, ylab = "Total PM2.5 Emissions (tons)" , main = "PM2.5 Vehicle Diesel and Gasloine ",
      facets = SCC.Level.Two~. , geom = "point")

###Box plot
## http://t-redactyl.io/blog/2016/04/creating-plots-in-r-using-ggplot2-part-10-boxplots.html

p <- ggplot(VehicleEmission, aes(x=year, y=log10(Emissions)) ) + geom_boxplot() 
       
p  + facet_grid(. ~ SCC.Level.Two)



