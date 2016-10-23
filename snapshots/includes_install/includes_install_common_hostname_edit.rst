.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


In some cases, the hostname for the Chef server needs to be updated. The process for updating a hostname varies, depending on the platform on which the Chef server will run. Refer to the manual for the platform or contact a local systems administrator for specific guidance for a specific platform. The following example shows how a hostname can be changed when running Red Hat or CentOS:

.. code-block:: bash

   $ sudo hostname 'mychefserver.example.com'

and then:

.. code-block:: bash

   $ echo "mychefserver.example.com" | sudo tee /etc/hostname
