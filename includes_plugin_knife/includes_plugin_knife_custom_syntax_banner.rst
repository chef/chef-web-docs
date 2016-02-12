.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A banner displays the syntax for the plugin to users when they enter the ``--help`` option. Use the ``banner`` method in the class body similar to the following:

.. code-block:: ruby

   module example
     class example < Chef::Knife

     banner "knife example"
   
     ...
   end

and the when a user enters ``knife --help``, the following will be displayed:

.. code-block:: bash

   **EXAMPLE COMMANDS**
   knife example
