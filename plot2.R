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
png("plot2.png", width=800, height=800)

# 3. Group Baltimore NEI emissions by year and plot
bmore.emissions<-summarise(group_by(filter(NEI, fips == "24510"), year), 
                           Emissions=sum(Emissions))
colors = c("red", "green", "blue", "yellow")
x1 = barplot(height=bmore.emissions$Emissions/1000, names.arg=bmore.emissions$year,
            xlab="years", ylab=expression('Total PM'[2.5]*' Emission in Kilotons'), ylim=c(0,4),
            main=expression('Total PM'[2.5]*' Emissions in Baltimore City-MD in Kilotons'), col=colors)

# 4. Add text to the top of the bars
text(x = x1, y = round(bmore.emissions$Emissions/1000,2), 
     label = round(bmore.emissions$Emissions/1000,2), pos = 3, 
     cex = 0.8, col = "black")

dev.off()