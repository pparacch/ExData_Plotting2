## Read the datasource
#Assumption: 
#the files are located in the current workind directory together with the script
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Relevant Question (Question 5)
#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

#Subsetting original data in order to consider only Baltimore (fips == "24510") relevant data.
NEI_baltimore <- subset(NEI, fips == "24510")


#Get all the sources connected to motor vehicle sources subsetting SCC
#Criteria: searching for the "Vehicle" keyword in the source Short.Name
SCC_veh <- SCC[grep("Vehicle", SCC$Short.Name),] #260 sources related to Vehicle Sources

#Get all of the data connected to source related to vehicle for Baltimore
NEI_baltimore_veh <- NEI_baltimore[which(NEI_baltimore$SCC %in% SCC_veh$SCC),]

#Aggregate the SUM of emissions by Year
NEI_baltimore_veh_aggregate <- aggregate(NEI_baltimore_veh$Emissions, list(Year = NEI_baltimore_veh$year), sum)
names(NEI_baltimore_veh_aggregate) <- c("Year", "TotalEmissions")

#Being a simple plot - Use the base plotting system to make a plot answer this question.
png("plot5.png", width = 480, height = 480, units = "px", bg = "transparent")
plot(NEI_baltimore_veh_aggregate$Year, NEI_baltimore_veh_aggregate$TotalEmissions, 
     type = "b", 
     main = "PM2.5 (motor vehicle sources) per Year - Baltimore City, Maryland", 
     xlab = "Year", 
     ylab="Total Emissions (ton)")
dev.off()

#Answer
#The total emission of PM2.5 (motor vehicle sources) in Baltimore City (Maryland) has decreased 
#between 1999 and 2008 (see below)

# Total PM2.5 Emission (motor vehicle sources) per Year in Baltimore City (Maryland)
# Year      TotalEmissions (ton)
# 1 1999       72.52000
# 2 2002       38.72593
# 3 2005       34.73461
# 4 2008       24.62275