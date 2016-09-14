.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To run the ssl-benchmark example profile:

There are two ways to run the ``ssl-benchmark`` example profile to test SSL via the ``ssl`` |inspec resource|.

Clone the profile:

.. code-block:: bash

   $ git clone https://github.com/dev-sec/ssl-benchmark

and then run:

.. code-block:: bash

   $ inspec exec ssl-benchmark

Or execute the profile directly via URL:

.. code-block:: bash

   $ inspec exec https://github.com/dev-sec/ssl-benchmark
