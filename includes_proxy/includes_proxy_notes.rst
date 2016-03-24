.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Consider the following for situations where environment variables are used to set the proxy:

* Proxy settings may not be honored by all applications. For example, proxy settings may be ignored by the underlying application when specifying a ``ftp`` source with a ``remote_file`` resource. Consider a workaround. For example, in this situation try doing a ``wget`` with an ``ftp`` URL instead.
* Proxy settings may be honored inconsistently by applications. For example, the behavior of the ``no_proxy`` setting may not work with certain applications when wildcards are specified. Consider specifying the hostnames without using wildcards.
