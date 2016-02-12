.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``--concurrency`` option to control the number of instances that are tested concurrently on the local workstation. The default setting is to test all instances, but the practical setting depends on the capabilities of the local machine itself. The following examples will limit the number of instances to four:

.. code-block:: bash

   $ kitchen test --concurrency=4

or:

.. code-block:: bash

   $ kitchen test --concurrency 4

or:

.. code-block:: bash

   $ kitchen test -c=4

or:

.. code-block:: bash

   $ kitchen test -c 4

