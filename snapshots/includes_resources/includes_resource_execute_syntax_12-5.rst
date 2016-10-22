.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A **execute** resource block typically executes a single command that is unique to the environment in which a recipe will run. Some **execute** resource commands are run by themselves, but often they are run in combination with other Chef resources. For example, a single command that is run by itself:

.. code-block:: ruby

   execute 'apache_configtest' do
     command '/usr/sbin/apachectl configtest'
   end

where ``'/usr/sbin/apachectl configtest'`` is a command that tests if the configuration files for Apache are valid.

Commands are often run in combination with other Chef resources. The following example shows the **template** resource run with the **execute** resource to add an entry to a LDAP Directory Interchange Format (LDIF) file:

.. code-block:: ruby

   execute 'slapadd' do
     command 'slapadd < /tmp/something.ldif'
     creates '/var/lib/slapd/uid.bdb'
     action :nothing
   end
   
   template '/tmp/something.ldif' do
     source 'something.ldif'
     notifies :run, 'execute[slapadd]', :immediately
   end

where

* ``'/tmp/something.ldif'`` specifies the location of the file
* ``'something.ldif'`` specifies template file from which ``/tmp/something.ldif`` is created
* ``'slapadd < /tmp/something.ldif'`` is the command that is run
* ``/var/lib/slapd/uid.bdb`` prevents the **execute** resource block from running if that file already exists

The full syntax for all of the properties that are available to the **execute** resource is:

.. code-block:: ruby

   execute 'name' do
     command                    String, Array # defaults to 'name' if not specified
     creates                    String
     cwd                        String
     environment                Hash
     group                      String, Integer
     notifies                   # see description
     path                       Array
     provider                   Chef::Provider::Execute
     returns                    Integer, Array
     sensitive                  TrueClass, FalseClass
     subscribes                 # see description
     timeout                    Integer, Float
     umask                      String, Integer
     user                       String, Integer
     action                     Symbol # defaults to :run if not specified
   end

where 

* ``execute`` is the resource
* ``name`` is the name of the resource block
* ``command`` is the command to be run
* ``:action`` identifies the steps the chef-client will take to bring the node into the desired state
* ``command``, ``creates``, ``cwd``, ``environment``, ``group``, ``path``, ``provider``, ``returns``, ``sensitive``, ``timeout``, ``user``, and ``umask`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.
