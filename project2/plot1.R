library(data.table)

#Data load
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#This data has duplicate records.
#> NEI <- readRDS("summarySCC_PM25.rds")
#> SCC <- readRDS("Source_Classification_Code.rds")
#> nrow(NEI)
#[1] 6497651
#> nrow(unique(NEI))
#[1] 6392545
# But I am ignoring that. If this assumption is invalid, code can be modified accordingly.

#Summarize Data
dt<-data.table(NEI)
p1<-dt[,list(TotalEmission=sum(Emissions)),by=year]
p2<-p1[order(p1$year),]

#Plotting
png(file = "plot1.png")
with(p2,plot(year,TotalEmission, pch=1,col="blue", ylab="Total PM2.5 EMission"))
model <- lm(TotalEmission ~ year, p2)
abline(model)
dev.off()
