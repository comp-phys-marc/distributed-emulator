==============
Ket
==============

**Ket** is a class that maintains the information that corresponds with a single ket i.e. :math:`| 000..0 >` which would appear in the Dirac notation of a quantum state. A *ket* object understands how each unitary transformation affects its bitstring and complex coefficient.

We use the string constants "0" and "1" to represent the computational basis states of the single qubit. These constants are declared in the *ket* package since it contains the lowest-level class which references the basis states. The local data for the *ket* package consists of these constants.

.. code-block:: python

    ZERO = "0"
    ONE = "1"

A *ket* can optionally be initialized with a complex coefficient and a bitstring value. However, these can be left empty at object instantiation and set later using *ket.set\_coefficient* and *ket.set\_val*.

In the spirit of object oriented programming, the *ket* class implements getters and setters. It also implements the supported unitary operators and a print function for readout.

The data local to a *ket* object are its bitstring value and a reference to its complex coefficient, which is an object itself. i.e.

.. code-block:: python

    val = "0000...0"
    coefficient = &coefficient

**ket.get\_val (self) → (self.val)** is a method that allows for the retrieval of a *ket's* bitstring as a *String*.



**ket.get\_coefficient (self) → (self.coefficient)** allows for the retrieval of a *ket's* complex coefficient, which will be either an instance of the *Coefficient* class, or *None*.



**ket.set\_val (self, val) → (self)** sets a *ket's* bitstring to a given *String val* if :math:`val \in [ONE, ZERO]`.



**ket.set\_coefficient (self, coefficient) → (self)** sets a *ket's* complex coefficient to a given a valid instance of the *Coefficient* class.



**ket.get\_probability (self) → (probability)** returns the probabilistic weight of the *ket's* basis vector :math:`v_i` within its overall quantum state, :math:`|v_i|^2`. This method does not perform the calculation of this probability, but delegates that calculation to the public method of the *coefficient* itself *to\_probability*.



**ket.x (self, qubit) → (self)** performs a Pauli X gate on the target qubit by simply flipping the appropriate bit in the bitstring *self.val*.



**ket.cx (self, source, target) → (self)** performs a Controlled-X gate on the target qubit with the source qubit as controller. This is done by simply flipping the appropriate target bit if the control is equal to *ONE*.



**ket.y (self, qubit) → (self)** performs a Pauli Y gate on the target qubit by simply calling the methods *self.x, self.z* and *self.coefficient.multiply\_by\_i*.



**ket.z (self, qubit) → (self)** performs a Pauli Z gate on the target qubit by calling the method *self.coefficient.negate\_magnitude* if the appropriate bit in the bitstring *self.val* is equal to *ONE*.



**ket.h (self, qubit) → (self, new\_ket)** performs a Hadamard gate on the target qubit by creating a new *ket* object with the a bitstring *ket.val* and coefficient *ket.coefficient* which are copies of *self.val* and *self.coefficient*. Then, if the appropriate bit in *self.val* is equal to *ONE*, calls *ket.coefficient.negate\_magnitude* on the new *ket*.



**ket.s (self, qubit) → (self)** performs an S phase shift gate on the target qubit by calling the method *self.coefficient.multiply\_by\_i* if the appropriate bit in the bitstring *self.val* is equal to *ONE*.



**ket.sdg (self, qubit) → (self)** performs an S :math:`\dagger` gate on the target qubit by calling both the methods *self.coefficient.multiply\_by\_i* and *self.coefficient.negate\_magnitude* if the appropriate bit in the bitstring *self.val* is equal to *ONE*. *self.val*.



**ket.print (self) → ()** prints the *ket* by first calling *self.coefficient.print* and then printing *self.val* in Dirac notation.