=====================
Entanglement (Python)
=====================

**Entanglement** is a class that encapsulates the information that is needed to determine how entanglement will affect a particular *Ket* object.

An *Entanglement* object has initialization parameters *outcome, system, qubit*. The provided *outcome* is the measurement outcome for which a *ket* will **not** disappear. *qubit* is an entangled qubit index. The *system* is a system owning the qubit which is entangled.

The data local to an *Entanglement* object might be the following.

.. code-block:: python

    self._outcome = 0
    self._system = State
    self._qubit = 2


**entanglement.get\_outcome (self) → (self.\_outcome)** is a method that allows for the retrieval of the outcome.



**entanglement.get\_system (self) → (self.\_system)** is a method that allows for the retrieval of the system.



**entanglement.get\_qubit (self) → (self.\_qubit)** is a method that allows for the retrieval of the qubit.