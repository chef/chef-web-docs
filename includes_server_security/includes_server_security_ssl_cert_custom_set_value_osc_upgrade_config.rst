.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To specify the directory in which the |ssl| certificates are located, add the following settings and values to the |chef server rb| file:

.. code-block:: ruby

   nginx['ssl_certificate']  = "/path/to/existing/your-host.crt"
   nginx['ssl_certificate_key']  = "/path/to/existing/your-host.key"

Save the file, and then run the following command:

.. code-block:: bash

   $ sudo chef-server-ctl reconfigure
