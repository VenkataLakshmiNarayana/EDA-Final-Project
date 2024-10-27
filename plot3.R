#Import the desired libraries
library(ggplot2)
#Fist let us extract the data from the file
data <- readRDS("summarySCC_PM25.rds")
#Now let us calculate the total PM2.5 emissions from the data in Baltimore City for different source type over the years
filtered_data <- data[data$fips == "24510",]
plot_data <- aggregate((filtered_data$Emissions),
                       by = list(filtered_data$year, filtered_data$type),
                       FUN = sum)
#Now let us plot the data as per the requirements
#Before getting into plot let us make the Group.1 column as character
plot_data$Group.1 <- as.character(plot_data$Group.1)
#Now let us rename the columns
colnames(plot_data) <- c("year", "type", "x")
#First let set Graphics device
png("plot3.png", width = 600, height = 600)
#Second let us Plot the graph on the device
p <- ggplot(plot_data, aes(x = year, y = x, fill = type)) +
  geom_bar(stat = "identity") +
  facet_grid(. ~ type) +
  geom_label(aes(label = round(x)), vjust = -0.5) +
  labs(title = "Total PM2.5 Emissions in Baltimore City by different type of sources and years",
       x = "Year",
       y = "Total PM2.5 Emissions (in tonnes)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
print(p)
#Finally let us Close the device
dev.off()