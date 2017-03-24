##Plot4.R
##Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?


## Ann Crawford
## 3/22/2017
## Coursera Exploratory Data Analysis 

## emissions https://www.epa.gov/air-emissions-inventories
## documentation of data https://www.epa.gov/air-emissions-inventories/national-emissions-inventory-nei
## fips  first two digits are for the State and the last three identify the County
## https://catalog.data.gov/dataset/fips-state-codes
## grammar of graphics data to asesthetic
## geom, coordin, data, asestheics

## Dependencies
##library(plyr)
library(dplyr)
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



coalCombustionEmission$statecode = substr(coalCombustionEmission$fips, 1,2)
##coalCombustionEmission1999 <- subset(coalCombustionEmission, year == 1999)
##coalCombustionEmission2008 <- subset(coalCombustionEmission, year == 2008)

##summary(unique(coalCombustionEmission1999$statecode))  ## 49 states
##summary(unique(coalCombustionEmission2008$statecode))  ## 51 states 


## dply r https://cran.r-project.org/web/packages/dplyr/vignettes/introduction.html
coalCombustionEmission1999 <- coalCombustionEmission %>% select(year, Emissions, statecode)  %>% filter(year == 1999) 
coalCombustionEmission2008 <- coalCombustionEmission %>% select(year, Emissions, statecode)  %>% filter(year == 2008)

## get the mean for each state 
meanbyState1999 <- with(coalCombustionEmission1999, tapply(Emissions, statecode, mean, na.rm = TRUE) )
meanbyState2008 <- with(coalCombustionEmission2008, tapply(Emissions, statecode, mean, na.rm = TRUE) )

## create statecode data frame
df1999 <- data.frame(statecode = names(meanbyState1999), mean = meanbyState1999) 
df2008 <- data.frame(statecode = names(meanbyState2008), mean = meanbyState2008) 

coalStateEmissions <- merge(df1999, df2008, by = "statecode")

##coalCombustionEmission <-transform(coalCombustionEmission, year = factor(year) )
##boxplot(log10(Emissions)~year, coalCombustionEmission)
## using facets
##qplot( fips, Emissions, data = coalCombustionEmission ,xlab = "state" , ylab = "Total PM2.5 Emissions (tons)" , main = "U.S. Coal Combustion Emissions",
  ##     facets = SCC.Level.One~. , geom="point")

##http://docs.ggplot2.org/current/geom_boxplot.html
plot(rep(1999,48), coalStateEmissions[,2] ,data = coalStateEmissions , xlim = c(1997, 2009), main = "state coal", xlab = "year" , ylim = c(300,1000)) 
 points(rep(2008,48), coalStateEmissions[,3], data = coalStateEmissions ) 
 segments(rep(1999,48), coalStateEmissions[,2] , rep(2008,48), coalStateEmissions[,3] )
 
 plot(rep(1999,48), coalStateEmissions[,2] ,data = coalStateEmissions , xlim = c(1997, 2009), main = "state coal", xlab = "year" , ylim = c(0,300)) 
 points(rep(2008,48), coalStateEmissions[,3], data = coalStateEmissions ) 
 segments(rep(1999,48), coalStateEmissions[,2] , rep(2008,48), coalStateEmissions[,3] )

