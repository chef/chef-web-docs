.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


For example:

.. code-block:: ruby

   nginx['ssl_certificate']  = "/etc/pki/tls/certs/your-host.crt"
   nginx['ssl_certificate_key']  = "/etc/pki/tls/private/your-host.key"

Save the file, and then run the following command:

.. code-block:: bash

   $ sudo chef-server-ctl reconfigure
