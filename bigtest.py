import tensorflow as tf
import torch
import transformers
import sklearn
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import huggingface_hub
import jax
import flax
print("imports are OK")

def test_tensorflow():
    print("TensorFlow version:", tf.__version__)
    print("GPU available:", tf.config.list_physical_devices('GPU'))

def test_torch():
    print("PyTorch version:", torch.__version__)
    print("GPU available:", torch.cuda.is_available())

def test_transformers():
    print("Transformers version:", transformers.__version__)

def test_sklearn():
    print("Scikit-learn version:", sklearn.__version__)

def test_pandas():
    print("Pandas version:", pd.__version__)

def test_numpy():
    print("NumPy version:", np.__version__)

def test_matplotlib():
    print("Matplotlib version:", plt.__version__)

def test_huggingface_hub():
    print("Hugging Face Hub version:", huggingface_hub.__version__)

def test_jax():
    print("JAX version:", jax.__version__)
    print("GPU available:", jax.lib.xla_bridge.get_backend().platform)

def test_flax():
    print("Flax version:", flax.__version__)

if __name__ == "__main__":
    test_tensorflow()
    test_torch()
    test_transformers()
    test_sklearn()
    test_pandas()
    test_numpy()
    test_matplotlib()
    test_huggingface_hub()
    test_jax()
    test_flax()
