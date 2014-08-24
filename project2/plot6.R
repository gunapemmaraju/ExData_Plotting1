library(data.table)
library(lattice)

#Data load
NEI <- readRDS("summarySCC_PM25.rds")

#Obtain the data for fips=24510 or fips == 06037, and motor vehicles.
#After persuing thru the data, and scanning the codebook at http://www.epa.gov/ttn/chief/net/2011nei/2011_nei_tsdv1_draft2_june2014.pdf
# I felt I could assume that just looking at ON-ROAD for the type variable of the NEI data should be able to give this data. I initially tried grepping for
# words including motor and vehicle in the SCC data frame. But At the end of it all, I felt that the type =ON ROAD, gave the best estimate.
# To double check, I also grepped for the phrase" On-Road ", in the SCC$EI.Sector. And in both approach, I got the same number of rows :-)
# hence finally I am just going with the first approach.
#In case this assumption, the code can easily be modified to reflect the same. 

d<-(((NEI$fips=="24510") | (NEI$fips == "06037"))& (NEI$type=="ON-ROAD"))
dt1<-data.table(NEI[d ,])
p1<-as.data.frame(dt1[,list(TotalPM25Emission=sum(Emissions)),by=list(year,fips)])
p1 <- transform(p1, fips = factor(fips, labels = c("Los Angeles County", "Baltimore City")))



#Plotting
# although this could definitely have been done in ggplot2. I just wanted to use this exercise as a way to test my lattice learning. 
# hence I used lattice.
png(file ="plot6.png")

p<-xyplot(TotalPM25Emission ~ year | fips, data = p1, layout = c(2, 1), panel = function(x, y, ...) {
    panel.xyplot(x, y, ...) 
    panel.lmline(x, y, col = 2) 
})
print(p)
dev.off()
