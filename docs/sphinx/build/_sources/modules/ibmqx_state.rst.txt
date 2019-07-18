===================
IBMQXState (Python)
===================

**IBMQXState** is class that represents a quantum system being run on IBM's quantum computer platform.
To initialize a *ibmqx_state*, one must provide *num_qubits*  and  *symbol*. Optionally, a list of instances  of  the *Ket* class can be passed in as *ket_list* to represent
the initial system state. *num_qubits* should be an *Integer* that specifies the size  of  quantum  register  required  for the  coming  experiment.   The *symbol* is
a *String* that  will  be  used to identify the quantum register that is provisioned with IBM Q during the execution of experiments using this *ibmqx_state*. An
additional local data  structure requirements is  maintained within each *ibmqx_state* which can be used  to  record  information  about  the backend quantum processor,
qubits and gates used by the state during an experiment. The  local  data  for  a  *ibmqx_state*  object might be the following. An instantiator can optionally provide a pre-initialinstance of the IBM Quantum Experience API wrapper provided by their python library *IBMQiuantumExperience* and/or an *api_token* that corresponds to the current user's IBM Q account.
A final local variable *jobs* accumulates results from various circuits that are run using the *ibmqx_state*.

.. code-block:: python

   kets = []
   num_qubits = 5
   symbol = "q"
   requirements = {}
   jobs= []
   device = 'ibmqx4'
   api = None
   api_token = None
   qasm = 'OPENQASM 2.0;\ninclude "qelib1.inc";\nqreg q[5];\ncreg c[5];'

**ibmqx_state._test_api_auth_token (self) → (credential)** authenticates with the IBM Quantum Experience Platform using the library *IBMQuantumExperience* if *self.api_token* is valid.

**ibmqx_state._connect (self) → ()** attempts to connect to the Quantum Experience Platform. Calls *ibmqx_state._test_api_auth_token* and then sets *self.api* to the authenticated api wrapper instance provided by *IBMQuantumExperience*.


**ibmqx_state.x (self, qubit) → (self)** prepares to perform a Pauli X gate on the target qubit by adding the QASM for the corresponding operation and qubit to *self.qasm*. *ibmqx_state.x* prints the qasm after the operation. Changes to experiment requirements are registered after each use.

Example QASM

.. code-block:: python

        x q[0];

**ibmqx_state.cx (self, source, target) → (self)** prepares to perform a Controlled X gate on the target qubit with the source qubit as controller by adding the QASM for the corresponding operation and qubit to *self.qasm*. Changes to experiment requirements are registered after each use.

Example QASM

.. code-block:: python

        cx q[0], q[1];

**ibmqx_state.y (self, qubit) → (self)** prepares to perform a Pauli Y gate on the target qubit by adding the QASM for the corresponding operation and qubit to *self.qasm*. *ibmqx_state.y* prints the qasm after the operation. Changes to experiment requirements are registered after each use.

Example QASM

.. code-block:: python

        y q[0];


**ibmqx_state.z (self, qubit) → (self)** prepares to perform a Pauli Z gate on the target qubit by adding the QASM for the corresponding operation and qubit to *self.qasm*. *ibmqx_state.z* prints the qasm after the operation. Changes to experiment requirements are registered after each use.

Example QASM

.. code-block:: python

        z q[0];


**ibmqx_state.s (self, qubit) → (self)** prepares to perform an S phase shift gate on the target qubit by adding the QASM for the corresponding operation and qubit to *self.qasm*. *ibmqx_state.s* prints the qasm after the operation. Changes to experiment requirements are registered after each use.

Example QASM

.. code-block:: python

        s q[0];


**ibmqx_state.sdg (self, qubit) → (self)** prepares to perform an S :math:`\dagger` phase shift gate on the target qubit by adding the QASM for the corresponding operation and qubit to *self.qasm*. *ibmqx_state.s* prints the qasm after the operation. Changes to experiment requirements are registered after each use.

Example QASM

.. code-block:: python

        sdq q[0];


**ibmqx_state.h (self, qubit) → (self)** prepares to perform a Hadamard gate on the target qubit by adding the QASM for the corresponding operation and qubit to *self.qasm*. *ibmqx_state.h* prints the qasm after the operation. Changes to experiment requirements are registered after each use.

Example QASM

.. code-block:: python

        h q[0];


**ibmqx_state.u1 (self, lamb, qubit) → (self)** prepares to perform a single-parameter single-qubit phase gate with zero duration on the target qubit by adding the QASM for the corresponding operation, parameter and qubit to *self.qasm*. *ibmqx_state.u1* prints the qasm after the operation. Changes to experiment requirements are registered after each use. The single-parameter phase gate has the following form:

.. math::
    u1(l) = \begin{bmatrix}
        1 & 0 \\
        0 & e^{li}
    \end{bmatrix}

Example QASM

.. code-block:: python

        u1(0.1) q[0];


**ibmqx_state.u3 (self, theta, phi, lamb, qubit) → (self)** prepares to perform a three-parameter single-qubit phase gate with zero duration on the target qubit by adding the QASM for the corresponding operation, parameter and qubit to *self.qasm*. *ibmqx_state.u1* prints the qasm after the operation. Changes to experiment requirements are registered after each use. The single-parameter phase gate has the following form:

.. math::
    u3(t,p,l) = \begin{bmatrix}
        cos(\frac{t}{2}) & -e^{li} sin(\frac{t}{2}) \\
        e^{pi} sin(\frac{t}{2}) & e^{li + pi} cos(\frac{t}{2})
    \end{bmatrix}

Example QASM

.. code-block:: python

        u3(0.1, 0.2, 0.1) q[0];


**ibmqx_state.barrier (self, qubit) → (self)** prepares to apply a barrier to the circuit to disable circuit optimization. If no *qubit* param is provided, applies as barrier across the entire quantum register. Changes to experiment requirements are registered after each use.

Example QASM

.. code-block:: python

        barrier q;


**ibmqx_state.m (self, qubit) → (self)** prepares to measure the target qubit in the computational basis by adding QASM specifying that the target qubit should be measured into the matching classical register location. Changes to experiment requirements are registered after each use.

Example QASM

.. code-block:: python

        measure q[0] -> c[0];


**ibmqx_state.tomography (self, qubit, phases, shots, continue_from) → (results)** replicates the current state's QASM circuit and performs measurements in each of the three orthogonal axes of the Bloch sphere to determine the qubit's state. Performs the full tomography approach defined in section three of reference `[1] <https://arxiv.org/abs/1805.07185>`_.
*phases* gives the number of equally spaced relative phases to sample with respect to each of the three orthogonal axes. Each phase measurement circuit is run a number of times equal to *shots*.
*continue_from* allows for long-running tomography experiemnts to be resumed. This parameter specifies where to continue the tomography algorithm from in the case that it has been split up over time.
Calls *self._analyze_tomographic_results* to immediately reconstruct the state if the backend is IBM's simulator "ibmq_qasm_simulator" and the data is therefore immediately available.

Three different *IBMQXState* instances are created per relative phase, one for each orthogonal axis. these are :math:`ibmqx\_state_x`, :math:`ibmqx\_state_y` and :math:`ibmqx\_state_z`. The jth phase to sample at each axis is calculated by:

.. math::

    phase_j = \frac{2 \pi j}{phases - 1}

Each such phase is applied on each state by calling :math:`state.u1 \; \forall \; state \in` :math:`\{ibmqx\_state_x,ibmqx\_state_y, ibmqx\_state_z\}`.
Then the appropriate transformation is applied to each state to rotate the correct axis into the measureable dimension. The transformations for each axis are the following:

