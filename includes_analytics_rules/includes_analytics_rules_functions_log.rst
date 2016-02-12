.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use ``log()`` to generate a message using the configured logger as a string.

The syntax for this function:

.. code-block:: ruby

   log(messageToLog)

where:

* ``messageToLog`` is the message that is added to the log

For example:

.. code-block:: ruby

   log('Added rule for org <obj.organization_name>')
