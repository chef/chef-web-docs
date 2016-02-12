.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use ``array:contains()`` to look for an attribute in the |json| object, and then determine its value.

The syntax for this function:

.. code-block:: ruby

   array:contains(field, valueToFind)

where:

* ``field`` is an attribute in the |json| oject
* ``valueToFind`` is the value for that attribute

For example:

.. code-block:: ruby

   array:contains(organization_name = 'ponyville')
