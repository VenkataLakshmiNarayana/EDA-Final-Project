#Import the desired libraries
library(ggplot2)
#Fist let us extract the data from the file
data_nei <- readRDS("summarySCC_PM25.rds")
data_scc <- readRDS("Source_Classification_Code.rds")
#Now let us get all the records that are realted to motor vehicle sources
#First let us get the SCC codes for motor vehicle sources
motor_vehicle_scc <- data_scc[grepl("Vehicle", data_scc$SCC.Level.Two), ]$SCC
data <- data_nei[(data_nei$SCC %in% motor_vehicle_scc) &
                   (data_nei$fips == "24510" | data_nei$fips == "06037"), ]
#Now let us calculate the total emissions for every year in Baltimore City
plot_data <- aggregate((data$Emissions),
                       by = list(data$year, data$fips), FUN = sum)
#Now let us plot the data as per the requirements
#Before getting into plot let us make the Group.1 column as character
plot_data$Group.1 <- as.character(plot_data$Group.1)
#Now let us rename the columns
colnames(plot_data) <- c("year", "city", "x")
#Now let us set the city names
plot_data$city[plot_data$city == "24510"] <- "Baltimore City"
plot_data$city[plot_data$city == "06037"] <- "Los Angeles"
#First let set Graphics device
png("plot6.png", width = 600, height = 600)
#Second let us Plot the graph on the device
p <- ggplot(plot_data, aes(x = year, y = x, fill = city)) +
  geom_bar(stat = "identity") +
  facet_grid(. ~ city) +
  geom_label(aes(label = round(x)), vjust = -0.5) +
  labs(title = "Total PM2.5 Emissions from Motor Vehicle sources in Baltimore City and Los Angeles",
       x = "Year",
       y = "Total PM2.5 Emissions (in tonnes)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
print(p)
#Finally let us Close the device
dev.off()