.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

In |chef client| 10, it is often difficult to ensure that configuration parameters are applied in the correct order. Configuration parameters should be applied in the following order:

#. Default values
#. Values set in |knife rb|
#. Values passed by command line option

Because of the way the ``mixlib-cli`` library is implemented, it is difficult to determine which values are defaults and which values are user-supplied command line options. |chef client| 11 takes advantage of a new mode for ``mixlib-cli`` that keeps default values separate from user-supplied values. In the configuration process, |knife| automatically applies configuration parameters in the following order:

#. Default values set in the ``mixlib-cli`` DSL
#. Configuration settings under ``Chef::Config[:knife]``
#. User supplied values parsed by ``mixlib-cli``

Depending on how authors of custom |knife| plugins have worked around the older behavior, it's possible that this change will lead to incorrect values being used. The |company_name|-maintained cloud plugins have been reviewed and should work correctly on both |chef client| 10 and |chef client| 11.

When writing |knife| plugins for |chef client| 11, plugin authors are encouraged to define default settings using the ``mixlib-config`` DSL, similar to:

.. code-block:: ruby

   option :ssh_user,
     :short => "-x USERNAME",
     :long => "--ssh-user USERNAME",
     :description => "The ssh username",
     :default => "root"

and then access the configurable values using the ``config`` hash with symbols, similar to:

.. code-block:: ruby

   # The local variable isn't necessary, it's just here to clarify the example:
   ssh_user_name = config[:ssh_user]

If compatibility with |chef client| 10 is required, accessing configuration parameters using a helper function like this will work correctly, but only if the default values are NOT set using the ``mixlib-cli`` DSL. For example:

.. code-block:: ruby

   def locate_config_value(key)
     key = key.to_sym
     config[key] || Chef::Config[:knife][key]
   end

Default values must be managed manually until support for |chef client| 10 is removed, for example, like this:

.. code-block:: ruby

   ssh_user_name = locate_config_value(:ssh_user) || "root"

Further information is available in the following ticket: 

* `CHEF-3497 <http://tickets.opscode.com/browse/CHEF-3497>`_  --- Allow |knife rb| to implicitly provide all |knife| related options
