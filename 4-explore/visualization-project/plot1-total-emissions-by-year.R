# Coursera - Exploratory Data Analysis
# Assignment 2 - Plot 1

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


# 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

# Create a vector containing total Emissions per year.
# Use this vector to create a barplot.

options(scipen=999) # Turn off scientific notation.

# Create Plot 1 
# Assign screen device as png file with width 480 and height 480.

png(file = "plot1-total-emissions-by-year.png",
    width = 480, height = 480
) 

sumEmissionsByYear <- NEI %>%
  select(Emissions, year) %>%
  group_by(year) %>%
  summarise(sumEmissions = sum(Emissions))

barplot(sumEmissionsByYear$sumEmissions/1000000,
        names = sumEmissionsByYear$year,
        main  = "Total PM2.5 Emissions per Year",
        xlab  = "Year",
        ylab  = "Total PM2.5 Emissions (millions of tons)",
        ylim  = c(0, 8),
        col   = "thistle1")


dev.off() # close png device


'''
# Alternative Method using tapply

sumEmissionsByYear <- tapply(NEI$Emissions, NEI$year, sum)
barplot(sumEmissionsByYear,
        main = "Total PM2.5 Emissions per Year",
        xlab = "Year",
        ylab = "Total PM2.5 Emissions in tons",
        ylim = c(0, 8000000),
        col = "thistle1")
'''
