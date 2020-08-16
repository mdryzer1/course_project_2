# Load libraries
library(dplyr)
library(ggplot2)

# Set the working directory
data_dir = paste('C:/Users/mdryz/Desktop/Code/R Projects/',
                 'Coursera Data Science Course Projects/Data/Course 4', sep='')
setwd(data_dir)

# Read in data files
# 1. Read in the national emissions data
NEI = readRDS('summarySCC_PM25.rds')

# 2. read source code classification data
SCC = readRDS('Source_Classification_Code.rds')

# Make the plot and export it
# 1. Change the working directory for exporting output
output_dir = paste('C:/Users/mdryz/Desktop/Code/R Projects/',
                   'Coursera Data Science Course Projects/Output/',
                   'Course 4/course_project_2', sep='')
setwd(output_dir)

# 2. Initialize
png("plot4.png", width=800, height=800)

# 3. Extract relevant combustion data
combustion.coal = grepl('Fuel Comb.*Coal', SCC$EI.Sector)
combustion.coal.sources = SCC[combustion.coal,]

# 4. Find emissions from coal combustion-related sources
emissions.coal.combustion = NEI[(NEI$SCC %in% combustion.coal.sources$SCC), ]
emissions.coal.related = summarise(group_by(emissions.coal.combustion, year), Emissions=sum(Emissions))

# 5. Plot
ggplot(emissions.coal.related, aes(x=factor(year), y=Emissions/1000,fill=year, 
                                   label = round(Emissions/1000,2))) +
    geom_bar(stat='identity') +
    xlab('year') +
    ylab(expression('Total PM"[2.5]*" Emissions in Kilotons')) +
    ggtitle("Emissions From Coal Combustion-Related Sources in Kilotons")+
    geom_label(aes(fill = year),colour = "white", fontface = "bold")

dev.off()