from keras.preprocessing.image import load_img
import pandas as pd  #Library for handling dataframes
#import tensorflow as tf
import os

AnnoTable = pd.read_csv('csv_data/AnnoTable.csv')
AnnoRect = pd.read_csv('csv_data/AnnoRect.csv')
AnnoPoint = pd.read_csv('csv_data/AnnoPoint.csv')

AnnoTable = AnnoTable.drop(columns=['act_id'])
AnnoRect = AnnoRect.drop(columns=['x1', 'x2', 'y1', 'y2', 'scale'])
AnnoPoint = AnnoPoint.drop(columns=['id', 'is_visible'])

path = 'big_images/'+AnnoTable['name'][0]
path = [path]

for i in range(1, len(AnnoTable)):
    path.append('big_images/' + AnnoTable['name'][i])
AnnoTable['path'] = path

AnnoTable['x_scale'] = 0
AnnoTable['y_scale'] = 0

for i in range(0, len(AnnoTable)):
    if ~os.path.exists(AnnoTable['path'][i]):
        img = load_img(AnnoTable['path'][i], color_mode="grayscale")
        AnnoTable['x_scale'][i] = 128/img.width
        AnnoTable['y_scale'][i] = 72/img.height
        img = img.resize((128, 72))
        img.save('small_images/'+AnnoTable['name'][i], quality=100)
AnnoTable.to_csv('csv_data/AnnoTableScale.csv')
