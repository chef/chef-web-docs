.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use the ``cookbook_name`` method to return the name of a cookbook. 

The syntax for the ``cookbook_name`` method is as follows:

.. code-block:: ruby

   cookbook_name

This method is often used as part of a log entry. For example:

.. code-block:: ruby

   Chef::Log.info('I am a message from the #{recipe_name} recipe in the #{cookbook_name} cookbook.')
