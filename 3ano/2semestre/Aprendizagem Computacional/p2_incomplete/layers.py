from abc import ABCMeta, abstractmethod
import numpy as np
import copy

class Layer(metaclass=ABCMeta):

    @abstractmethod
    def forward_propagation(self, input):
        raise NotImplementedError
    
    @abstractmethod
    def backward_propagation(self, error):
        raise NotImplementedError
    
    @abstractmethod
    def output_shape(self):
        raise NotImplementedError
    
    @abstractmethod
    def parameters(self):
        raise NotImplementedError
    
    def set_input_shape(self, input_shape):
        self._input_shape = input_shape

    def input_shape(self):
        return self._input_shape
    
    def layer_name(self):
        return self.__class__.__name__
    

class DenseLayer(Layer):
    
    def __init__(self, n_units, input_shape=None):
        super().__init__()
        self.n_units = n_units
        self._input_shape = input_shape

        self.input = None
        self.output = None
        self.weights = None
        self.biases = None
        self.w_opt = None
        self.b_opt = None
        
    def initialize(self, optimizer):
        # initialize weights from a 0 centered uniform distribution [-0.5, 0.5)
        self.weights = np.random.rand(self.input_shape()[0], self.n_units) - 0.5
        # initialize biases to 0
        self.biases = np.zeros((1, self.n_units))
        # Each layer needs its own optimizer state (e.g. retained_gradient), so we deepcopy
        self.w_opt = copy.deepcopy(optimizer)
        self.b_opt = copy.deepcopy(optimizer)
        return self
    
    def parameters(self):
        # total number of trainable parameters: all weights + all biases
        # np.prod multiplies all shape dimensions (e.g. (4,3) -> 12)
        return np.prod(self.weights.shape) + np.prod(self.biases.shape)

    def forward_propagation(self, inputs, training):
        # TODO 1
        # Store the input, then compute the linear transformation using weights and biases.
        raise NotImplementedError
 
    def backward_propagation(self, output_error):
        # TODO 8
        # Compute the gradients for the input, weights and biases.
        # Update weights and biases using the optimizer.
        # Return the error to propagate to the previous layer.
        raise NotImplementedError

    def output_shape(self):
        return (self.n_units,)

    def set_biases(self, new_biases):
        self.biases = new_biases

    def set_weigths(self, new_wmatrix):
        self.weights = new_wmatrix
