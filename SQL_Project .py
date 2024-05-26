#!/usr/bin/env python
# coding: utf-8

# 
# import pandas as pd 
# !pip install psycopg2
# from sqlalchemy import create_engine 

# In[6]:


conn_string = 'postgresql://postgres:admin@localhost/Famous_Paintings'


# In[7]:


db = create_engine(conn_string)


# In[8]:


conn = db.connect()


# In[10]:


df = pd.read_csv('/Users/vishwajamane/Downloads/archive-3/artist.csv')


# In[13]:


df.head()


# In[14]:


df.info()


# In[15]:


df.to_sql('artist',con=conn, if_exists='replace',index=False)


# In[31]:


files = ['artist','canvas_size','image_link','museum_hours','museum','product_size','subject','work']


# In[32]:


for file in files:
    df = pd.read_csv(f'/Users/vishwajamane/Downloads/archive-3/{file}.csv')
    df.to_sql(file,con=conn, if_exists='replace',index=False)
    


# In[ ]:




