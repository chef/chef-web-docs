.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To install a gem only for use in recipes:

.. code-block:: ruby

   chef_gem 'right_aws' do
     action :install
   end
   
   require 'right_aws'
