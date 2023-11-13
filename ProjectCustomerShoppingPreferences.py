#!/usr/bin/env python
# coding: utf-8

# In[12]:


# fashion was happened in overseas. Especially in america and it happening to buy eventually to buy fashion. 
# the data capture the customer buying fashion in many country of america . So, it will be opportunity for marketer to known 
# the customer needs

# the problem
# how many customer buy fashion at the time
# how much spend by gender category
# how much spend by age category (named it)


# In[80]:


import pandas as pd
df = pd.read_csv('shopping_trends.csv',index_col = False)
# pengecekan dasar
print (df)
print(df.shape)
print (df.info())
print (df.describe())


# the problem 1
# how many customer buy fashion at the time
total_customer = df[
    'Customer ID'].nunique()
print ('total_customer',total_customer)


# In[76]:


# how much spend by age category 18-31 muda, 31-44 dewasa, 44-57 dewasa akhir, sisanya tua

bins = [18,31,44,57,float('Inf')]
labels = ['muda','dewasa','dewasa akhir','tua']

df['Age Category']=pd.cut(
    df['Age'],bins=bins,labels=labels,right=False
)

spend_by_age_category = df.groupby('Age Category')['Purchase Amount (USD)'].sum().reset_index()

print ('spend_by_age_category',spend_by_age_category)


# In[78]:


# how much spend by gender category 
df.groupby (
'Gender')['Purchase Amount (USD)'].sum().reset_index()


# In[83]:


# how many buyer using express shipping by category?
count_shipping = df.groupby('Shipping Type')['Shipping Type'].count().astype(int).sort_values(ascending = False)
print ('count_shipping',count_shipping)

# how many male buyer using express shipping by category?
count_shipping_male = df[df['Gender']=='Male'].groupby('Shipping Type')['Shipping Type'].count().astype(int).sort_values(ascending=False)

print('count_shipping_male',count_shipping_male)

# kalo perempuan?
count_shipping_female = df[df['Gender']=='Female'].groupby('Shipping Type')['Shipping Type'].count().astype(int).sort_values (ascending = False)
print ('count_shipping_female',count_shipping_female)


# In[85]:


# berapa banyak pembeli laki laki dan perempuan
total_buyer_by_gender = df.groupby('Gender')['Gender'].count().astype(int)
print ('total_buyer_by_gender',total_buyer_by_gender)

# total pembelian oleh perempuan untuk setiap kategori
count_category_female = df[df['Gender']=='Female'].groupby('Category')['Previous Purchases'].sum().sort_values(ascending = False)
print ('count_category_female',count_category_female)

# kalo laki laki?
count_category_male = df[
    df['Gender']=='Male'].groupby('Category')['Previous Purchases'].sum().sort_values(ascending = False)
print ('count_category_male',count_category_male)


# In[92]:


# berapa banyak dari setiap lokasi pembelian 5 terbanyak
count_location = df.groupby('Location')['Location'].count().astype(str).sort_values(ascending = False).head(5)
print ('count_location',count_location)

# kalo perempuan paling banyak dari negara mana?
count_location_female = df[
    df['Gender']=='Female'].groupby('Location')['Location'].count().astype(str).sort_values(ascending = False).head(5)
print ('count_location_female',count_location_female)

# kalo laki laki?
count_location_male = df[
    df['Gender']=='Male'].groupby('Location')['Location'].count().astype(str).sort_values(ascending = False).head(5)
print ('count_location_male',count_location_male)


# In[93]:


# berapa banyak warna yang dibeli oleh pembeli
count_color = df.groupby('Color')['Previous Purchases'].sum().sort_values(ascending = False)
print ('count_color',count_color)


# In[99]:


# berapa rata rata review ratingnya pada setiap produk
mean_rating_product = df.groupby('Item Purchased').agg(
    {'Review Rating':'mean','Customer ID':'count'}).sort_values(by='Review Rating',ascending = False)
print ('mean_rating_product',mean_rating_product)


# In[108]:


# keluarkan paling banyak payment method
count_payment_method = df.groupby ('Payment Method')['Payment Method'].count().astype (str).sort_values (ascending = False)
print ('count_payment_method',count_payment_method)

count_payment_male = df[
    df['Gender']=='Male'].groupby('Payment Method')['Payment Method'].count().astype(str).sort_values (ascending = False)
print ('count_payment_male',count_payment_male)

count_payment_female = df[
    df['Gender']=='Female'].groupby('Payment Method')['Payment Method'].count().astype(str).sort_values (ascending = False)
print ('count_payment_female',count_payment_female)


# In[ ]:




