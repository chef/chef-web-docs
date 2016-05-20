.. THIS PAGE DOCUMENTS chef-client version 12.5

=====================================================
About the |dsl inspec|
=====================================================

.. include:: ../../includes_dsl_inspec/includes_dsl_inspec.rst

Custom Audit Resources
=====================================================
|inspec| provides a mechanism for defining custom audit resources. These become available with their respective names and provide a simple way to extend functionality in compliance profiles.

Resource Location
-----------------------------------------------------
Resources may be added to profiles in the ``/libraries`` directory in a cookbook::

   ...
   ├── libraries
   │   └── gordon_config.rb

Resource Structure
-----------------------------------------------------
A custom audit resource takes the following form:

.. code-block:: ruby

   class Tiny < Inspec.resource(1)
     name 'tiny'
   end

Custom audit resources are written as a regular |ruby| ``class`` which inherits from ``Inspec.resource``. The number (``1``) specifies the version of |inspec| this custom audit resource targets. As |inspec| evolves, this interface may change and may require a higher version number.

Attributes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
A custom audit resource has the following attributes:

``name``
   Required. The identifier of the custom audit resource.

``desc``
   Optional. A description of the custom audit resource.

``example``
   Optional. An example usage of the custom audit resource.

Methods
+++++++++++++++++++++++++++++++++++++++++++++++++++++
A custom audit resource has the following methods are available:

``inspec``
   Contains a registry of all other resources to interact with the operating system or target in general.

``skip_resource``
   A resource may call this method to indicate that requirements aren't met. All tests that use this resource will be marked as ``skipped``.

Example
-----------------------------------------------------
The following example shows a full resource using attributes and methods to provide simple access to a configuration file:

.. code-block:: ruby

   class GordonConfig < Inspec.resource(1)
     name 'gordon_config'
   
     desc '
       Resource description ...
     '
   
     example '
       describe gordon_config do
         its("signal") { should eq "on" }
       end
     '
   
     # Load the configuration file on initialization
     def initialize(path = nil)
       @path = path || '/etc/gordon.conf'
       @params = SimpleConfig.new( read_content )
     end
   
     # Expose all parameters of the configuration file.
     def method_missing(name)
       @params[name]
     end
   
     private
   
     def read_content
       f = inspec.file(@path)
       # Test if the path exist and that it's a file
       if f.file?
         # Retrieve the file's contents
         f.content
       else
         # If the file doesn't exist, skip all tests that use gordon_config
         skip_resource "Can't read config from #{@path}."
       end
     end
   end


|ruby| Execution
=====================================================
.. include:: ../../includes_dsl_inspec/includes_dsl_inspec_ruby.rst

Debug Controls
=====================================================
.. include:: ../../includes_dsl_inspec/includes_dsl_inspec_debug.rst

Use |pry|
-----------------------------------------------------
.. include:: ../../includes_dsl_inspec/includes_dsl_inspec_debug_pry.rst

Use inspec shell
-----------------------------------------------------
.. include:: ../../includes_dsl_inspec/includes_dsl_inspec_debug_inspec_shell.rst
