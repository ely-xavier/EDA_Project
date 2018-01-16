## Ely X. Colon
## Project submission

## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
        NEI <- readRDS("./summarySCC_PM25.rds")
}
if(!exists("SCC")){
        SCC <- readRDS("./Source_Classification_Code.rds")
}

## merge the two data sets 
if(!exists("NEISCC")){
        NEISCC <- merge(NEI, SCC, by="SCC")
}

library(ggplot2)

## Across the United States, how have emissions from coal combustion-related sources changed 
## from 1999-2008?

## fetch all NEIxSCC records with Short.Name (SCC) Coal
coalMatches  <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
subsetNEISCC <- NEISCC[coalMatches, ]

aggregatedTotalbyYear <- aggregate(Emissions ~ year, subsetNEISCC, sum)



png("plot4.png", width=640, height=480)
p <- ggplot(aggregatedTotalbyYear, aes(factor(year), Emissions))
p <- p + geom_bar(stat="identity") +
        xlab("year") +
        ylab(expression('Total PM'[2.5]*" emissions")) +
        ggtitle('Total emissions from coal sources from 1999 to 2008')
print(p)
dev.off()