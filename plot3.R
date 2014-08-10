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
png(file = "plot3.png")
plot(df$dateTime,df$Sub_metering_1, xlab="", ylab="Energy sub metering", type="n")
lines(df$dateTime,df$Sub_metering_1)
lines(df$dateTime,df$Sub_metering_2, col="red")
lines(df$dateTime,df$Sub_metering_3, col="blue")
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1))
dev.off()
