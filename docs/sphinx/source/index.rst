====================================
Quantum Experiment Engine
====================================

:Release: |release|
:Date: |today|

An open-source software architecture for **hybrid quantum computing**. It is
the heart of a **quantum cloud native programming** and orchestration platform, implemented in Python,
Rust and more.

*****
Todo
*****

* Fully switch from Docker to Kubernetes container orchestration
* Implement NetKet based Hamiltonian simulator service
* Implement PennyLane based Quantum Machine Learning service
* Implement Continuous Variable Quantum Computing service based on StrawberryFields
* Implement Ocean based Quantum Annealing service
* Implement more visualizations for each type of simulation
* Add orchestration to the UI
* Document web API

**************
Documentation
**************

.. image:: _static/stacked-node.png
    :align: right
    :width: 320px
    :target: javascript:void(0);

.. toctree::
   :maxdepth: 2

   modules/dev.md
   modules/rust.md
   modules/dep.md
   modules/api.md
   modules/sim.md
   modules/user.md
   modules/analysis.md
   modules/parser.rst
   modules/ket.rst
   modules/state.rst
   modules/ibmqx_state.rst
   modules/ibmqx_vis_state.rst
   modules/tensor_state.rst
   modules/coefficient.rst
   modules/ensemble.rst
   modules/entanglement.rst
   modules/entangled_ket.rst
   modules/profiler.rst
   modules/tests/constants.rst
   modules/qasm_tests.rst