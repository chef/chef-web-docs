.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To determine the current proxy server on the |windows| platform:

#. Open **Internet Properties**.
#. Open **Connections**.
#. Open **LAN settings**.
#. View the **Proxy server** setting. If this setting is blank, then a proxy server may not be available.

To configure proxy settings in |windows|:

#. Open **System Properties**.
#. Open **Environment Variables**.
#. Open **System variables**.
#. Set ``http_proxy`` and ``https_proxy`` to the location of your proxy server. This value **MUST** be lowercase.
