.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To change the directory in which plugins are located edit the attributes file in the ``ohai`` cookbook for the ``node[:ohai][:plugin_path]`` attribute. Change the value to the desired directory path. For example:

.. code-block:: ruby

   default[:ohai][:plugin_path] = "/etc/chef/ohai_plugins"
