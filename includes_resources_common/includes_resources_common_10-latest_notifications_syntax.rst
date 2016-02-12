.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The basic syntax of a notification is:

.. code-block:: ruby

   notifies ( [ {resources('execute[something]') => [:notification, :timer] } ] )

and to specify multiple notifications in a single call:

.. code-block:: ruby

   notifies ( [ {resources('execute[something]') => [:notification, :timer]},
   {resources('execute[something]') => [:notification, :timer]},
   {resources('execute[something]') => [:notification, :timer]} ] )
