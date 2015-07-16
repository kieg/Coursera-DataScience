# Coursera - Exploratory Data Analysis
# Assignment 2 - Plot 6

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


# 6. Compare emissions from motor vehicle sources in 
# Baltimore City with emissions from motor vehicle sources 
# in Los Angeles County, California (fips == "06037"). Which 
# city has seen greater changes over time in motor vehicle 
# emissions?

NEI.mobile <- NEI %>%
  filter(NEI$SCC %in% SCC.mobile$SCC)

mobileData <- subset(NEI.mobile, fips == "24510" | fips == "06037")

# Rename fips to city names for clarity.
factor_map <- mobileData$fips
mobileData$fips <- factor(factor_map, labels = c("Los Angeles County", "Baltimore City"))

levels(mobileData$fips) <- c("Los Angeles County", "Baltimore City")


# Compute percentage change in Emissions in Baltimore

baltChange <- mobileData %>%
  group_by(year)%>%
  filter(fips == "Baltimore City") %>%
  summarize(Emissions = sum(Emissions)) %>%
  mutate(e_delta = Emissions/lag(Emissions))

# Computer percentage change in Emissions in LA County

laChange <- mobileData %>%
  group_by(year)

laChange <- mobileData %>%
  group_by(year)%>%
  filter(fips == "Los Angeles County") %>%
  summarize(Emissions = sum(Emissions)) %>%
  mutate(e_delta = Emissions/lag(Emissions))

# Add back city names and merge.

baltChange <- cbind(baltChange, city = rep("Baltimore City", nrow(baltChange)))
baltChange[1,3] <- 1 # Set equal to one for no change

laChange <- cbind(laChange, city = rep("Los Angeles County", nrow(laChange)))
laChange[1,3] <- 1 # Set equal to one for no change

emissionDelta <- rbind(baltChange, laChange)

# Create Plot 6
# Assign screen device as png file with width 480 and height 480.

png(file = "plot6-total-motor-emissions-la-baltimore.png",
    width = 480, height = 480
) 

ggplot(emissionDelta, aes(x = year, e_delta * 100, fill = city)) + 
  geom_line(aes(color = city)) +
  labs(title = "Total Motor Vehicle Emissions in LA County and Baltimore City") +
  labs(x = "Year") +
  labs(y = "Change in PM2.5 Emissions (%)")

dev.off() # close png device

