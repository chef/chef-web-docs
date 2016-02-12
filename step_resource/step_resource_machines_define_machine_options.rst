.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


.. To define machine options:

.. code-block:: ruby

   require 'chef/provisioning_driver'
   
   machine 'wario' do
     recipe 'apache'
   
     machine_options :driver_options => {
      :base_image => {
        :name => 'ubuntu',
        :repository => 'ubuntu',
        :tag => '14.04'
        },
   
      :command => '/usr/sbin/httpd'
     }
   
   end

where ``provisioning_driver`` and ``:driver_options`` specify the actual ``driver`` that is being used to build the machine.
