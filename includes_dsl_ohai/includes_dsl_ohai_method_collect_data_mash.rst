.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use a mash to store data. This is done by creating a new mash, and then setting an attribute to it. For example:

.. code-block:: ruby

   provides 'name_of_mash'
   name_of_mash Mash.new
   name_of_mash[:attribute] = 'value'
