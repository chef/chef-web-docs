.. THIS PAGE IS IDENTICAL TO docs.chef.io/resource_chef_user.html BY DESIGN
.. THIS PAGE IS LOCATED AT THE /release/devkit/ PATH.

=====================================================
chef_user
=====================================================

.. warning:: .. include:: ../../includes_notes/includes_notes_provisioning.rst

Use the **chef_user** resource to manage users.

Syntax
=====================================================
The syntax for using the **chef_user** resource in a recipe is as follows:

.. code-block:: ruby

   chef_user 'value' # see properties section below
     ...
     action :action # see actions section below
   end

where 

* ``chef_user`` tells the chef-client to use the ``Chef::Provider::ChefUser`` provider during the chef-client run
* ``name`` is the name of the resource block; when the ``name`` property is not specified as part of a recipe, ``name`` is also the name of the user
* ``attribute`` is zero (or more) of the properties that are available for this resource
* ``:action`` identifies which steps the chef-client will take to bring the node into the desired state

Actions
=====================================================
This resource has the following actions:

``:create``
   Default. Use to create a user.

``:delete``
   Use to delete a user.

``:nothing``
   .. include:: ../../includes_resources_common/includes_resources_common_actions_nothing.rst

Properties
=====================================================
This resource has the following properties:
   
``admin``
   Create a client as an admin client. This is required for any user to access Open Source Chef as an administrator.
   
``chef_server``
   The URL for the Chef server.
   
``complete``
   Use to specify if this resource defines a user completely. When ``true``, any property not specified by this resource will be reset to default property values.
   
``email``
   The email address for the user.
   
``external_authentication_uid``
   ...
   
``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   Continue running a recipe if a resource fails for any reason. Default value: ``false``.
   
``name``
   The name of the user.
   
``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies_syntax.rst
   
``output_key_format``
   Use to specify the format of a public key. Possible values: ``pem``, ``der``, or ``openssh``. Default value: ``openssh``.
   
``output_key_path``
   Use to specify the path to the location in which a public key will be written.
   
``raw_json``
   The user as JSON data. For example:
       
   .. code-block:: javascript
       
      {
        "name": "Robert Forster"
      }
   
``recovery_authentication_enabled``
   ...
   
``retries``
   **Ruby Type:** Integer

   The number of times to catch exceptions and retry the resource. Default value: ``0``.
   
``retry_delay``
   **Ruby Type:** Integer

   The retry delay (in seconds). Default value: ``2``.
   
``source_key``
   Use to copy a public or private key, but apply a different ``format`` and ``password``. Use in conjunction with ``source_key_pass_phrase``` and ``source_key_path``.
   
``source_key_pass_phrase``
   The pass phrase for the public key. Use in conjunction with ``source_key``` and ``source_key_path``.
   
``source_key_path``
   The path to the public key. Use in conjunction with ``source_key``` and ``source_key_pass_phrase``.
   
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
.. .. include:: ../../includes_resources/includes_resource_chef_user_providers.rst
.. 

Examples
=====================================================
None.
