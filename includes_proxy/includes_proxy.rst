.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


In an environment that requires proxies to reach the Internet, many |chef| commands will not work until they are configured correctly. To configure |chef| to work in an environment that requires proxies, set the ``http_proxy``, ``https_proxy``, ``ftp_proxy``, and/or ``no_proxy`` environment variables to specify the proxy settings using a lowercase value.
