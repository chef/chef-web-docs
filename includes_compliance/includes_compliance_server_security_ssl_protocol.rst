.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The |chef compliance| server can be configured to use |ssl| certificates by adding the following settings in the server configuration file located at ``/etc/chef-compliance/chef-compliance.rb``:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``ssl['certificate']``
     - |ssl_certificate|
   * - ``ssl['certificate_key']``
     - |ssl_certificate key|

and then setting their values to define the paths to the certificate and key.

For example:

.. code-block:: ruby

   ssl['certificate']  = "/etc/pki/tls/certs/your-host.crt"
   ssl['certificate_key']  = "/etc/pki/tls/private/your-host.key"

Save the file, and then run the following command:

.. code-block:: bash

   $ sudo chef-compliance-ctl reconfigure
