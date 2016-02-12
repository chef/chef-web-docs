.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A range matching search pattern is used to query for values that are within a range defined by upper and lower boundaries. A range matching search pattern can be inclusive or exclusive of the boundaries. Use square brackets ("[ ]") to denote inclusive boundaries and curly braces ("{ }") to denote exclusive boundaries and with the following syntax:

.. code-block:: ruby

   boundary TO boundary

where ``TO`` is required (and must be capitalized).