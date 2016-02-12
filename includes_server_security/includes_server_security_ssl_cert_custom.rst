.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The |chef server| can be configured to use |ssl| certificates by adding the following settings to the server configuration file:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``nginx['ssl_certificate']``
     - |ssl_certificate|
   * - ``nginx['ssl_certificate_key']``
     - |ssl_certificate key|

and then setting their values to define the paths to the certificate and key.