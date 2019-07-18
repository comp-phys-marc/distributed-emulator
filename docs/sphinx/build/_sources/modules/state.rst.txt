==============
State (Python)
==============

************
Class
************

**State** is a class that represents a full quantum state and maintains a set of underlying  basis  vectors  with  coefficients using the *Ket* class.
To initialize a *state*, one must provide a *ket_list*,  *num_qubits*  and  *symbol*.  The *ket_list* should be a list of instances  of  the *Ket* class.
*num_qubits* should be an Integer that specifies the size  of  quantum  register  required  for the  coming  experiment.   The *symbol* is  simply
a *String* that  will  be  used to visually differentiate between states that  are  used  and  printed  out  within the same program.  An
additional local data  structure requirements is  maintained within each *state* which can be used  to  record  information  about  the complexity and
timing of the state as seen during an experiment.

Data
====

The  local  data  for  a  *state*  object might be the following.

.. code-block:: python

   kets = []
   num_qubits = 5
   symbol = "q"
   requirements = {}


Methods
=======


**state.add_ket (self, ket) → ()** adds a *Ket* object to the list *state.kets*.



**state.remove\_ket (self, ket) → ()** removes a *Ket* object from the list *state.kets*.



**state.get\_components (self, qubit) → ()** determines the two components :math:`\alpha` and :math:`\beta` of the state vector for the given target qubit. This is achieved by the following calculation, where :math:`v_i` are the basis vectors, :math:`c_i` is the :math:`i^{th}` complex coefficient, and :math:`v_{i_q}` is the value of the qubit :math:`q` for basis vector :math:`v_i`.

.. math::
    \begin{bmatrix}
        \alpha \\
        \beta \\
    \end{bmatrix} =
    \begin{bmatrix}
        \sum_{v_i} v_{i_q} \times c_i \\
        \sum_{v_i} v_{i_q} \times \bar{c_i} \\
    \end{bmatrix}




**state.get\_density\_matrix (self, qubit) → ()** determines the four components of the density matrix for the given target qubit. This is achieved by the following calculation. :math:`v_i` are the basis vectors. :math:`\alpha` and :math:`\beta` are the components of the given qubit's state vector determined using a call to *state.get_components*.

.. math::
    \rho = \begin{bmatrix}
        \alpha^2 & \alpha \bar{\beta} \\
        \beta \bar{\alpha} & \beta^2 \\
    \end{bmatrix}

**state.x (self, qubit) → (self)** performs a Pauli X gate on the target qubit by calling :math:`ket.x \; \forall \; ket \in state.kets`. *state.x* prints the state in Dirac notation before and after the operation. The state is normalized, printed and changes to experiment requirements are registered after each use.



**state.cx (self, source, target) → (self)** performs a Controlled X gate on the target qubit with the source qubit as controller by calling :math:`ket.cx \; \forall \; ket \in state.kets`. *state.cx* prints the state Dirac notation before and after the operation. The state is normalized, printed and changes to experiment requirements are registered after each use.



**state.y (self, qubit) → (self)** performs a Pauli Y gate on the target qubit by calling :math:`ket.y \; \forall \; ket \in state.kets`. *state.y* prints the state in Dirac notation before and after the operation. The state is normalized, printed and changes to experiment requirements are registered after each use.



**state.z (self, qubit) → (self)** performs a Pauli Z gate on the target qubit by calling :math:`ket.z \; \forall \; ket \in state.kets`. *state.z* prints the state in Dirac notation before and after the operation. The state is normalized, printed and changes to experiment requirements are registered after each use.



**state.s (self, qubit) → (self)** performs an S phase shift gate on the target qubit by calling :math:`ket.s \; \forall \; ket \in state.kets`. *state.s* prints the state in Dirac notation before and after the operation. The state is normalized, printed and changes to experiment requirements are registered after each use.



**state.sdg (self, qubit) → (self)** performs an S :math:`\dagger` phase shift gate on the target qubit by calling :math:`ket.sdg \; \forall \; ket \in state.kets`. *state.sdg* prints the state in Dirac notation before and after the operation. The state is normalized, printed and changes to experiment requirements are registered after each use.



**state.h (self, qubit) → (self)** performs a Hadamard gate on the target qubit by calling :math:`ket.h \; \forall \; ket \in state.kets`. *state.kets* is replaced by the list of all *Ket* objects returned from the calls to the *ket.h* methods. *state.h* prints the state in Dirac notation before and after the operation. The state is normalized, printed and changes to experiment requirements are registered after each use.



**state.post\_select (self, data) → (self)** filters the state's list *state.kets* for bitstrings that match a specific set of post selected outcomes given by *data*. *data* gives the post selection criteria as a key value mapping of qubit index and bit value. The method simply loops over each :math:`ket \in state.kets` and removes the objects that do not satisfy each post selection criteria. The state is normalized, printed and changes to experiment requirements are registered after each use.



**state.m (self, qubit) → (result)** measures the target qubit in the computational basis. *state.m* calculates the state vector components of the given *qubit* using the same approach as *get_components*, then calls an overrideable helper function *state._measure* to obtain a probabilistic outcome based on :math:`\alpha` and :math:`\beta`. *state.kets* becomes the set of objects in *state.kets* with basis vectors that agree with the measured value for the qubit in question. The state is normalized, printed and changes to experiment requirements are registered after each use.



**state.\_measure (self, alpha\_squared, beta\_squared) → (result)** uses pseudo-probability to simulate measuring a probabilistic qubit. This function might be overridden by an inheriting class to implement a more interesting measurement function.



**state.normalize (self, alpha\_squared, beta\_squared) → (self)** ensures that all basis vectors in *state.kets* are unique. In the case that basis vectors have been duplicated, the instances are combined by summing their complex coefficients and creating a new *Ket* object with the new coefficient. All original instances are removed. Once the basis vectors are unique, the state is normalized by multiplying each basis vector's complex coefficient by a normalizing factor.

.. math::
    |\psi_n> = \frac{1}{\sqrt{\sum_{v_i} |v_i|^2 }} |\psi>




**state.register\_requirements (self) → ()** checks if the current state of the quantum system is the most expensive yet seen during the experiment's runtime. If it is the most expensive state, updates the resource requirements. Requirements include but are not limited to:}


* bits
* floats
* flops



**state.print\_requirements (self) → ()** prints the requirements for maintaining the current state of the quantum system.



**state.print\_max\_requirements (self) → ()** prints the requirements for maintaining the most expensive state of the quantum system seen during the experiment.



**state.print (self) → ()** prints the full quantum state by calling :math:`ket.print \; \forall \; ket \in state.kets`.



**state.print\_state\_vectors (self) → ()** prints the state vector for each qubit using *state.get_components* to calculate :math:`\alpha` and :math:`\beta`.



**state.print\_density\_matrices (self) → ()** prints the density matrices for each qubit using *state.get_density_matrix*.
