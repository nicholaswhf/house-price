import numpy as np
import pandas as pd
import sklearn as skl
from sklearn.model_selection import train_test_split
from pandas import Series,DataFrame
from sklearn.metrics import r2_score

data = pd.read_csv("./clean_data.csv",header = 0,encoding = "gbk")
#data = pd.read_csv("D://QJ.csv",header = 0,encoding = "gbk")
#删除不作为输入特征的列
#Order	Prcie	Unit	Date	Bedrooms	Halls	Toilet	Area	Towards	Floor	Arichi	Elevator	
#Year	Pro	ProR	Decorate	Community	Address	PlotR	Address2	GreenR	Domain
#Elevator	Year	Pro	ProR	Decorate	Community	Address	PlotR	Address2	GreenR	Domain


data.drop("Order",axis = 1,inplace = True)
#data.drop("Domain",axis = 1,inplace = True)
data.drop("Arichi",axis=1,inplace=True)
data.drop("Unit",axis = 1,inplace = True)
data.drop("Date",axis = 1,inplace = True)
data.drop("Pro",axis = 1,inplace = True)
data.drop("ProR",axis = 1,inplace = True)
#data.drop("Community",axis = 1,inplace = True)
data.drop("Address",axis = 1,inplace = True)
data.drop("Address2",axis = 1,inplace = True)
data.drop("PlotR",axis = 1,inplace = True)
data.drop("GreenR",axis = 1,inplace = True)
#data.drop("Elevator",axis = 1,inplace = True)
data.drop("Year",axis = 1,inplace = True)

data=pd.get_dummies(data)
#print(data.head(5)) 
target=data['Price']
data=data.drop('Price',axis=1)
data_list=list(data.columns)
#划分数据集和测试集
train_data,test_data,train_target,test_target=train_test_split(data,target,test_size=0.10,random_state=42)
from sklearn.ensemble import RandomForestRegressor
rf=RandomForestRegressor(n_estimators=1000,random_state=42)
rf.fit(train_data,train_target)
predictions = rf.predict(test_data)

predictions_T = rf.predict(train_data)

errors=abs(predictions-test_target)
error_s=predictions-test_target
count=0
count_=0
_count=0
print('误差')
for i in error_s:
	_count=_count+1
	print(i)
	if(abs(i)>=10):
		count=count+1
	if(i>=10):
		count_=count_+1
print('count：',count)
print('count_：',count_)
print('_count：',_count)
print('平均误差：',round(np.mean(errors),2))
#print(test_data)
#print('A')
#print(predictions)
#print('B')
#print(test_target)
mape=100*(errors/test_target)
accuracy=100-np.mean(mape)
print('准确率：',round(accuracy,2),'%')

#graphy
from sklearn.tree import export_graphviz
import pydot

rf.estimators_[:5]
tree=rf.estimators_[5]
export_graphviz(tree,
				out_file='tree.dot',
				feature_names=data_list,
				precision=1)
(graph,)=pydot.graph_from_dot_file('tree.dot')
graph.write_png('tree.png')



importances = list(rf.feature_importances_)

feature_importances = [(data, round(importance, 9)) 
                       for data, importance in zip(data_list, importances)]

#重要性从高到低排序
feature_importances = sorted(feature_importances, key = lambda x: x[1], reverse = True)

# Print out the feature and importances 
[print('Variable: {:20} Importance: {}'.format(*pair)) for pair in feature_importances]
'''
import pickle
with open("model.pkl","wb") as f:
	pickle.dump(rf,f)
'''
print(r2_score(test_target,predictions))
print("<test train>")
print(r2_score(train_target,predictions_T))