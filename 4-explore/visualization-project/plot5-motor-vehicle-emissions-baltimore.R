# Coursera - Exploratory Data Analysis
# Assignment 2 - Plot 5

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

# Load ggplot2 and dplyr packages.
library(ggplot2)
library(dplyr)

# Load data and convert to tbl objects.
NEI <- readRDS("summarySCC_PM25.rds") 
NEI <- tbl_df(NEI)

SCC <- readRDS("Source_Classification_Code.rds")
SCC <- tbl_df(SCC)


#5 How have emissions from motor vehicle sources changed 
# from 1999-2008 in Baltimore City? 

# Filter EI.Sector to obtain major sources of coal.
SCC.mobile <- SCC %>%
  filter(grepl('Mobile', EI.Sector))

# Filter for SCC codes which are contained in SCC.coal (keeping only coal related SCC's)
NEI.mobile <- NEI %>%
  filter(NEI$SCC %in% SCC.mobile$SCC)

mobileBaltimoreData <- subset(NEI.mobile, fips == "24510")

# Create Plot 5
# Assign screen device as png file with width 480 and height 480.

png(file = "plot5-motor-vehicle-emissions-baltimore.png",
    width = 480, height = 480
) 

ggplot(mobileBaltimoreData, aes(factor(year), Emissions)) + 
  geom_bar(stat = "identity") +
  labs(title = "Total Emissions from Motor Vehicles in Baltimore City") +
  labs(x = "Year") +
  labs(y = "Total PM2.5 Emissions (tons)")

dev.off() # close png device
