.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A |knife| plugin should have its own namespace (even though |knife| will load a command regardless of its namespace). The namespace is declared using the ``module`` method, for example:

.. code-block:: ruby

   require 'chef/knife'
   # other require attributes, as needed
   
   module MyNamespace
     class SubclassName < Chef::Knife

where ``module MyNamespace`` declares that the |knife| plugin has its own namespace, with a namespace of ``MyNamespace``.