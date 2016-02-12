.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Certain settings defined by a |knife| plugin can be configured so that they can be set using the |knife rb| file. This can be done in two ways:

* By using the ``:proc`` attribute of the ``option`` method and code that references ``Chef::Config[:knife][:setting_name]``
* By specifying the configuration setting directly within the ``def`` |ruby| blocks using either ``Chef::Config[:knife][:setting_name]`` or ``config[:setting_name]``

An option that is defined in this manner may be configured using the |knife rb| file with the following syntax:

.. code-block:: ruby

   knife[:setting_name]

This approach can be useful when a particular setting is used a lot. The order of precedence for a |knife| option is:

#. A value passed via the command line
#. A value saved in the |knife rb| file
#. A default value

The following example shows how the ``knife bootstrap`` subcommand checks for a value in the |knife rb| file by using the ``:proc`` attribute:

.. code-block:: ruby

   option :ssh_port,
     :short => "-p PORT",
     :long => "--ssh-port PORT",
     :description => "The ssh port",
     :proc => Proc.new { |key| Chef::Config[:knife][:ssh_port] = key }

where ``Chef::Config[:knife][:ssh_port]`` tells |knife| to check the |knife rb| file for a setting named ``knife[:ssh_port]``.

And the following example shows the ``knife bootstrap`` subcommand calling the ``knife ssh`` subcommand for the actual |ssh| part of running a bootstrap operation:

.. code-block:: ruby

   def knife_ssh
     ssh = Chef::Knife::Ssh.new
     ssh.ui = ui
     ssh.name_args = [ server_name, ssh_command ]
     ssh.config[:ssh_user] = Chef::Config[:knife][:ssh_user] || config[:ssh_user]
     ssh.config[:ssh_password] = config[:ssh_password]
     ssh.config[:ssh_port] = Chef::Config[:knife][:ssh_port] || config[:ssh_port]
     ssh.config[:ssh_gateway] = Chef::Config[:knife][:ssh_gateway] || config[:ssh_gateway]
     ssh.config[:identity_file] = Chef::Config[:knife][:identity_file] || config[:identity_file]
     ssh.config[:manual] = true
     ssh.config[:host_key_verify] = Chef::Config[:knife][:host_key_verify] || config[:host_key_verify]
     ssh.config[:on_error] = :raise
     ssh
   end

where

* ``ssh = Chef::Knife::Ssh.new`` creates a new instance of the ``Ssh`` subclass named ``ssh``
* A series of settings in ``knife ssh`` are associated with ``knife bootstrap`` using the  ``ssh.config[:setting_name]`` syntax
* ``Chef::Config[:knife][:setting_name]`` tells |knife| to check the |knife rb| file for various settings
* Raises an exception if any aspect of the |ssh| operation fails

