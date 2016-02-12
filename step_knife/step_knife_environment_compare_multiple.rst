.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To compare cookbook versions for multiple environments:

.. code-block:: bash

   $ knife environment compare development staging

to return something similar to:

.. code-block:: bash

                 development    staging
   apache        2.3.1          1.2.2
   windows       4.1.2          1.0.0
   postgresql    1.0.0          1.0.0