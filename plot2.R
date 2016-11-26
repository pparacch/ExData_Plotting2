## Read the datasource
#Assumption: 
#the files are located in the current workind directory together with the script
NEI <- readRDS("summarySCC_PM25.rds")

#Relevant Question (Question 2)
#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
#(fips == "24510") from 1999 to 2008? 

#Subsetting original data in order to consider only Baltimore relevant data.
NEI_baltimore <- subset(NEI, fips == "24510")

#Lets use tapply to calculate the total of PM2.5 emission per year
total_emission_by_year <- tapply(NEI_baltimore$Emissions, NEI_baltimore$year, sum)
x <- dimnames(total_emission_by_year)[[1]]#the x axis: the years
y <- as.vector(total_emission_by_year)#the yaxis: total emissions by year in tons

#Use the base plotting system to make a plot answering this question.
png("plot2.png", width = 480, height = 480, units = "px", bg = "transparent")
plot(x, y, type = "b", 
     main = "PM2.5 per Year in Baltimore City, Maryland", 
     xlab = "Year", 
     ylab="Total Emissions (tons)")
dev.off()

#Answer
#The total emission of PM2.5 in Baltimore City, Maryland has decreased 
#from 1999 to 2008

# Total PM2.5 Emission in tons in Baltimora City (Maryland) per Year
#   1999     2002     2005     2008 
# 3274.180 2453.916 3091.354 1862.282

