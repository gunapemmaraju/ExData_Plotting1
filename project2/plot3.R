library(data.table)
library(ggplot2)

#Data load
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Summarize Data
dt<-data.table(NEI[NEI$fips==24510,])
p1<-dt[,list(TotalPM25Emission=sum(Emissions)),by=list(type,year)]


#Plotting
png(file = "plot3.png")
p<-qplot(year,TotalPM25Emission, data=p1, facets=.~type, geom = c("point", "smooth"), ylab="Total PM2.5 EMission for FIPS: 24510")
print(p)
dev.off()
