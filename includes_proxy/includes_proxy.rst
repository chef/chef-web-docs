.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


In an environment that requires proxies to reach the Internet, many |chef| commands will not work until they are configured correctly. To configure |chef| to work in an environment that requires proxies, set the ``http_proxy``, ``https_proxy``, ``ftp_proxy``, and/or ``no_proxy`` environment variables to specify the proxy settings using a lowercase value.

Please be sure to consider some special cases when using the environment variables to set the proxy:

* All applications may not honor the proxy settings. For example, the proxy settings may be ignored by the underlying application when specifying a ``ftp`` source with a ``remote_file`` resource. If this happens, you may need to consider a workaround - for example, doing a ``wget`` with a ``ftp`` URL instead.
* Applications may honor the proxy settings inconsistently. For example, the behavior of the ``no_proxy`` setting may not work with certain applications when wildcards are specified. If you run into issues when using wildcards, you may need to work around by specifying the host names without wildcards.
