===================
QASM Parser (Python)
===================

************
Functions
************

**run_qasm (qasm, execution_type) → (parser)** parses a QASM code string and runs the code using an
ensemble of appropriate states. *qasm* is expected to be a QASM code string. *execution_type* can be used to specify the
type of experiment to run. For example, some otpions are: 'tensor', 'dirac' and 'ibmqx4'. the function returns a *Parser*
object containing the final contents of any classical registers, the sizes of each quantum register, and a reference to
the final state ensemble.


**_bits_for_reg_init (line) → (qubits, register_name)** interprets the size and location of the target register from
the QASM qreg or creg command given in *line*.


************
Class
************

**Parser** is a class that enables the parsing and execution of OpenQASM code in a simulation node.

Data
====

The local data for an instance of the *Parser* class consists of several variables. For example,
a *parser*'s local variables might be the following shortly after initialization.


.. code-block:: python

    self.type = 'dirac'

    self.ensemble = <Ensemble instance>
    self._gates = {
        'ensemble': {
            'cx': self.ensemble.cx,
            'm': self.ensemble.m
        }
    }

    self.quantum_registers = {}
    self._quantum_register_names = {}

    self.classical_registers = {}
    self._classical_register_names = {}


Dynamic Properties
==================

**_inverted_quantum_register_names** is the inverted *_quantum_register_names* dictionary. This inverted dict maps lookup location to name.

**_inverted_classical_register_names** is the inverted *_classical_register_names* dictionary. This inverted dict maps lookup location to name.


Methods
=======
``
**add_quantum_reg (self, qubits, name) → ()** adds a new quantum register of size *qubits* to the ensemble and *self.quantum_registers*, initialized to the |00...0> state.
The type of the new register will be either *Tensor*, *State* or *IBMQXState* according to the *execution_type* of the *parser*.

**add_classical_reg (self, bits, name) → ()** adds a new classical register of size *bits* to *self.classical_registers*.

**_gate_from_qasm_line (self, line, registers) → (method)** determines the subsystem method to be invoked to apply the operation found in
a line of QASM code containing an operator and the set of registers to be affected by the operation.


**_find_quantum_reg_by_name (self, register_name) → (register_index)** a method that finds the register lookup location from the register name, for quantum registers.

**_find_classical_reg_by_name (register_name) → (register_index)** a method that finds the register lookup location from the register name, for classical registers.

**_parse_operands (self, line, register_names, registers, reg_lookup_method) → (register_entries)** parses a given line of QASM code containing an operator to determine the
quantum or classical register entries that should be affected by the operation. *line* is expected to be a line of QASM code containing an operator. *register_names* is expected to be a mapping of register's names to their locations.
*registers* is expected to be the set of registers relevant to the operator, either quantum or classical. *reg_lookup_method* is expected to be a method that implements a transform from register name
to register lookup location.

**_parse_classical_operands(self, line) → (register_entries)** is a helper method that enables more imperative usage of *self._parse_operands* by calling it with the parameters *register_names=self._inverted_classical_register_names,* *registers=self.classical_registers,*
*reg_lookup_method=self._find_classical_reg_by_name*.

**_parse_quantum_operands(self, line) → (register_entries)** is a helper method that enables more imperative usage of *self._parse_operands* by calling it with the parameters *register_names=self._inverted_quantum_register_names,* *registers=self.quantum_registers,*
*reg_lookup_method=self._find_quantum_reg_by_name*.

**_measure (self, line) → (self.classical_registers)** determines the correct measurement method to invoke in order to affect the measurement operation specified in the given line of QASM code *line*, and applies the measurement operator.

**_parse_operation (self, line) → ()** determines the subsystem method to be invoked to apply the operation in a line of QASM code *line*.

Exceptions
==================

**UnsupportedInputException** is an exception that is raised when unsupported operations are found in QASM during parsing.

**BadHeaderException** is an exception that is raised when no valid QASM header is found.

**QasmProgrammingException** is an exception that is raised when a programming error is found in QASM.
