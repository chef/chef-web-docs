.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use ``alert:<level>()`` to generate an audit.

The syntax for this function:

.. code-block:: ruby

   alert:<level>(description)

where:

* ``<level>`` is the audit level: ``error``, ``info``, or ``warn``
* ``description`` is a user-defined value (and may be a |mustache| template)
