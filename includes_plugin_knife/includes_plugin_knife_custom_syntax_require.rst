.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The functionality of other |knife| plugins can be accessed from a plugin by using the ``require`` method to ensure the necessary files are available, and then within the code for the plugin, to create a new object of the class of the plugin to be used.

First, ensure that the correct files are available using the following syntax:

.. code-block:: ruby

   require 'chef/knife/name_of_command'

where the actual path may vary from plugin to plugin, but is typically located in the ``chef/knife/`` directory.

.. note:: Using the ``deps`` method instead of ``require`` is recommended, especially when the environment in which |knife| is being run contains a lot of plugins and/or any of those plugins have a lot of dependencies and/or requirements on other plugins and search functionality.

For example, use the following to require a plugin named ``bootstrap``:

.. code-block:: ruby

   require 'chef/knife/bootstrap'

Next, for the required plugin, create an object of that plugin, like this:

.. code-block:: ruby

   bootstrap = Chef::Knife::Bootstrap.new

and then pass arguments or options to that object. This is done by altering that object's ``config`` and ``name_arg`` variables. For example:

.. code-block:: ruby

   bootstrap.config[:ssh_user] = "myuser"
   bootstrap.config[:distro] = "ubuntu10.04-gems"
   bootstrap.config[:use_sudo] = true

   bootstrap.name_args = "some_host_name"

where the available configuration objects vary from plugin to plugin. Make sure those configuration objects are correct by verifying them in the source files for each plugin.

And then call the object's ``run`` method, like this:

.. code-block:: ruby

   bootstrap.run

