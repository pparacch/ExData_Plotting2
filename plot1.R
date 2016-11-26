## Read the datasource
#Assumption: 
#the files are located in the current workind directory together with the script
NEI <- readRDS("summarySCC_PM25.rds")

#Relevant Question
#Have total emissions from PM2.5 decreased in the United States from 
#1999 to 2008? 

#Lets use tapply to calculate the total of PM2.5 emission per year
total_emission_by_year <- tapply(NEI$Emissions, NEI$year, sum)
x <- dimnames(total_emission_by_year)[[1]]#the x axis: the years
y <- as.vector(total_emission_by_year)/ 1000#the yaxis: total emissions by year in kilo tons

#Using the base plotting system, make a plot showing the 
#total PM2.5 emission from all sources for each of the years 1999, 2002, 2005,
#and 2008.
png("plot1.png", width = 480, height = 480, units = "px", bg = "transparent")
plot(x, y, type = "b", 
     main = "PM2.5 per Year in the United States", 
     xlab = "Year", 
     ylab="Total Emissions (1000 tons)")
dev.off()
#Answer
#The totale emission (PM2.5) in the United States has decreased 
#from 7332967 tons (1999) to 3464206 tons (2008).

# Total emission of PM2.5 per year in tons
# 1999    2002    2005    2008 
# 7332967 5635780 5454703 3464206 
