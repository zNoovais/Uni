from abc import abstractmethod
import numpy as np
from layers import Layer

class ActivationLayer(Layer):

    def forward_propagation(self, input, training):
        self.input = input
        self.output = self.activation_function(self.input)
        return self.output

    def backward_propagation(self, output_error):
        return self.derivative(self.input) * output_error

    @abstractmethod
    def activation_function(self, input):
        raise NotImplementedError

    @abstractmethod
    def derivative(self, input):
        raise NotImplementedError

    def output_shape(self):
        return self._input_shape

    def parameters(self):
        return 0
    

class SigmoidActivation(ActivationLayer):

    def activation_function(self, input):
        # TODO 3
        # Apply the sigmoid function (outputs values between 0 and 1).
        raise NotImplementedError

    def derivative(self, input):
        # TODO 4
        # Use the sigmoid output to compute its derivative.
        # Hint: it can be expressed in terms of sigmoid(input) itself.
        raise NotImplementedError


class ReLUActivation(ActivationLayer):

    def activation_function(self, input):
        return np.maximum(0, input)

    def derivative(self, input):
        # TODO 2
        # Return 1 for positive inputs and 0 otherwise.
        raise NotImplementedError
