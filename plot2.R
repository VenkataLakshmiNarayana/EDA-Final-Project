#First let us extract the data from the file
data <- readRDS("summarySCC_PM25.rds")
#Now let us calculate the total PM2.5 emissions from data in Baltimore City from 1999 to 2008
filtered_data <- data[data$fips == "24510" & data$year >= 1999 & data$year <= 2008,]
plot_data <- aggregate((filtered_data$Emissions),
                       by = list(filtered_data$year), FUN = sum)
#Now let us plot the data as per the requirements
#First let set Graphics device
png("plot2.png")
#Second let us Plot the bar plot graph on the device
barplot(plot_data$x, names.arg = plot_data$Group.1, col = "green",
        main = "Total PM2.5 Emissions in Baltimore City for the years
                1999 to 2008",
        xlab = "Year",
        ylab = "Total PM2.5 Emissions (in tonnes)")
#Finally let us Close the device
dev.off()