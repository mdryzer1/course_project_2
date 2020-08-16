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
png('plot5.png', width=800, height=800)

# 3. Extract motor emissions and group them by year
bmore.emissions = NEI[(NEI$fips=='24510') & (NEI$type=='ON-ROAD'),]
bmore.emissions.byyear = summarise(group_by(bmore.emissions, year), 
                                   Emissions=sum(Emissions))

# 4. Plot
ggplot(bmore.emissions.byyear, aes(x=factor(year), y=Emissions,fill=year, 
                                   label = round(Emissions,2))) +
    geom_bar(stat='identity') +
    xlab('year') +
    ylab(expression('Total PM"[2.5]*" Emissions in Tons')) +
    ggtitle('Emissions From Motor Vehicle Sources in Baltimore City') +
    geom_label(aes(fill = year),colour = "white", fontface = "bold")

dev.off()