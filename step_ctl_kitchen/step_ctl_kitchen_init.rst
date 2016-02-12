.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


.. code-block:: bash

   $ kitchen init --driver=kitchen-vagrant

will return something similar to:

.. code-block:: bash

   create .kitchen.yml
   create test/integration/default
   create .gitignore
   append .gitignore
   append .gitignore
   run    gem install kitchen-vagrant from "."
   Fetching: kitchen-vagrant-0.12.0.gem (100%)
   Successfully installed kitchen-vagrant-0.12.0
   1 gem installed
