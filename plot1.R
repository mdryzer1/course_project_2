# Load libraries
library(dplyr)

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
png("plot1.png", width=800, height=800)

# 3. Group total NEI emissions per year and plot
total.emissions = summarise(group_by(NEI, year), Emissions=sum(Emissions))
colors = c("red", "green", "blue", "yellow")
x1 = barplot(height=total.emissions$Emissions/1000, names.arg=total.emissions$year,
            xlab="Years", ylab=expression('Total PM'[2.5]*' Emission in Kilotons'), ylim=c(0,8000),
            main=expression('Total PM'[2.5]*' Emissions at Various Years in Kilotons'), col=colors)

# 4. Add text at top of bars
text(x = x1, y = round(total.emissions$Emissions/1000,2), 
     label = round(total.emissions$Emissions/1000,2), pos = 3, 
     cex = 0.8, col = "black")

dev.off()