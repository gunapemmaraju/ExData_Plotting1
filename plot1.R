# new comment
#variable setup
c1<-rep("numeric",7)
c2<-rep("character",2)
co<-c(c2,c1)
d1<-as.Date("2007-02-01")
d2<-as.Date("2007-02-02")
#reading data
df<-read.table("household_power_consumption.txt", sep=";",na.strings="?",comment.char = "",header = TRUE,colClasses=co)
df<-transform(df,dateTime=strptime(paste(df$Date, df$Time), format="%d/%m/%Y%H:%M:%S"), Date=as.Date(df$Date, format="%d/%m/%Y"))
df<-df[df$Date>=d1 & df$Date<=d2,]
#plotting
png(file = "plot1.png")
hist(df$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
dev.off()

