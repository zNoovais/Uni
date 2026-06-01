import os
import numpy as np
import matplotlib.pyplot as plt

from data import Data, read_csv
from layers import DenseLayer
from activation import SigmoidActivation
from losses import MeanSquaredError, BinaryCrossEntropy
from neuralnet import NeuralNetwork
from metrics import accuracy

# ============================================================
# XNOR - Forward pass with manually set weights
# ============================================================

print("=" * 50)
print("  XNOR FORWARD PASS")
print("=" * 50)

X_xnor = np.array([[0, 0], [1, 0], [0, 1], [1, 1]], dtype=float)
y_xnor = np.array([1, 0, 0, 1], dtype=float)
dataset_xnor = Data(X_xnor, y_xnor)

net_xnor = NeuralNetwork()
net_xnor.add(DenseLayer(2, (2,)))
net_xnor.layers[-1].set_biases(np.array([[-30, 10]]))
net_xnor.layers[-1].set_weigths(np.array([[20, -20], [20, -20]]))
net_xnor.add(SigmoidActivation())
net_xnor.add(DenseLayer(1))
net_xnor.layers[-1].set_biases(np.array([[-10]]))
net_xnor.layers[-1].set_weigths(np.array([[20], [20]]))
net_xnor.add(SigmoidActivation())

predictions_xnor = net_xnor.predict(dataset_xnor)
print(f"\n{'Input':<15} {'Expected':>10} {'Predicted':>10} {'Output':>10} {'Status':>10}")
print("-" * 57)
for inputs, pred, real in zip(X_xnor, predictions_xnor, y_xnor):
    pred_class = 1 if pred[0] >= 0.5 else 0
    status = "✓" if pred_class == int(real) else "✗"
    print(f"{str(inputs):<15} {int(real):>10} {pred_class:>10} {pred[0]:>10.4f} {status:>10}")


# ============================================================
# Breast Cancer - Train and evaluate
# ============================================================

print("\n" + "=" * 50)
print("  BREAST CANCER CLASSIFICATION")
print("=" * 50)

dataset = read_csv(os.path.join(os.path.dirname(__file__), 'breast-bin.csv'), sep=',', features=True, label=True)
print(f"\nDataset shape: {dataset.shape()}")

net = NeuralNetwork(epochs=1000, batch_size=16, learning_rate=0.001, verbose=False,
                    loss=BinaryCrossEntropy, metric=accuracy)
n_features = dataset.X.shape[1]
net.add(DenseLayer(6, (n_features,)))
net.add(SigmoidActivation())
net.add(DenseLayer(1))
net.add(SigmoidActivation())

print("\nTraining...")
net.fit(dataset)

out = net.predict(dataset)
score = net.score(dataset, out)
print(f"Accuracy: {score:.4f}")

epochs = list(net.history.keys())
losses = [net.history[e]['loss'] for e in epochs]
metrics = [net.history[e]['metric'] for e in epochs]

fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(12, 4))
fig.suptitle('Breast Cancer - Training History', fontsize=14)

ax1.plot(epochs, losses, color='steelblue')
ax1.set_title('Loss')
ax1.set_xlabel('Epoch')
ax1.set_ylabel('Loss')
ax1.grid(True, alpha=0.3)

ax2.plot(epochs, metrics, color='darkorange')
ax2.set_title('Accuracy')
ax2.set_xlabel('Epoch')
ax2.set_ylabel('Accuracy')
ax2.set_ylim(0, 1)
ax2.grid(True, alpha=0.3)

plt.tight_layout()
plt.show()
