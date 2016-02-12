.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the following settings in the |client rb| or |knife rb| files for environments that use an FTP proxy:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``ftp_proxy``
     - The proxy server for FTP connections.
   * - ``ftp_proxy_pass``
     - The password for the proxy server when the proxy server is using an FTP connection. Default value: ``nil``.
   * - ``ftp_proxy_user``
     - The user name for the proxy server when the proxy server is using an FTP connection. Default value: ``nil``.
