library(data.table)

#Data load
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Summarize Data
dt<-data.table(NEI)
p1<-dt[,list(TotalEmission=sum(Emissions)),by=year]
order(p1$year)
p2<-p1[order(p1$year),]

#Plotting
png(file = "plot1.png")
with(p2,plot(year,TotalEmission, pch=1,col="blue"))
model <- lm(TotalEmission ~ year, p2)
abline(model)
dev.off()
