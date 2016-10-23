.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. This topic is hooked into client.rb topics, starting with 12.1, in addition to the resource reference pages.

To suppress warnings for cookbooks authored prior to chef-client 12.1, use a ``respond_to?`` check to ensure backward compatibility. For example:

.. code-block:: ruby

   chef_gem 'aws-sdk' do
     compile_time false if respond_to?(:compile_time)
   end
