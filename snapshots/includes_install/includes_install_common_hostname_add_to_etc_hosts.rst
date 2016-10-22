.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


If a hostname is not resolvable, refer to a local systems administrator for specific guidance on how to add the hostname to the DNS system. If the Chef server is being into a testing environment, just add the hostname to ``/etc/hosts``. The following example shows how a hostname can be added to ``/etc/hosts`` when running Red Hat or CentOS:

.. code-block:: bash

   $ echo -e "127.0.0.2 `hostname` `hostname -s`" | sudo tee -a /etc/hosts
