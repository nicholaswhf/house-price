#-*- coding:utf-8 -*-
import time
import requests
from requests.exceptions import RequestException
from bs4 import BeautifulSoup
import re
import csv
import codecs

header={'User-Agent':'Mozilla/5.0(Windows NT 10.0;WOW64) AppleWebKit/537.36 (KHTML,like Gecko) Chrome/55.0.2883.87 Safari/537.36'}


#获取url对应的网页内容
def get_one_page(url):
	try:
		response=requests.get(url,headers=header)
		if response.status_code==200:
			return response.text
		else:
			return None
	except RequestException:
		print('get_one_page exceptions')
		print(url)
		return None
def parse_one_page(content):
	init_data=[]
	try:
		soup=BeautifulSoup(content,'html.parser')
		items=soup.find('div',class_=re.compile('js-tips-list'))
		for div in items.find_all('div',class_=re.compile('ershoufang-list')):
			if(div['href'][0]=='h'):
				link=div['href']
			else:
				link="http://xa.ganji.com/"+div['href']
			specification=get_one_page(link)
			if(specification==None):
				continue
			init_data.append(parse_more_info(specification))
		data_write_rows(init_data)
	except Exception:
		print('parse_one_page exceptions')
		return None

def parse_more_info(specification):
	info=[]
	try:
		soup_s=BeautifulSoup(specification,'html.parser')
		Price=soup_s.find('span',class_=re.compile('price')).get_text()
		Unit=soup_s.find('span',class_=re.compile('unit')).get_text().strip(' |').strip('元/m²')
		Date=soup_s.find('li',class_=re.compile('date')).get_text().strip()
		Type=soup_s.find_all('span',class_=re.compile('content'))[0].get_text()
		Area=soup_s.find_all('span',class_=re.compile('content'))[1].get_text()
		Towards=soup_s.find_all('span',class_=re.compile('content'))[2].get_text()
		Floor=soup_s.find_all('span',class_=re.compile('content'))[3].get_text()
		Arichi=soup_s.find_all('span',class_=re.compile('content'))[4].get_text()
		Elevator=soup_s.find_all('span',class_=re.compile('content'))[5].get_text().strip('\t')
		Year=soup_s.find_all('span',class_=re.compile('content'))[6].get_text().strip('\t')
		Pro=soup_s.find_all('span',class_=re.compile('content'))[7].get_text().strip('\t')
		ProR=soup_s.find_all('span',class_=re.compile('content'))[8].get_text().strip('\t')
		Decorate=soup_s.find_all('span',class_=re.compile('content'))[9].get_text()
		Community=soup_s.find('a',class_='xiaoqu card-blue').get_text().strip('\n')
	#	'Subway':soup_s.find('div',class_='subway-wrap').find('span',class_=re.compile('content')).get_text(),
		Address=soup_s.find_all('span',class_=re.compile('content'))[-1].get_text().strip('\n')
		PlotR=soup_s.find_all('li',class_=re.compile('ellipsis'))[0].get_text()
		Address2=soup_s.find_all('li',class_=re.compile('ellipsis'))[1].get_text()
		GreenR=soup_s.find_all('li',class_=re.compile('ellipsis'))[2].get_text()
		Domain=soup_s.find_all('li',class_=re.compile('ellipsis'))[3].get_text()
		Park=soup_s.find_all('li',class_=re.compile('ellipsis'))[4].get_text()
		FinishYear=soup_s.find_all('li',class_=re.compile('ellipsis'))[5].get_text()
		info.append(Price)
		info.append(Unit)
		info.append(Date)
		info.append(Type)
		info.append(Area)
		info.append(Towards)
		info.append(Floor)
		info.append(Arichi)
		info.append(Elevator)
		info.append(Year)
		info.append(Pro)
		info.append(ProR)
		info.append(Decorate)
		info.append(Community)
		info.append(Address)
		info.append(PlotR)
		info.append(Address2)
		info.append(GreenR)
		info.append(Domain)
		info.append(Park)
		info.append(FinishYear)
		print(info)
		return info
	except Exception:
		print('parse_specific_info exceptions')
		return None
def data_write_rows(init_data):
	with open('Data3.csv', 'a',newline='') as f:
		writer=csv.writer(f)
		writer.writerows(init_data)

def data_write_csv():
	with open('Data3.csv', 'w',newline='') as f:
		writer=csv.writer(f)
		writer.writerow(['Price','Unit','Date','Type',
			'Area','Towards','Floor','Arichi','Elevator',
			'Year','Pro','ProR','Decorate','Community',
			'Address','PlotR','Address2','GreenR',
			'Domain','Park','FinishYear'])

def main():
	data_write_csv()
	for i in range(100,200):
		url='http://xa.ganji.com/fang5/o{}/'.format(i)
		content=get_one_page(url)
		print('第{}页抓取完毕'.format(i))
		parse_one_page(content)
		time.sleep(10)
if __name__ == '__main__':
	main()                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
