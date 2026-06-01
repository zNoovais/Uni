from abc import abstractmethod
import numpy as np

class LossFunction:

    @abstractmethod
    def loss(self, y_true, y_pred):
        raise NotImplementedError

    @abstractmethod
    def derivative(self, y_true, y_pred):
        raise NotImplementedError


class MeanSquaredError(LossFunction):

    def loss(self, y_true, y_pred):
        return np.mean((y_true - y_pred) ** 2)

    def derivative(self, y_true, y_pred):
        return 2 * (y_pred - y_true) / y_true.size


class BinaryCrossEntropy(LossFunction):
    
    def loss(self, y_true, y_pred):
        # TODO 5
        # Clip predictions to avoid log(0), then apply the cross-entropy formula.
        raise NotImplementedError

    def derivative(self, y_true, y_pred):
        # TODO 6
        # Clip predictions to avoid division by zero, then compute the gradient.
        raise NotImplementedError
