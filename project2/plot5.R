library(data.table)

#Data load
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Obtain the data for fips=24510, and motor vehicles.
#After persuing thru the data, and scanning the codebook at http://www.epa.gov/ttn/chief/net/2011nei/2011_nei_tsdv1_draft2_june2014.pdf
# I felt I could assume that just looking at ON-ROAD for the type variable of the NEI data should be able to give this data. I initially tried grepping for
# words including motor and vehicle in the SCC data frame. But At the end of it all, I felt that the type =ON ROAD, gave the best estimate.
# To double check, I also grepped for the phrase" On-Road ", in the SCC$EI.Sector. And in both approach, I got the same number of rows :-)
# hence finally I am just going with the first approach.
#In case this assumption, the code can easily be modified to reflect the same. 
dt<-data.table(NEI[(NEI$fips==24510 & NEI$type=="ON-ROAD"),])
nrow(dt)


df1<-NEI[NEI$fips==24510,]
ei<- grepl(' On-Road ',SCC$EI.Sector)
ids<-data.frame(SCC=SCC[ei,"SCC"])
df<-merge(df1,ids)
nrow(df)


p1<-dt[,list(TotalEmission=sum(Emissions)),by=year]


ei<- grepl(' On-Road ',SCC$EI.Sector)
ids<-data.frame(SCC=SCC[ei,"SCC"])
df<-merge(NEI,ids)
dt1<-data.table(NEI[(NEI$fips==24510),])


nrow(dt1)
nrow(dt)
#Plotting
png(file = "plot5.png")
with(p1,plot(year,TotalEmission, pch=1,col="blue", ylab="Total PM2.5 EMission for FIPS: 24510 and Type; ON_ROAD"))
model <- lm(TotalEmission ~ year, p1)
abline(model)
dev.off()
