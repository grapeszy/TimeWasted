library(stats)
library(grid)
library(plyr)
library(ggplot2)



t <- format(Sys.time(),"%y-%m-%d")
outname <- paste("F:/R_work/TimeWasted//",t,".png",sep = "")

png(file=outname)

td <- read.table("F:/R_work/TimeWasted//temp.txt",head=F)
names(td) <- c("hh","mm","type")

for(i in 1:(length(td$hh)-1)){
  td$gap[i] <- ((td$hh[i+1]*60+td$mm[i+1])-(td$hh[i]*60 + td$mm[i]))
}

td$gap[length(td$hh)] <- 0

ind<-td$type==1
x <- sum(td$gap[ind])

ind<-td$type==2
x[2] <- sum(td$gap[ind])

ind<-td$type==3
x[3] <- sum(td$gap[ind])

ind<-td$type==4
x[4] <- sum(td$gap[ind])
x<-x/60.0
names(x) <- c("study","play","eat","other")
fname<-paste("F:/R_work/TimeWasted//",t,".RData",sep = "")
save(td,file=fname)
ti <- paste(t,"\n"," total time : ",format(sum(x),digits=3),"h",sep = "")

n<-3
col.l<-rainbow(n, s = 1, v = 1, start = 0, end = max(1,n - 1)/n)
barplot(x,main=ti,ylab="Time[h]",col=NULL,ylim=c(0,sum(x)))
text(0.4,x[1]+0.5,(format(x[1],digits=2)))
text(1.6,x[2]+0.5,(format(x[2],digits=2)))
text(2.8,x[3]+0.5,(format(x[3],digits=2)))
text(4,x[4]+0.5,(format(x[4],digits=2)))

dev.off()

