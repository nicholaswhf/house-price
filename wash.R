data<-read.csv("D://Data.csv")
colSums(is.na(data))
colSums(data=="暂无信息")


#信息清洗
library(tidyr)
library(stringr)
data=separate(data=data,col=Type,into = c("Bedrooms","Halls"),sep="室")
data=separate(data=data,col=Halls,into = c("Halls","Toilet"),sep="厅")
data$Toilet<-str_replace(data$Toilet,"卫","")
data$Halls<-str_replace(data$Halls,"卫","")
newdata<-data[which(DATA$Toilet %in% NA),5]
data$Area<-str_replace(data$Area,"㎡","")
data$Floor<-str_replace(data$Floor,"[(].*[)]","")
data[which(data$Floor=="暂无信息"),9]<-"其他"
data$Area<-str_replace(data$Area,"建面","")
data$Area<-str_replace(data$Area,"[|].*㎡","")
data$Arichi<-str_replace(data$Arichi,"\t","")

#建筑类型的清洗，由于非普通住宅（包括别墅、公寓、平房以及其他）的数据仅仅占据了数据集的47/3911,所以将非普通住宅的记录删除。
#普通住宅：3864/3911

#房屋地址清洗
data$Address<-str_replace(data$Address,'\n',"")
data$Address<-str_replace(data$Address,'暂无信息',"其他-其他-其他")

data$Domain<-str_replace(data$Domain,"所在区域：","")
data$Domain[data$Domain == ""]<-"其他-其他"
data$Domain<-str_replace(data$Domain,"-.*","")
data$Domain<-str_replace(data$Domain," ","")
data$Domain<-str_replace(data$Domain,"区","")
#
data<-data[,-c(23)]
data<-data[,-c(22)]
#

data[which(data$Arichi=="别墅"),10]<-"别墅"
data[which(data$Arichi=="别墅 | 板楼"),10]<-"别墅"
data[which(data$Arichi=="别墅 | 板塔结合"),10]<-"别墅"
data[which(data$Arichi=="别墅 | 塔楼"),10]<-"别墅"

data[which(data$Arichi=="公寓"),10]<-"公寓"
data[which(data$Arichi=="公寓 | 板楼"),10]<-"公寓"
data[which(data$Arichi=="公寓 | 板塔结合"),10]<-"公寓"
data[which(data$Arichi=="公寓 | 塔楼"),10]<-"公寓"

data[which(data$Arichi=="普通住宅"),10]<-"普通住宅其他"
data[which(data$Arichi=="普通住宅 | 板楼"),10]<-"板楼"
data[which(data$Arichi=="普通住宅 | 板塔结合"),10]<-"板塔结合"
data[which(data$Arichi=="普通住宅 | 塔楼"),10]<-"塔楼"

data[which(data$Arichi=="其他"),10]<-"未知"
data[which(data$Arichi=="其他 | 板楼"),10]<-"未知"
data[which(data$Arichi=="其他 | 板塔结合"),10]<-"未知"
data[which(data$Arichi=="其他 | 塔楼"),10]<-"未知"

data[which(data$Arichi=="平房"),10]<-"平房"
data[which(data$Arichi=="平房 | 板楼"),10]<-"平房"
data[which(data$Arichi=="平房 | 板塔结合"),10]<-"平房"
data[which(data$Arichi=="平房 | 塔楼"),10]<-"平房"

data<-data[-which(data$Arichi=="别墅"),]
data<-data[-which(data$Arichi=="公寓"),]
data<-data[-which(data$Arichi=="平房"),]
data<-data[-which(data$Arichi=="未知"),]

count<-which(data$Arichi=="普通住宅其他")
#2512 626 221
#610 152 54
for(i in count[1:610]){
  data[i,10]<-"板楼"
}
for(i in count[611:762]){
  data[i,10]<-"板塔结合"
}
for(i in count[763:816]){
  data[i,10]<-"塔楼"
}

#

write.csv(data,file="clean_data.csv")


#
data$Bedrooms<-as.factor(data$Bedrooms)
data$Halls<-as.factor(data$Halls)
data$Toilet<-as.factor(data$Toilet)
data$Area<-as.numeric(data$Area)
data$Prcie<-as.numeric(data$Prcie)
data$Towards<-as.factor(data$Towards)
data$Arichi<-as.factor(data$Arichi)
data$Year<-as.numeric(data$Year)
data$Decorate<-as.factor(data$Decorate)

library(ggplot2)
ggplot(data,aes(x=Elevator,y=Prcie))+geom_boxplot(col='red')


data[which(data$Year=="1988年"),12]<-'1990年'
data[which(data$Year=="1989年"),12]<-'1990年'
data[which(data$Year=="1990年"),12]<-'1990年'
data[which(data$Year=="1991年"),12]<-'2000年'
data[which(data$Year=="1992年"),12]<-'2000年'
data[which(data$Year=="1993年"),12]<-'2000年'
data[which(data$Year=="1994年"),12]<-'2000年'
data[which(data$Year=="1995年"),12]<-'2000年'
data[which(data$Year=="1996年"),12]<-'2000年'
data[which(data$Year=="1997年"),12]<-'2000年'
data[which(data$Year=="1998年"),12]<-'2000年'
data[which(data$Year=="1999年"),12]<-'2000年'
data[which(data$Year=="2000年"),12]<-'2000年'

data[which(data$Year=="2001年"),12]<-'2010年'
data[which(data$Year=="2002年"),12]<-'2010年'
data[which(data$Year=="2003年"),12]<-'2010年'
data[which(data$Year=="2004年"),12]<-'2010年'
data[which(data$Year=="2005年"),12]<-'2010年'
data[which(data$Year=="2006年"),12]<-'2010年'
data[which(data$Year=="2007年"),12]<-'2010年'
data[which(data$Year=="2008年"),12]<-'2010年'
data[which(data$Year=="2009年"),12]<-'2010年'
data[which(data$Year=="2010年"),12]<-'2010年'


data[which(data$Year=="2011年"),12]<-'2020年'
data[which(data$Year=="2012年"),12]<-'2020年'
data[which(data$Year=="2013年"),12]<-'2020年'
data[which(data$Year=="2014年"),12]<-'2020年'
data[which(data$Year=="2015年"),12]<-'2020年'
data[which(data$Year=="2016年"),12]<-'2020年'
data[which(data$Year=="2017年"),12]<-'2020年'
data[which(data$Year=="2018年"),12]<-'2020年'
data[which(data$Year=="2019年"),12]<-'2020年'
data[which(data$Year=="2020年"),12]<-'2020年'

data[which(data$Year=="2021年"),12]<-'2030年'
data[which(data$Year=="2022年"),12]<-'2030年'
data[which(data$Year=="2023年"),12]<-'2030年'
data[which(data$Year=="2024年"),12]<-'2030年'
data[which(data$Year=="2025年"),12]<-'2030年'
data[which(data$Year=="2026年"),12]<-'2030年'
data[which(data$Year=="2027年"),12]<-'2030年'
data[which(data$Year=="2028年"),12]<-'2030年'
data[which(data$Year=="2029年"),12]<-'2030年'
data[which(data$Year=="2030年"),12]<-'2030年'