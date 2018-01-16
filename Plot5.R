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

## How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

## Baltimore's fips = 24510 
## Searching for ON-ROAD type in NEI
## Don't actually know it this is the intention, but searching for 'motor' in SCC only gave 
## a subset (non-cars)

subsetNEI <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ]

aggregatedTotalbyYear <- aggregate(Emissions ~ year, subsetNEI, sum)

png("plot5.png", width=840, height=480)
p <- ggplot(aggregatedTotalbyYear, aes(factor(year), Emissions))
p <- p + geom_bar(stat="identity") +
        xlab("year") +
        ylab(expression('Total PM'[2.5]*" Emissions")) +
        ggtitle('Total emissions from motor vehicle (type = ON-ROAD) in Baltimore City, MD (fips = "24510") from 1999 to 2008')
print(p)
dev.off()