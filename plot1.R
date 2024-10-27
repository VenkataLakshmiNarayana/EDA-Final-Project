#First let us extract the data from the file
data <- readRDS("summarySCC_PM25.rds")
#Now let us calculate the total PM2.5 emissions from the data for the years 1999, 2002, 2005, and 2008
plot_data <- aggregate((data$Emissions), by = list(data$year), FUN = sum)
#Now let us plot the data as per the requirements
#First let set Graphics device
png("plot1.png", width = 480, height = 480)
#Second let us Plot the bar plot graph on the device
barplot(plot_data$x/10^6, names.arg = plot_data$Group.1, col = "blue",
        main = "Total PM2.5 Emissions in the United States for the years
                1999, 2002, 2005, and 2008",
        xlab = "Year",
        ylab = "Total PM2.5 Emissions (in 10^6 tonnes)")
#Finally let us Close the device
dev.off()