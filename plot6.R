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
png('plot6.png', width=800, height=800)

# 3. Get emissions data for Baltimore and LA
bmore.emissions = summarise(group_by(filter(NEI, fips == '24510' & type == 'ON-ROAD'), 
                                    year), Emissions=sum(Emissions))
la.emissions = summarise(group_by(filter(NEI, fips == '06037' & type == 'ON-ROAD'), 
                                  year), Emissions=sum(Emissions))

# 4. Update county names and combine emissions data
bmore.emissions$County = 'Baltimore City, MD'
la.emissions$County = 'Los Angeles County, CA'
both.emissions = rbind(bmore.emissions, la.emissions)

# 5. Plot
ggplot(both.emissions, aes(x=factor(year), y=Emissions, fill=County,
                           label = round(Emissions,2))) +
    geom_bar(stat='identity') + 
    facet_grid(County~., scales='free') +
    ylab(expression('Total PM"[2.5]*" Emissions in Tons')) + 
    xlab('year') +
    ggtitle(expression('Motor Vehicle Emission Variation in Baltimore and Los Angeles in Tons')) +
    geom_label(aes(fill = County),colour = 'white', fontface = 'bold')

dev.off()