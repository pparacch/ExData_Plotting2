library(ggplot2) #load ggplot2 package for the plotting

## Read the datasource
#Assumption: 
#the files are located in the current workind directory together with the script
NEI <- readRDS("summarySCC_PM25.rds")

#Relevant Question (Question 3)
#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad)
#variable, 

# Which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
# Which have seen increases in emissions from 1999–2008? 

#Subsetting original data in order to consider only Baltimore relevant data.
NEI_baltimore <- subset(NEI, fips == "24510")

#type values
#unique(NEI_baltimora$type)
#[1] "POINT"    "NONPOINT" "ON-ROAD"  "NON-ROAD"
#Aggregate the baltimora data by year &  types 

NEI_baltimore_aggregate <- aggregate(NEI_baltimore$Emissions, list(Year = NEI_baltimore$year, Type = NEI_baltimore$type), sum)
names(NEI_baltimore_aggregate) <- c("Year", "Type", "TotalEmissions")

#Use the ggplot2 plotting system to make a plot answer this question.
g <- ggplot(NEI_baltimore_aggregate, aes(Year, TotalEmissions))
p <- g + geom_point(aes(color = Type)) + 
        facet_grid(. ~ Type) + 
        geom_line(linetype=3) +
        labs(x = "Year") +
        labs(y = "Total Emission (ton)") + 
        labs(title = "PM2.5 per Year in Baltimore City, Maryland")
print(p)
#Save the plot as a png using ggsave{ggplot2}
ggsave("plot3.png")

#Answer
#The total emission of PM2.5 in Baltimore City, Maryland has the following trends 
#from 1999 to 2008

#NON-ROAD -> decreased from 522.94 ton (1999) to 55.82356 ton (2008)
#NONPOINT -> decreased from 2107.625 ton (1999) to 1373.207 ton (2008)
#ON-ROAD -> decreased from 346.82 ton (1999) to 88.27546 ton (2008)
#POINT -> increased from 296.7950 ton (1999) to 344.9752 ton (2008)
