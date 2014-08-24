library(data.table)
library(ggplot2)

#Data load
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")



#Obtain the data for coal combustion related sources.
#After persuing thru the data, and scanning the codebook at http://www.epa.gov/ttn/chief/net/2011nei/2011_nei_tsdv1_draft2_june2014.pdf
# I felt I could assume that the EI.Sector captures the information well. I then looked at the levels of this column.
#Based on all this, I have decided that  I would checking that field for text containing coal (using regex)
#In case this assumption, the code can easily be modified to reflect the same. 

ei<- grepl('*[cC]oal.*',SCC$EI.Sector)
ids<-data.frame(SCC=SCC[ei,"SCC"])
df<-merge(NEI,ids)

#Summarize Data
dt<-data.table(df)
p1<-dt[,list(TotalEmission=sum(Emissions)),by=year]

#Plotting
png(file = "plot4.png")
with(p1,plot(year,TotalEmission, pch=1,col="blue", ylab="Total PM2.5 EMission from Coal Combustion related sources"))
model <- lm(TotalEmission ~ year, p1)
abline(model)
dev.off()
