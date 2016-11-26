data=read.csv('/home/hoshank/Desktop/bdcc/balance_sheet.csv')

library("scrime")

data=read.csv('/home/hoshank/Desktop/bdcc/balance_sheet.csv')
cor(data)
install.packages("corrplot")
library("corrplot")
corrplot(cor(data))
corrplot(data)
library("ggplot2")
ggcorr(data)
install.packages("GGally")
library(GGally)
ggcorr(data)
ggcorr(data,label=FALSE)
ggcorr(data,label=TRUE)
ggcorr(data[2:4,],label=TRUE)
ggcorr(data[,2:4],label=TRUE)
ggcorr(data[2:4,])
ggcorr(data[3:4,])
ggcorr(data[1:4,])
data(1:4,)
data[1:4,]
data[2:4,]
data[1:3,]
ggcorr(data[1:3,])
ggcorr(data[1:3,],name="hh")
data2=names(data)<- NULL
head(data2)
data2=names(data)<-NULL
data2
data2=names(data1)<-NULL
data2
names(data1)<-NULL
data1
data
ggcorr(data[1:3,])
ggcorr(data[1:3,],labels=TRUE)
ggcorr(data[1:3,],label=TRUE)
ggcorr(data[1:3,],label=TRUE,geom="circle")
ggcorr(data[1:3,],label=TRUE,geom="circle",label_size = 2)
ggcorr(data[1:3,],label=TRUE,label_size = 3)
data[1:3,]
history()
