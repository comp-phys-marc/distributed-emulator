=====================
TensorState (Python)
=====================

************
Class
************

**TensorState** is a class that represents a full quantum state  in the tensor representation using Google's TensorFlow.
To initialize a *tensor_state*, one provides *num_qubits*  and  *symbol*. Optionally, a list of instances  of  the *Ket* class can be passed in as *ket_list* to represent
the initial system state. *num_qubits* should be an *Integer* that specifies the size  of  quantum  register  required  for the  coming  experiment. The *symbol* is  simply
a *String* that  will  be  used to visually differentiate between states that  are  used  and  printed  out  within the same program.  An
additional local data  structure requirements is  maintained within each *tensor_state* which can be used  to  record  information  about  the complexity and timing  dependencies
of the state as seen during an experiment.

Data
====

The  local  data  for  a  *tensor_state*  object might be the following.

.. code-block:: python

   state = <TFVariable instance>
   num_qubits = 1
   symbol = "t"
   requirements = {}


Methods
=======

**tensor_state.x (self, qubit) → (self)** performs a Pauli X gate on the target qubit by applying the appropriate operator to the current state. *state.x* prints the state before and after the operation. Changes to experiment requirements are registered after each use.

.. math::

    X = \begin{bmatrix}
        0 & 1 \\
        1 & 0 \\
    \end{bmatrix}

**tensor_state.cx (self, source, target) → (self)** performs a Controlled X gate on the target qubit with the source qubit as controller by applying the appropriate operator to the current state. *state.x* prints the state before and after the operation. Changes to experiment requirements are registered after each use.

.. math::

    CX = \begin{bmatrix}
        1 & 0 & 0 & 0 \\
        0 & 1 & 0 & 0 \\
        0 & 0 & 0 & 1 \\
        0 & 0 & 1 & 0 \\
    \end{bmatrix}

**tensor_state.y (self, qubit) → (self)** performs a Pauli Y gate on the target qubit by applying the appropriate operator to the current state. *state.y* prints the state before and after the operation. Changes to experiment requirements are registered after each use.

.. math::

    Y = \begin{bmatrix}
        0 & -i \\
        i & 0 \\
    \end{bmatrix}


**tensor_state.z (self, qubit) → (self)** performs a Pauli Z gate on the target qubit by applying the appropriate operator to the current state. *state.z* prints the state before and after the operation. Changes to experiment requirements are registered after each use.

.. math::

    Z = \begin{bmatrix}
        1 & 0 \\
        0 & -1 \\
    \end{bmatrix}



**tensor_state.s (self, qubit) → (self)** performs an S gate on the target qubit by applying the appropriate operator to the current state. *state.s* prints the state before and after the operation. Changes to experiment requirements are registered after each use.

.. math::

    S = \begin{bmatrix}
        1 & 1 \\
        0 & i \\
    \end{bmatrix}


**tensor_state.sdg (self, qubit) → (self)** performs an S:math:`\dagger` gate on the target qubit by applying the appropriate operator to the current state. *state.sdg* prints the state before and after the operation. Changes to experiment requirements are registered after each use.

.. math::

    S^{\dagger} = \begin{bmatrix}
        1 & 1 \\
        0 & -i \\
    \end{bmatrix}


**tensor_state.h (self, qubit) → (self)** performs a Hadamard gate on the target qubit by applying the appropriate operator to the current state. *state.h* prints the state before and after the operation. Changes to experiment requirements are registered after each use.

.. math::

    H = \frac{1}{\sqrt{2}} \begin{bmatrix}
        1 & 1 \\
        1 & -1 \\
    \end{bmatrix}


**tensor_state.m (self, qubit) → (result)** measures the target qubit in the computational basis. The *qubit* state needs to be extracted from the overall state tensor *self.state* which has a potentially high dimension. So, the measurement is performed in a few steps.

* A iso matrix is used to isolate the amplitudes of the target qubit, nulling the rest of the state.
* The locations of non-zero surviving terms are collected.
* The locations are checked to see if the target is in a pure observable state.
* If the target is not a pure observable, measurement is simulated using pseudo-probability.

**tensor_state.\_measure (self, alpha) → (result)** uses pseudo-random number generation to simulate the probabilistic outcome of a
qubit measurement. The quantum system is updated with the measurement results. *alpha* is expected to be the first component in teh state vector of the qubit
being measured.


**tensor_state.register\_requirements (self) → ()** checks if the current state of the quantum system is the most expensive yet seen during the experiment's runtime. If it is the most expensive state, updates the resource requirements. Requirements include but are not limited to:

* floats
* flops


**tensor_state.print\_requirements (self) → ()** prints the requirements for maintaining the current state of the quantum system.


**tensor_state.print\_max\_requirements (self) → ()** prints the requirements for maintaining the most expensive state of the quantum system seen during the experiment.


**tensor_state.print (self) → ()** prints the full quantum state *self.state* as well as the shape and trace of the state.
