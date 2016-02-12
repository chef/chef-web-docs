.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A registry key that should be created:

.. code-block:: ruby
       
   registry_key 'HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\...\\System' do
     values [{
       :name => 'EnableLUA',
       :type => :dword,
       :data => 0
     }]
     action :create
   end
