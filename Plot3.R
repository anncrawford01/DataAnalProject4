##Plot3.R
##  point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 
##  for Baltimore City? Which have seen increases in emissions from 1999–2008? 
##  Use the ggplot2 plotting system to make a plot answer this question.

## Ann Crawford
## 3/22/2017
## Coursera Exploratory Data Analysis 

##
## emissions https://www.epa.gov/air-emissions-inventories
## documentation of data https://www.epa.gov/air-emissions-inventories/national-emissions-inventory-nei

##http://ggplot2.org/
## grammar of graphics data to asesthetic
## geom, coordin, data, asestheics
## Dependencies
library(plyr)
##install.packages("ggplot2")
library(ggplot2)

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

## check for any missing  values
##sapply(NEI, function(x) sum(is.na(x)))

NEIBaltimore <- subset(NEI, fips == "24510")   ##im = 2096    7
NEIBaltimore <-transform(NEIBaltimore, year = factor(year) )

# Calculate totals of all Emissions for each year
TotalPollution <- ddply(NEIBaltimore, .(year, type), summarise,
             totalemit = sum(Emissions, na.rm = TRUE))
TotalPollution$Type <-as.factor(TotalPollution$type)


## using facets
##qplot(year, totalemit, data = TotalPollution, ylab = "Total PM2.5 Emissions (tons)" , main = "Total PM2.5 Baltimore by Type",
 ##     facets = Type~. , geom = "line")


p <- ggplot(data = TotalPollution, aes(x = year, y = totalemit))
p <- p  + facet_grid(Type ~.) + geom_col(width = 0.5) 
p + ggtitle("Total PM2.5 Baltimore by Type") +  labs(x="Year", y=" PM2.5 Emissions (tons)" ) 

dev.copy(png, file = "plot3.png")   ## copy to png file
dev.off()


