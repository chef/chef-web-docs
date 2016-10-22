.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A **registry_key** resource block creates and deletes registry keys in Microsoft Windows:

.. code-block:: ruby

   registry_key "HKEY_LOCAL_MACHINE\\...\\System" do
     values [{
       :name => "NewRegistryKeyValue",
       :type => :multi_string,
       :data => ['foo\0bar\0\0']
     }]
     action :create
   end

Use multiple registry key entries with key values that are based on node attributes:

.. code-block:: ruby

   registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\name_of_registry_key' do
     values [{:name => 'key_name', :type => :string, :data => 'C:\Windows\System32\file_name.bmp'},
             {:name => 'key_name', :type => :string, :data => node['node_name']['attribute']['value']},
             {:name => 'key_name', :type => :string, :data => node['node_name']['attribute']['value']}
            ]
     action :create
   end 

The full syntax for all of the properties that are available to the **registry_key** resource is:

.. code-block:: ruby

   registry_key 'name' do
     architecture               Symbol
     key                        String # defaults to 'name' if not specified
     notifies                   # see description
     provider                   Chef::Provider::Windows::Registry
     recursive                  TrueClass, FalseClass
     subscribes                 # see description
     values                     Hash, Array
     action                     Symbol # defaults to :create if not specified
   end

where 

* ``registry_key`` is the resource
* ``name`` is the name of the resource block
* ``values`` is a hash that contains at least one registry key to be created or deleted. Each registry key in the hash is grouped by brackets in which the ``:name``, ``:type``, and ``:data`` values for that registry key are specified.
* ``:type`` represents the values available for registry keys in Microsoft Windows. Use ``:binary`` for REG_BINARY, ``:string`` for REG_SZ, ``:multi_string`` for REG_MULTI_SZ, ``:expand_string`` for REG_EXPAND_SZ, ``:dword`` for REG_DWORD, ``:dword_big_endian`` for REG_DWORD_BIG_ENDIAN, or ``:qword`` for REG_QWORD.

  .. warning:: ``:multi_string`` must be an array, even if there is only a single string.
* ``:action`` identifies the steps the chef-client will take to bring the node into the desired state
* ``architecture``, ``key``, ``provider``, ``recursive`` and ``values`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.
