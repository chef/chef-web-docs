.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A **subversion** resource block manages source control resources that exist in a Subversion repository:

.. code-block:: ruby

   subversion 'CouchDB Edge' do
     repository 'http://svn.apache.org/repos/asf/couchdb/trunk'
     revision 'HEAD'
     destination '/opt/mysources/couch'
     action :sync
   end

The full syntax for all of the properties that are available to the **subversion** resource is:

.. code-block:: ruby

   subversion 'name' do
     destination                String # defaults to 'name' if not specified
     group                      String, Integer
     notifies                   # see description
     provider                   Chef::Provider::Scm::Subversion
     repository                 String
     revision                   String
     subscribes                 # see description
     svn_arguments              String
     svn_info_args              String
     svn_password               String
     svn_username               String
     timeout                    Integer
     user                       String, Integer
     action                     Symbol # defaults to :sync if not specified
   end

where 

* ``subversion`` is the resource
* ``name`` is the name of the resource block and also (when the ``destination`` property is not specified) the location in which the source files will be placed and/or synchronized with the files under source control management
* ``:action`` identifies the steps the chef-client will take to bring the node into the desired state
* ``destination``, ``group``, ``provider``, ``repository``, ``revision``, ``svn_arguments``, ``svn_info_args``, ``svn_password``, ``svn_username``, ``timeout``, and ``user`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.
