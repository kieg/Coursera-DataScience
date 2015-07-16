# Coursera - Exploratory Data Analysis
# Assignment 2 - Plot 4

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


# 4. Across the United States, how have emissions from 
# coal combustion-related sources changed from 1999-2008?


# Filter EI.Sector to obtain major sources of coal.
SCC.coal <- SCC %>%
  filter(grepl('[Cc]oal', EI.Sector))

# Filter for SCC codes which are contained in SCC.coal (therefore 
# keeping only coal related SCC's)
NEI.coal <- NEI %>%
  filter(NEI$SCC %in% SCC.coal$SCC)


# Create Plot 4 
# Assign screen device as png file with width 480 and height 480.

png(file = "plot4-total-emissions-coal.png",
    width = 480, height = 480
    ) 

ggplot(NEI.coal, aes(factor(year), Emissions/100000)) + 
  geom_bar(stat = "identity", color = "chocolate1") +
  labs(title = "Total PM2.5 Emissions from Coal Combustion Sources") +
  labs(x = "Year") +
  labs(y = "Total PM2.5 Emissions (100,000's of tons)")

dev.off() # close png device
