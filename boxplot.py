# The following code to create a dataframe and remove duplicated rows is always executed and acts as a preamble for your script: 

# dataset = pandas.DataFrame(transaction_id, town_clean, resale_price)
# dataset = dataset.drop_duplicates()

# Paste or type your script code here:

import seaborn as sns 
import matplotlib.pyplot as plt 

#Get rank based on transaction amount to match bar graph, 
dataset_rank = dataset.groupby('town_clean', as_index = False)['transaction_id'].count()
dataset = dataset[['town_clean', 'resale_price']].merge(dataset_rank[['town_clean','transaction_id']], on = 'town_clean', how = 'left')
dataset = dataset.sort_values(by = 'transaction_id', ascending = False)

#Plot Box plot.
sns.set(font_scale = 1)
fig, (ax1) = plt.subplots(1,1, figsize = (45,25))
sns.boxplot(data = dataset, x = 'town_clean', y = 'resale_price', ax = ax1, color = '#D9EAF1')
ax1.set_xticklabels(ax1.get_xticklabels(), rotation = 45)
ax1.set_ylabel(None)
ax1.set_xlabel(None)

plt.show()
