import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from numpy import array
print("imported basic libs")
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score, confusion_matrix, classification_report, ConfusionMatrixDisplay
from sklearn.metrics import f1_score
from sklearn.metrics import recall_score
print("imported sklearn")
from tensorflow import keras
print("imported keras")
from tensorflow.keras.models import Model
from tensorflow.keras.metrics import Precision
import tensorflow as tf
from tensorflow.keras.layers import Conv1D, BatchNormalization, Activation, Add, Flatten, Dense, Dropout
from tensorflow.keras.models import Model
from tensorflow.keras.utils import to_categorical
get_ipython().run_line_magic('matplotlib', 'inline')
print("imported some ipython thing")
from functools import partial
from collections import OrderedDict
import torch
import torch.nn as nn
import os
print("imported everything")

print(tf.test.is_gpu_available())
print(tf.config.list_physical_devices('GPU'))
node1 = tf.constant(3.0, dtype=tf.float32)
node2 = tf.constant(4.0) # also tf.float32 implicitly

print(node1, node2)
