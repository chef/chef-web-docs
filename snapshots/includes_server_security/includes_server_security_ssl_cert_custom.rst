.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The Chef server can be configured to use SSL certificates by adding the following settings to the server configuration file:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``nginx['ssl_certificate']``
     - The SSL certificate used to verify communication over HTTPS.
   * - ``nginx['ssl_certificate_key']``
     - The certificate key used for SSL communication.

and then setting their values to define the paths to the certificate and key.
