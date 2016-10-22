.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A custom provider can extend another provider class. This can be done as a ``mixin``, which is then placed in a library under the ``library/`` directory of any cookbook that will use the extended provider class. The custom provider is then written to include that library in its implementation so that it has access to the extended platform resource. Use the ``include`` method in the custom provider to ensure that a custom provider has access to an external library.

For example:

.. code-block:: ruby

   include Chef::Mixin::ShellOut
