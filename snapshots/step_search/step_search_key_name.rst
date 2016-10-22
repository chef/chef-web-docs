.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To see the available keys for a node, enter the following (for a node named ``staging``):

.. code-block:: bash

   $ knife node show staging -Fj | less
   
to return a full JSON description of the node and to view the available keys with which any search query can be based. 
