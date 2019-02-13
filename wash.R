data<-read.csv("D://Data.csv")
colSums(is.na(data))
colSums(data=="������Ϣ")


#��Ϣ��ϴ
library(tidyr)
library(stringr)
data=separate(data=data,col=Type,into = c("Bedrooms","Halls"),sep="��")
data=separate(data=data,col=Halls,into = c("Halls","Toilet"),sep="��")
data$Toilet<-str_replace(data$Toilet,"��","")
data$Halls<-str_replace(data$Halls,"��","")
newdata<-data[which(DATA$Toilet %in% NA),5]
data$Area<-str_replace(data$Area,"�O","")
data$Floor<-str_replace(data$Floor,"[(].*[)]","")
data[which(data$Floor=="������Ϣ"),9]<-"����"
data$Area<-str_replace(data$Area,"����","")
data$Area<-str_replace(data$Area,"[|].*�O","")
data$Arichi<-str_replace(data$Arichi,"\t","")

#�������͵���ϴ�����ڷ���ͨסլ��������������Ԣ��ƽ���Լ������������ݽ���ռ�������ݼ���47/3911,���Խ�����ͨסլ�ļ�¼ɾ����
#��ͨסլ��3864/3911

#���ݵ�ַ��ϴ
data$Address<-str_replace(data$Address,'\n',"")
data$Address<-str_replace(data$Address,'������Ϣ',"����-����-����")

data$Domain<-str_replace(data$Domain,"��������","")
data$Domain[data$Domain == ""]<-"����-����"
data$Domain<-str_replace(data$Domain,"-.*","")
data$Domain<-str_replace(data$Domain," ","")
data$Domain<-str_replace(data$Domain,"��","")
#
data<-data[,-c(23)]
data<-data[,-c(22)]
#

data[which(data$Arichi=="����"),10]<-"����"
data[which(data$Arichi=="���� | ��¥"),10]<-"����"
data[which(data$Arichi=="���� | �������"),10]<-"����"
data[which(data$Arichi=="���� | ��¥"),10]<-"����"

data[which(data$Arichi=="��Ԣ"),10]<-"��Ԣ"
data[which(data$Arichi=="��Ԣ | ��¥"),10]<-"��Ԣ"
data[which(data$Arichi=="��Ԣ | �������"),10]<-"��Ԣ"
data[which(data$Arichi=="��Ԣ | ��¥"),10]<-"��Ԣ"

data[which(data$Arichi=="��ͨסլ"),10]<-"��ͨסլ����"
data[which(data$Arichi=="��ͨסլ | ��¥"),10]<-"��¥"
data[which(data$Arichi=="��ͨסլ | �������"),10]<-"�������"
data[which(data$Arichi=="��ͨסլ | ��¥"),10]<-"��¥"

data[which(data$Arichi=="����"),10]<-"δ֪"
data[which(data$Arichi=="���� | ��¥"),10]<-"δ֪"
data[which(data$Arichi=="���� | �������"),10]<-"δ֪"
data[which(data$Arichi=="���� | ��¥"),10]<-"δ֪"

data[which(data$Arichi=="ƽ��"),10]<-"ƽ��"
data[which(data$Arichi=="ƽ�� | ��¥"),10]<-"ƽ��"
data[which(data$Arichi=="ƽ�� | �������"),10]<-"ƽ��"
data[which(data$Arichi=="ƽ�� | ��¥"),10]<-"ƽ��"

data<-data[-which(data$Arichi=="����"),]
data<-data[-which(data$Arichi=="��Ԣ"),]
data<-data[-which(data$Arichi=="ƽ��"),]
data<-data[-which(data$Arichi=="δ֪"),]

count<-which(data$Arichi=="��ͨסլ����")
#2512 626 221
#610 152 54
for(i in count[1:610]){
  data[i,10]<-"��¥"
}
for(i in count[611:762]){
  data[i,10]<-"�������"
}
for(i in count[763:816]){
  data[i,10]<-"��¥"
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


data[which(data$Year=="1988��"),12]<-'1990��'
data[which(data$Year=="1989��"),12]<-'1990��'
data[which(data$Year=="1990��"),12]<-'1990��'
data[which(data$Year=="1991��"),12]<-'2000��'
data[which(data$Year=="1992��"),12]<-'2000��'
data[which(data$Year=="1993��"),12]<-'2000��'
data[which(data$Year=="1994��"),12]<-'2000��'
data[which(data$Year=="1995��"),12]<-'2000��'
data[which(data$Year=="1996��"),12]<-'2000��'
data[which(data$Year=="1997��"),12]<-'2000��'
data[which(data$Year=="1998��"),12]<-'2000��'
data[which(data$Year=="1999��"),12]<-'2000��'
data[which(data$Year=="2000��"),12]<-'2000��'

data[which(data$Year=="2001��"),12]<-'2010��'
data[which(data$Year=="2002��"),12]<-'2010��'
data[which(data$Year=="2003��"),12]<-'2010��'
data[which(data$Year=="2004��"),12]<-'2010��'
data[which(data$Year=="2005��"),12]<-'2010��'
data[which(data$Year=="2006��"),12]<-'2010��'
data[which(data$Year=="2007��"),12]<-'2010��'
data[which(data$Year=="2008��"),12]<-'2010��'
data[which(data$Year=="2009��"),12]<-'2010��'
data[which(data$Year=="2010��"),12]<-'2010��'


data[which(data$Year=="2011��"),12]<-'2020��'
data[which(data$Year=="2012��"),12]<-'2020��'
data[which(data$Year=="2013��"),12]<-'2020��'
data[which(data$Year=="2014��"),12]<-'2020��'
data[which(data$Year=="2015��"),12]<-'2020��'
data[which(data$Year=="2016��"),12]<-'2020��'
data[which(data$Year=="2017��"),12]<-'2020��'
data[which(data$Year=="2018��"),12]<-'2020��'
data[which(data$Year=="2019��"),12]<-'2020��'
data[which(data$Year=="2020��"),12]<-'2020��'

data[which(data$Year=="2021��"),12]<-'2030��'
data[which(data$Year=="2022��"),12]<-'2030��'
data[which(data$Year=="2023��"),12]<-'2030��'
data[which(data$Year=="2024��"),12]<-'2030��'
data[which(data$Year=="2025��"),12]<-'2030��'
data[which(data$Year=="2026��"),12]<-'2030��'
data[which(data$Year=="2027��"),12]<-'2030��'
data[which(data$Year=="2028��"),12]<-'2030��'
data[which(data$Year=="2029��"),12]<-'2030��'
data[which(data$Year=="2030��"),12]<-'2030��'