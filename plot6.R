## Read the datasource
#Assumption: 
#the files are located in the current workind directory together with the script
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Relevant Question (Question 6)
#Compare emissions from motor vehicle sources in Baltimore City with emissions 
#from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?

#Subsetting original data 
#Baltimore (fips == "24510") relevant data.
NEI_baltimore <- subset(NEI, fips == "24510")
#Los Angeles County, California (fips == "06037") relevant data.
NEI_lac <- subset(NEI, fips == "06037")

#Get all the sources connected to motor vehicle sources subsetting SCC
#Criteria: searching for the "Vehicle" keyword in the source Short.Name
SCC_veh <- SCC[grep("Vehicle", SCC$Short.Name),] #260 sources related to Vehicle Sources

#Get all of the data connected to source related to vehicle for Baltimore
NEI_baltimore_veh <- NEI_baltimore[which(NEI_baltimore$SCC %in% SCC_veh$SCC),]

#Get all of the data connected to source related to vehicle for Loas Angeles County
NEI_lac_veh <- NEI_lac[which(NEI_lac$SCC %in% SCC_veh$SCC),]


#Aggregate the SUM of emissions by Year
NEI_baltimore_veh_aggregate <- aggregate(NEI_baltimore_veh$Emissions, list(Year = NEI_baltimore_veh$year), sum)
names(NEI_baltimore_veh_aggregate) <- c("Year", "TotalEmissions")

NEI_lac_veh_aggregate <- aggregate(NEI_lac_veh$Emissions, list(Year = NEI_lac_veh$year), sum)
names(NEI_lac_veh_aggregate) <- c("Year", "TotalEmissions")


#Being a simple plot - Use the base plotting system to make a plot answer this question.
png("plot6.png", width = 480, height = 480, units = "px", bg = "transparent")
plot(NEI_baltimore_veh_aggregate$Year, NEI_baltimore_veh_aggregate$TotalEmissions, 
     type = "b",
     pch = 4,
     col = "blue",
     main = "PM2.5 (motor vehicle sources) per Year", 
     xlab = "Year", 
     ylab="Total Emissions (ton)",
     ylim = c(0, 1500))
points(NEI_lac_veh_aggregate$Year, NEI_lac_veh_aggregate$TotalEmissions, 
       col = "red", 
       type = "b",
       pch = 5)
legend("topright", 
       pch = c(4, 5), 
       lwd = 1, 
       col = c("blue", "red"), 
       legend = c("Baltimore City, Maryland", "Los Angeles County, California"))
dev.off()

#Answer
#Los Angeles County, California is the city that has gone through greater changes over time
#looking at the totale emissions (PM2.5) between 1999 and 2008.

#Total Emissions (motor vehicle sources) of PM2.5 (ton) in Baltimore City, Mariland per Year
# Year      TotalEmissions (ton)
# 1 1999       72.52000
# 2 2002       38.72593
# 3 2005       34.73461
# 4 2008       24.62275

#Total Emissions (motor vehicle sources) of PM2.5 (ton) in Los Angeles County, California per Year
# Year      TotalEmissions (ton)
# 1 1999      1474.3960
# 2 2002      1202.2272
# 3 2005      1206.4067
# 4 2008       952.3045