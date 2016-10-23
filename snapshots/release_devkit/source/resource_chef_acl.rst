.. THIS PAGE IS IDENTICAL TO docs.chef.io/resource_chef_acl.html BY DESIGN
.. THIS PAGE IS LOCATED AT THE /release/devkit/ PATH.

=====================================================
chef_acl
=====================================================

.. warning:: .. include:: ../../includes_notes/includes_notes_provisioning.rst

.. include:: ../../includes_chef_client/includes_chef_client.rst

Use the **chef_acl** resource to interact with access control lists (ACLs) that exist on the Chef server.

Syntax
=====================================================
The syntax for using the **chef_acl** resource in a recipe is as follows:

.. code-block:: ruby

   chef_acl 'name' do
     attribute 'value' # see properties section below
     ...
     action :action # see actions section below
   end

where 

* ``chef_acl`` tells the chef-client to use the ``Chef::Provider::ChefAcl`` provider during the chef-client run
* ``name`` is the name of the resource block; when the ``path`` property is not specified as part of a recipe, ``name`` is also the name of the chef-client
* ``attribute`` is zero (or more) of the properties that are available for this resource
* ``:action`` identifies which steps the chef-client will take to bring the node into the desired state

Actions
=====================================================
This resource has the following actions:

``:create``
   Default.

``:nothing``
   .. include:: ../../includes_resources_common/includes_resources_common_actions_nothing.rst

Properties
=====================================================
This resource has the following properties:

``chef_server``
   The URL for the Chef server.

``complete``
   Use to specify if this resource defines a chef-client completely. When ``true``, any property not specified by this resource will be reset to default property values.

``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   Continue running a recipe if a resource fails for any reason. Default value: ``false``.

``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies_syntax.rst

``path``
   A path to a directory in the chef-repo against which the ACL is applied. For example: ``nodes``, ``nodes/*``, ``nodes/my_node``, ``*/*``, ``**``, ``roles/base``, ``data/secrets``, ``cookbooks/apache2``, ``/users/*``, and so on.

``raw_json``
   The chef-client as JSON data. For example:

   .. code-block:: javascript
       
      {
        "clientname": "client_name",
        "orgname": "org_name",
        "validator": false,
        "certificate": "-----BEGIN CERTIFICATE-----\n
                        ...
                        1234567890abcdefghijklmnopq\n
                        ...
                        -----END CERTIFICATE-----\n",
        "name": "node_name"
      }

``recursive``
   Use to apply changes to child objects. Use ``:on_change`` to apply changes to child objects only if the parent object changes. Set to ``true`` to apply changes even if the parent object does not change. Set to ``false`` to prevent any changes. Default value: ``:on_change``.

``remove_rights``
   Use to remove rights. For example:
       
   .. code-block:: ruby
       
      remove_rights :read, :users => 'jkeiser', :groups => [ 'admins', 'users' ]

   or:
       
   .. code-block:: ruby
       
      remove_rights [ :create, :read ], :users => [ 'jkeiser', 'adam' ]

   or:
       
   .. code-block:: ruby
       
      remove_rights :all, :users => [ 'jkeiser', 'adam' ]

``retries``
   **Ruby Type:** Integer

   The number of times to catch exceptions and retry the resource. Default value: ``0``.

``retry_delay``
   **Ruby Type:** Integer

   The retry delay (in seconds). Default value: ``2``.

``rights``
   Use to add rights. Syntax: ``:right, :right => 'user', :groups => [ 'group', 'group']``. For example:
       
   .. code-block:: ruby
       
      rights :read, :users => 'jkeiser', :groups => [ 'admins', 'users' ]

   or:
       
   .. code-block:: ruby
       
      rights [ :create, :read ], :users => [ 'jkeiser', 'adam' ]

   or:
       
   .. code-block:: ruby
       
      rights :all, :users => 'jkeiser'

``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes_syntax.rst

.. 
.. Providers
.. =====================================================
.. .. include:: ../../includes_resources_common/includes_resources_common_provider.rst
.. 
.. .. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst
.. 
.. .. include:: ../../includes_resources/includes_resource_chef_acl_providers.rst
.. 

Examples
=====================================================
None.
