=====================
EntangledKet (Python)
=====================

************
Class
************

**EntangledKet** is a class that extends the *Ket* class. An *EntangledKet* object *entangled\_ket* has a list *entangled\_ket.\_entanglements* of *Entanglement* objects.


Methods
=======

**entangled\_ket.entangle (self, outcome, system, qubit) → ()** adds an *EntangledKet* object to the list *self.\_entanglements* with the given initialization parameters.



**entangled\_ket.is\_entangled\_with (self, system, qubit) → (is\_entangled)** determines whether the existence of a *ket* is predicated upon entanglement effects related to the given qubit by checking each element of *self.\_entanglements*.



**entangled\_ket.should\_collapse (self, outcome, system, qubit) → (should\_collapse)** determines whether the *ket* should collapse and disappear following a measurement of the given *qubit* yielding the given *outcome*.



**entangled\_ket.copy\_entanglement\_to (self, other\_ket) → ()** creates and adds a *Entanglement* instance to other\_ket.\_entanglements by calling *other\_ket.entangle* $\; \forall entanglement \in self.\_entanglements$.



**entangled\_ket.h (self, qubit) → (self)** performs a Hadamard gate on the target qubit and propagates entanglements to newly created *Ket* objects.