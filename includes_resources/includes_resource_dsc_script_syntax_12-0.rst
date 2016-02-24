.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A |resource dsc_script| resource block embeds the code that defines a |windows powershell_dsc_short| configuration directly within a |chef| recipe:

.. code-block:: ruby

   dsc_script 'get-dsc-resource-kit' do
     code <<-EOH
       Archive reskit
       {
         ensure = 'Present'
         path = "#{Chef::Config[:file_cache_path]}\\DSCResourceKit620082014.zip"
         destination = "#{ENV['PROGRAMW6432']}\\WindowsPowerShell\\Modules"
       }
     EOH
   end

where the |resource remote_file| resource is first used to download the ``DSCResourceKit620082014.zip`` file.

The full syntax for all of the properties that are available to the |resource dsc_script| resource is:

.. code-block:: ruby

   dsc_script 'name' do
     code                       String
     command                    String
     configuration_data         String
     configuration_data_script  String
     configuration_name         String
     cwd                        String
     environment                Hash
     flags                      Hash
     notifies                   # see description
     subscribes                 # see description
     action                     Symbol # defaults to :run if not specified
   end

where 

* ``dsc_script`` is the resource
* ``name`` is the name of the resource block
* ``:action`` identifies the steps the |chef client| will take to bring the node into the desired state
* ``code``, ``command``, ``configuration_data``, ``configuration_data_script``, ``configuration_name``, ``cwd``, ``environment``, and ``flags`` are properties of this resource, with the |ruby| type shown. |see attributes|
