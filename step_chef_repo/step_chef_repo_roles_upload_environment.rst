.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To upload an environment to the |chef server|, run the following command:

.. code-block:: bash

   $ knife environment from file environment/environment.rb
   
where ``environment`` is the name of the file that will be uploaded.
