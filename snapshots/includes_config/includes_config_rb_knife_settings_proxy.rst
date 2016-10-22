.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


In certain situations the proxy used by the Chef server requires authentication. In this situation, three settings must be added to the configuration file. Which settings to add depends on the protocol used to access the Chef server: HTTP or HTTPS.  

If the Chef server is configured to use HTTP, add the following settings:

``http_proxy``
   The proxy server for HTTP connections. Default value: ``nil``. For example:

   .. code-block:: ruby

      http_proxy 'http://proxy.vmware.com:3128'

``http_proxy_user``
   The user name for the proxy server when the proxy server is using an HTTP connection. Default value: ``nil``.

``http_proxy_pass``
   The password for the proxy server when the proxy server is using an HTTP connection. Default value: ``nil``.

If the Chef server is configured to use HTTPS (such as the hosted Chef server), add the following settings:

``https_proxy``
   The proxy server for HTTPS connections. (The hosted Chef server uses an HTTPS connection.) Default value: ``nil``.

``https_proxy_user``
   The user name for the proxy server when the proxy server is using an HTTPS connection. Default value: ``nil``.

``https_proxy_pass``
   The password for the proxy server when the proxy server is using an HTTPS connection. Default value: ``nil``.

Use the following setting to specify URLs that do not need a proxy:

``no_proxy``
   A comma-separated list of URLs that do not need a proxy. Default value: ``nil``.
