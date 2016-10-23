.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To configure a file from a template with a variable map:

.. code-block:: ruby

   template '/tmp/config.conf' do
     source 'config.conf.erb'
     variables(
       :config_var => node['configs']['config_var']
     )
   end
