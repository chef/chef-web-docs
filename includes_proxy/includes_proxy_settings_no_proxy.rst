.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``no_proxy`` setting is used to specify addresses for which the proxy should not be used. This can be a single address or a comma-separated list of addresses.

Example:

.. code-block:: ruby

   no_proxy 'test.example.com,test.example2.com,test.example3.com'

.. note:: Wildcard matching may be used in the ``no_proxy`` list---such as ``no_proxy '*.*.example.*'``---however, many situations require hostnames to be specified explicitly (i.e. "without wildcards").
