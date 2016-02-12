.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To see if a cookbook named ``redis`` with a version number of ``0.1.6`` is frozen, enter:

.. code-block:: bash

   $ knife cookbook show redis 0.1.6 | grep frozen

If the cookbook is frozen, something like the following is returned:

.. code-block:: bash

   frozen?:        true