.. list-table:: Axis Rotations
   :widths: 25 25 50
   :header-rows: 1

   * - X-Axis
     - Y-Axis
     - Z-Axis
   * - **M H**
     - **M H S**:math:`\dagger`
     - **M**

Example QASM

.. code-block:: python

    # Excerpt from Code for Tomography on Qubit 4

    # PI phase on X-Axis
    IBMQX QASM:
    OPENQASM 2.0;
    include "qelib1.inc";
    qreg q[5];
    creg c[5];
    h q[2];
    cx q[2], q[1];
    cx q[1], q[0];
    x q[3];
    cx q[3], q[2];
    h q[3];
    h q[1];
    u1(0.3141592653589793) q[4];
    h q[4];
    measure q[0] -> c[0];

    # PI phase on Y-Axis
    IBMQX QASM:
    OPENQASM 2.0;
    include "qelib1.inc";
    qreg q[5];
    creg c[5];
    h q[2];
    cx q[2], q[1];
    cx q[1], q[0];
    x q[3];
    cx q[3], q[2];
    h q[3];
    h q[1];
    u1(0.3141592653589793) q[4];
    sdg q[4];
    h q[4];
    measure q[0] -> c[0];

    # PI phase on Z-Axis
    IBMQX QASM:
    OPENQASM 2.0;
    include "qelib1.inc";
    qreg q[5];
    creg c[5];
    h q[2];
    cx q[2], q[1];
    cx q[1], q[0];
    x q[3];
    cx q[3], q[2];
    h q[3];
    h q[1];
    u1(0.3141592653589793) q[4];
    measure q[0] -> c[0];


**ibmqx_state._analyze_tomographic_results (self, qubit, phases, shots, continue_from) → (results)**

**ibmqx_state.register\_requirements (self) → ()** checks if the current state of the quantum system is the most expensive yet seen during the experiment's runtime. If it is the most expensive state, updates the resource requirements. Requirements include but are not limited to:

* qubits
* gates
* processor


**ibmqx_state.print\_requirements (self) → ()** prints the requirements for maintaining the current state of the quantum system, and the current calibration details for the configured backend.

Example QASM

.. code-block:: python

    {
        "qubits": 14,
        "gates": 1,
        "processor": "ibmq_16_melbourne"
    }
    {
      "lastUpdateDate": "2019-06-09T06:33:12.000Z",
      "fridgeParameters": {
        "cooldownDate": "2018-07-10",
        "Temperature": {
          "date": "2019-06-09T08:39:05Z",
          "value": "None",
          "unit": "K"
        }
      },
      "qubits": [
        {
          "name": "Q0",
          "buffer": {
            "date": "2019-06-09T06:13:34Z",
            "value": 10,
            "unit": "ns"
          },
          "gateTime": {
            "date": "2019-06-09T06:13:34Z",
            "value": 100,
            "unit": "ns"
          },
          "T2": {
            "date": "2019-06-09T06:33:12Z",
            "value": 21.8,
            "unit": "µs"
          },
          "T1": {
            "date": "2019-06-09T06:32:00Z",
            "value": 48,
            "unit": "µs"
          },
          "frequency": {
            "date": "2019-06-09T06:13:34Z",
            "units": "GHz",
            "value": 5.1002374
          }
        },

        ...

      ],
      "backend": "ibmq_16_melbourne"
    }


**ibmqx_state.print\_max\_requirements (self) → ()** prints the requirements for maintaining the most expensive state of the quantum system seen during the experiment.


**ibmqx_state.print (self) → ()** prints *self.qasm*.

*******************
Exception Handling
*******************

**backend_exception** is an exception that is raised when an error is returned from a remote system.

**retry_if_backend_error (exception) → (success)** implements exponential backoff by waiting 2^x * 100000 milliseconds between each retry.


***********
References
***********

* 1. Shukla, Abhishek, et al. “Complete Characterization of the Directly Implementable Quantum Gates Used in the IBM Quantum Processors.” 2018.