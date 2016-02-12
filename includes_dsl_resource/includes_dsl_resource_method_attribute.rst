.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``attribute`` method is used to define a list of properties and any of those property's associated validation parameters. The syntax for the ``attribute`` method is as follows:

.. code-block:: ruby

   attribute :property_name :validation_parameter => value, :validation_parameter => value

where ``attribute`` must have an property name and zero (or more) validation parameters.
