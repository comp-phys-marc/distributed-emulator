=================
Ensemble (Python)
=================

**Ensemble** is a class that maintains a set of quantum systems and supports interactions between them.



**ensemble.add\_subsystem (self, subsystem) → ()** adds a subsystem (i.e. *State* object) to the list *self.subsystems*.



**ensemble.m (self, system, qubit) → (result)** measures a qubit and collapses quantum state across interacting subsystems accordingly. Calls *entangled\_ket.should\_collapse* :math:`\; \forall \; ket \in subsystem.kets \; \forall \; subsystem \in self.subsystems.kets` to determine what kets should be collapsed.



**ensemble.cx (self, source\_system, source\_qubit, target\_system, target\_qubit) → (target\_system)** performs a Controlled X gate between subsystems. Simply delegates the call if *source\_system = target\_system*. Otherwise, each the information of each :math:`ket \in target\_subsystem.kets` is copied to a new *EntangledKet* object *new\_ket*. *new\_ket.x* is called and provided *target\_qubit*. Then, *new\_ket.entangle* is provided :math:`outcome=0, system=source\_system, qubit=source\_qubit` and used to track the effects of entanglement on *new\_ket*. *ket* is replaced with a new *entangled\_ket* if it was not an instance of the *EntangledKet* class. *ket.entangle* is called and provided :math:`outcome=1, system=source\_system, qubit=source\_qubit`. The subsystem is printed at the beginning and end of the method.



**ensemble.execute (self) → ()** calls the *subsystem.execute* method on each :math:`subsystem \in self.subsystems` if it is defined.



**ensemble.print\_max\_requirements (self) → ()** prints the requirements for the most expensive states and operations encountered in the ensemble during an experiment.



**ensemble.print\_density\_matrices (self) → ()** prints the density matrix representations of each qubit in each subsystem.