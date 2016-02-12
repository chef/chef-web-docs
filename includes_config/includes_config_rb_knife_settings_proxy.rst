.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


In certain situations the proxy used by the |chef server| requires authentication. In this situation, three settings must be added to the configuration file. Which settings to add depends on the protocol used to access the |chef server|: HTTP or HTTPS.  

If the |chef server| is configured to use HTTP, add the following settings:

``http_proxy``
   |http_proxy| Default value: ``nil``. For example:

   .. code-block:: ruby

      http_proxy 'http://proxy.vmware.com:3128'

``http_proxy_user``
   |http_proxy_user| Default value: ``nil``.

``http_proxy_pass``
   |http_proxy_pass| Default value: ``nil``.

If the |chef server| is configured to use HTTPS (such as the hosted |chef server oec| server), add the following settings:

``https_proxy``
   |https_proxy| (The hosted |chef server oec| uses an HTTPS connection.) Default value: ``nil``.

``https_proxy_user``
   |https_proxy_user| Default value: ``nil``.

``https_proxy_pass``
   |https_proxy_pass| Default value: ``nil``.

Use the following setting to specify URLs that do not need a proxy:

``no_proxy``
   |no_proxy| Default value: ``nil``.
