.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A recipe can define specific behaviors for specific Microsoft Windows platform versions by using a series of helper methods. To enable these helper methods, add the following to a recipe:

.. code-block:: ruby

   require 'chef/win32/version'

Then declare a variable using the ``Chef::ReservedNames::Win32::Version`` class:

.. code-block:: ruby

   variable_name = Chef::ReservedNames::Win32::Version.new

And then use this variable to define specific behaviors for specific Microsoft Windows platform versions. For example:

.. code-block:: ruby

   if variable_name.helper_name?
     # Ruby code goes here, such as
     resource_name do
       # resource block
     end
   
   elsif variable_name.helper_name?
     # Ruby code goes here
     resource_name do
       # resource block for something else
     end
   
   else variable_name.helper_name?
     # Ruby code goes here, such as
     log 'log entry' do
       level :level
     end
   
   end
