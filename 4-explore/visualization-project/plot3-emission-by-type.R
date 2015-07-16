# Coursera - Exploratory Data Analysis
# Assignment 2 - Plot 3

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


#3.Of the four types of sources indicated by the type 
# (point, nonpoint, onroad, nonroad) variable, which of 
# these four sources have seen decreases in emissions from 
# 1999-2008 for Baltimore City? Which have seen increases in 
# emissions from 1999-2008? Use the ggplot2 plotting system to 
# make a plot answer this question.

# Directly creating plot was a bit much for my computer.
# Use dplyr to create a vector of Total Emissions per Year,
# grouped by type.
# Used this vector, eVector, to chart results. 

eVector <- NEI %>%
  group_by(year,type)

eVector <- eVector %>%
  summarize(TotalEmissions = sum(Emissions))



# Create Plot 3 
# Assign screen device as png file with width 480 and height 480.

png(file = "plot3-emission-by-type.png",
    width = 960, height = 480
) 

g <- ggplot(eVector, 
       aes(x = year, y = TotalEmissions/1000000, fill = type)) + 
  geom_bar(stat = "identity") +
  geom_smooth(method = "lm", colour = "black") +
  labs(title = "Total PM2.5 Emissions by Type") +
  labs(y = "Total PM2.5 Emissions (millions of tons)") +
  scale_x_continuous(breaks=c(1999, 2002, 2005, 2008)
  )

g + facet_grid(. ~ type)

dev.off() # close png device
