## Read the datasource
#Assumption: 
#the files are located in the current workind directory together with the script
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Relevant Question (Question 4)
#Across the United States, how have emissions from coal combustion-related sources 
#changed from 1999–2008?

#Get all the sources connected to Coal subsetting SCC
#subsetting is done looking for the "Coal" keyword in the source Short.Name
SCC_coal <- SCC[grep("Coal", SCC$Short.Name),] #230 sources related to Coal

#Get all of the data connected to source related to coal
NEI_coal <- NEI[which(NEI$SCC %in% SCC_coal$SCC),]

#Aggregate the SUM of emissions by Year
NEI_coal_aggregate <- aggregate(NEI_coal$Emissions, list(Year = NEI_coal$year), sum)
names(NEI_coal_aggregate) <- c("Year", "TotalEmissions")

#Scaling down values by 1000 - Total Emission is in 1000 ton now
NEI_coal_aggregate$TotalEmissions <- NEI_coal_aggregate$TotalEmissions / 1000

#Being a simple plot - Use the base plotting system to make a plot answer this question.
png("plot4.png", width = 480, height = 480, units = "px", bg = "transparent")
plot(NEI_coal_aggregate$Year, NEI_coal_aggregate$TotalEmissions, 
     type = "b", 
     main = "PM2.5 (coal-combustion sources) per Year across US", 
     xlab = "Year", 
     ylab="Total Emissions (1000 tons)")
dev.off()

#Answer
#The total emission of PM2.5 (coal-combustion sources) across the United States has decreased 
#from 596.6879 x 1000 ton (1999) to 355.9677 x 1000 ton (2008)

# Total PM2.5 Emission (coal-combustion sources) in 1000 tons per Year across US
#Year TotalEmissions
# 1999       596.6879
# 2002       561.1747
# 2005       566.7009
# 2008       355.9677