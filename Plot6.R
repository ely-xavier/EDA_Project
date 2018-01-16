## Ely X. Colon
## Project submission

## This first line will likely take a few seconds. Be patient!

if(!exists("NEI")){
        NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
        SCC <- readRDS("./data/Source_Classification_Code.rds")
}

## merge the two data sets 

if(!exists("NEISCC")){
        NEISCC <- merge(NEI, SCC, by="SCC")
}

library(ggplot2)

## Compare emissions from motor vehicle sources in Baltimore City with emissions from motor 
## vehicle sources in Los Angeles County, California (fips == "06037"). 
## Which city has seen greater changes over time in motor vehicle emissions?

## Baltimore, MD = 24510, LA, CA = 06037
## Searching for ON-ROAD type in NEI

subsetNEI <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD",  ]

aggregatedTotalByYearAndFips <- aggregate(Emissions ~ year + fips, subsetNEI, sum)
aggregatedTotalByYearAndFips$fips[aggregatedTotalByYearAndFips$fips=="24510"] <- "Baltimore, MD"
aggregatedTotalByYearAndFips$fips[aggregatedTotalByYearAndFips$fips=="06037"] <- "Los Angeles, CA"

png("plot6.png", width=1040, height=480)
p <- ggplot(aggregatedTotalByYearAndFips, aes(factor(year), Emissions))
p <- p + facet_grid(. ~ fips)
p <- p + geom_bar(stat="identity")  +
        xlab("year") +
        ylab(expression('Total PM'[2.5]*" emissions")) +
        ggtitle('Total emissions from motor vehicle (type=ON-ROAD) in Baltimore City, MD (fips = "24510") vs LA, CA (fips = "06037")  1999-2008')
print(p)
dev.off()