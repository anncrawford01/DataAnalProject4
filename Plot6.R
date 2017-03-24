##Plot6.
## Compare emissions from motor vehicle sources in Baltimore City fips == "24510" 
## with emissions from motor vehicle sources 
## in Los Angeles County, California (fips == "06037").
## Which city has seen greater changes over time in motor vehicle emissions?

## emissions https://www.epa.gov/air-emissions-inventories
## documentation of data https://www.epa.gov/air-emissions-inventories/national-emissions-inventory-nei

## Compare emissions from motor vehicle sources in Baltimore City fips == "24510" 
## with emissions from motor vehicle sources 
## in Los Angeles County, California (fips == "06037").
## Which city has seen greater changes over time in motor vehicle emissions?

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

##table(NEI$year)
## number of observations per year
##1999        2002           2005      2008 
##1,108,469   1,698,677   1,713,850   1,976,655 

## No missing  values
##sapply(NEI, function(x) mean(is.na(x)))

##emissions from motor vehicle source
Mobile <- SCC[grep("Mobile", SCC$EI.Sector),] 
Vehicle <- Mobile[grep("Vehicles", Mobile$SCC.Level.Two),] 
VehicleEmission <-merge(Vehicle, NEI, by = "SCC")



VehicleEmission <-transform(VehicleEmission, year = factor(year) )

VehicleEmissionBaltLA <-subset(VehicleEmission, fips == "24510" | fips == "06037" ) 
##VehicleEmissionLA <- subset(VehicleEmission, fips == "06037" )



###Box plot
## http://t-redactyl.io/blog/2016/04/creating-plots-in-r-using-ggplot2-part-10-boxplots.html
##p <- ggplot(VehicleEmissionBaltLA , aes(x=year, y=log10(Emissions)) ) + geom_boxplot() 
##p <-p  + facet_grid(SCC.Level.Two~ fips)
##p +  ggtitle("Vehicle Emissions Baltimore(24510) and Los Angeles(06037)") + ylab("PM2.5 Emissions")

##par(mfrow = c(1, 2), mar = c(4, 4, 2, 1))
p <- ggplot(VehicleEmissionBaltLA , aes(x=year, y=log10(Emissions)) ) + geom_boxplot() 
p <-p  + facet_grid(SCC.Level.Two~ fips)
p +  ggtitle("Vehicle Emissions Los Angeles(06037) and Baltimore(24510)") + ylab("PM2.5 Emissions")


dev.copy(png, file = "plot6.png")   ## copy to png file
dev.off()


