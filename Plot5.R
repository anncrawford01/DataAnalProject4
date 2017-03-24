##Plot5.R
##How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?


## Ann Crawford
## 3/22/2017
## Coursera Exploratory Data Analysis 

## emissions https://www.epa.gov/air-emissions-inventories
## documentation of data https://www.epa.gov/air-emissions-inventories/national-emissions-inventory-nei

## grammar of graphics data to asesthetic
## geom, coordin, data, asestheics
## Dependencies
library(plyr)
##install.packages("ggplot2")
library(ggplot2)

## http://stackoverflow.com/questions/8305754/remove-all-variables-except-functions
rm(list = setdiff(ls(), lsf.str()))

# This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/source_Classification_Code.rds")
# NEI has 6,497,651 observations with 6 columns

# get the total Emissions for Each year

##table(NEI$year)
## number of observations per year
##1999        2002           2005      2008 
##1,108,469   1,698,677   1,713,850   1,976,655 

Mobile <- SCC[grep("Mobile", SCC$EI.Sector),] 
Vehicle <- Mobile[grep("Vehicles", Mobile$SCC.Level.Two),] 
VehicleEmission <-merge(Vehicle, NEI, by = "SCC")

VehicleEmissionDiesel <-VehicleEmission[grep("Diesel")]
VehicleEmission <-transform(VehicleEmission, year = factor(year) )

###Box plot
## http://t-redactyl.io/blog/2016/04/creating-plots-in-r-using-ggplot2-part-10-boxplots.html
## http://docs.ggplot2.org/current/geom_boxplot.html
##p <- ggplot(VehicleEmission, aes(x=year, y=log10(Emissions)), ylab = "year") + geom_boxplot() 
##p  + facet_grid( SCC.Level.Two ~ year)

## use color instead of facet
p <- ggplot(VehicleEmission, aes(x=year, y=log10(Emissions)), ylab = "year") + geom_boxplot(aes(colour =  SCC.Level.Two, notch = TRUE ))
p +  ggtitle("Vehicle Emissions Baltimore") + ylab("PM2.5 Emissions")

dev.copy(png, file = "plot5.png")   ## copy to png file
dev.off()
