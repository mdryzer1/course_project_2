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
png("plot3.png", width=800, height=800)

# 3. Group total NEI emissions per year
bmore.emissions.byyear = summarise(group_by(filter(NEI, fips == "24510"), 
                                            year,type), Emissions=sum(Emissions))

# 4. Plot
ggplot(bmore.emissions.byyear, aes(x=factor(year), y=Emissions, fill=type,
                                   label = round(Emissions,2))) + 
    geom_bar(stat='identity') +
    facet_grid(. ~ type) +
    xlab('year') +
    ylab(expression('Total PM"[2.5]*" Emission in Tons')) +
    ggtitle(expression("PM"[2.5]*paste(" Emissions in Baltimore ",
                                       "City by Various Source Types", sep="")))+
    geom_label(aes(fill = type), colour = "white", fontface = "bold")

dev.off()