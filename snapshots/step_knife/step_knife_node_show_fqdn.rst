.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To view the FQDN for a node named ``i-12345678``, enter:

.. code-block:: bash

   $ knife node show i-12345678 -a fqdn

to return:

.. code-block:: bash

   fqdn: ip-10-251-75-20.ec2.internal
