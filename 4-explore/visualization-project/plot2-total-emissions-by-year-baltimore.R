# Coursera - Exploratory Data Analysis
# Assignment 2 - Plot 2

#Kie Gouveia

# Project Goal
# The overall goal of this assignment is to explore the National Emissions 
# Inventory database and see what it says about fine particulate matter pollution 
# in the United states over the 10-year period 1999-2008. 

# Assign url to fileUrl.
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

# Check to see if file is already in working directory, if not, download and unzip.
if(!file.exists("./FNEI_data.zip")){
  download.file(fileUrl, "./projectdataset.zip")
  unzip("projectdataset.zip")
}

# Load ggplot2 and dplyr packages (install if not already present)
if("ggplot2" %in% rownames(installed.packages()) == FALSE) {install.packages("ggplot2")}
if("dplyr" %in% rownames(installed.packages()) == FALSE) {install.packages("dplyr")}

library(ggplot2)
library(dplyr)

# Load data and convert to tbl objects.
NEI <- readRDS("summarySCC_PM25.rds") 
NEI <- tbl_df(NEI)

SCC <- readRDS("Source_Classification_Code.rds")
SCC <- tbl_df(SCC)

#2. Have total emissions from PM2.5 decreased in the Baltimore City, 
# Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question. 


# Create Plot 2 
# Assign screen device as png file with width 480 and height 480.

png(file = "plot2-total-emissions-by-year-baltimore.png",
    width = 480, height = 480
) 

sumEmissionsByYearBalt <- NEI %>%
  select(fips, Emissions, year) %>%
  filter(fips == "24510") %>%
  group_by(year) %>%
  summarise(sumEmissions = sum(Emissions))

barplot(sumEmissionsByYearBalt$sumEmissions,
        names = sumEmissionsByYearBalt$year,
        main  = "Total PM2.5 Emissions in Baltimore",
        xlab  = "Year",
        ylab  = "Total PM2.5 Emissions in tons",
        col   = "thistle1")

dev.off() # close png device


'''
# Alternative using subset and tapply

# Create a vector containing total Emissions per year in Balitmore.
# Use this vector to create a barplot
BaltimoreData <- subset(NEI, fips == "24510")  # Subset for Baltimore Data

heightsBalt <- tapply(BaltimoreData$Emissions, BaltimoreData$year, sum)

barplot(heightsBalt,
        main = "Total PM2.5 Emissions in Baltimore",
        xlab = "Year",
        ylab = "Total PM2.5 Emissions in tons",
        col = "blue")

'''